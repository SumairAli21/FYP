/**
 * Englify — FCM fan-out Cloud Functions.
 *
 * The Flutter client never sends pushes itself; it only writes Firestore docs
 * (lessons, quizzes, quiz results) and stores device tokens. These triggers
 * react to those writes and deliver notifications via the Admin SDK, so no
 * credentials ever ship inside the app.
 *
 * Notification flows:
 *   1. Teacher adds a lesson  -> all students of that class are notified.
 *   2. Teacher adds a quiz    -> all students of that class are notified.
 *   3. Student submits a quiz -> the lesson's teacher is notified.
 *
 * Firestore structure used (already present in the app):
 *   users/{uid}                                   .name .email .role
 *   users/{uid}/fcmTokens/{tokenHash}             .token .platform .updatedAt
 *   classes/{classId}                             .name .teacherId
 *   classes/{classId}/members/{userId}            .userId .role
 *   lessons/{lessonId}                            .classId .teacherId .title
 *   classes/{classId}/lessons/{lessonId}/quizzes/{quizId}   .lessonTitle
 *   lessons/{lessonId}/quizResults/{studentId}    .classId .score .totalPoints
 */

const {
  onDocumentCreated,
  onDocumentWritten,
} = require("firebase-functions/v2/firestore");
const { setGlobalOptions } = require("firebase-functions/v2");
const { logger } = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

// Keep cold-start cost bounded.
setGlobalOptions({ maxInstances: 10, region: "us-central1" });

const db = admin.firestore();
const messaging = admin.messaging();

// Must match the channel created by NotificationService + AndroidManifest.xml.
const CHANNEL_ID = "englify_high_importance";

/* ───────────────────────────── Token helpers ───────────────────────────── */

/**
 * Returns every stored token for a user as { token, uid, docId } objects so
 * dead tokens can be pruned after a failed send.
 */
async function tokenDocsForUser(uid) {
  if (!uid) return [];
  const snap = await db
    .collection("users")
    .doc(uid)
    .collection("fcmTokens")
    .get();
  return snap.docs
    .map((d) => ({ token: d.get("token"), uid, docId: d.id }))
    .filter((t) => !!t.token);
}

/**
 * Returns token objects for every *student* member of a class.
 */
async function tokenDocsForClassStudents(classId) {
  if (!classId) return [];
  const members = await db
    .collection("classes")
    .doc(classId)
    .collection("members")
    .where("role", "==", "student")
    .get();

  const lists = await Promise.all(
    members.docs.map((m) => tokenDocsForUser(m.get("userId") || m.id))
  );
  return lists.flat();
}

/**
 * Sends one notification to a set of token objects and prunes any token that
 * FCM reports as permanently invalid.
 *
 * @param {Array<{token:string,uid:string,docId:string}>} tokenDocs
 * @param {{title:string, body:string, data?:Object}} payload
 */
async function sendToTokenDocs(tokenDocs, payload) {
  // De-duplicate by token string (same device may appear via several members).
  const byToken = new Map();
  for (const t of tokenDocs) {
    if (t.token) byToken.set(t.token, t);
  }
  const entries = [...byToken.values()];

  if (entries.length === 0) {
    logger.info("No device tokens to notify — skipping.");
    return;
  }

  // FCM data values must be strings.
  const data = {};
  for (const [k, v] of Object.entries(payload.data || {})) {
    data[k] = v == null ? "" : String(v);
  }

  const tokens = entries.map((e) => e.token);
  const response = await messaging.sendEachForMulticast({
    tokens,
    notification: { title: payload.title, body: payload.body },
    data,
    android: {
      priority: "high",
      notification: { channelId: CHANNEL_ID, sound: "default" },
    },
    apns: {
      payload: { aps: { sound: "default" } },
    },
  });

  logger.info(
    `FCM sent: ${response.successCount} ok, ${response.failureCount} failed.`
  );

  // Prune tokens that are no longer valid.
  const deletions = [];
  response.responses.forEach((res, i) => {
    if (res.success) return;
    const code = res.error && res.error.code;
    if (
      code === "messaging/registration-token-not-registered" ||
      code === "messaging/invalid-registration-token" ||
      code === "messaging/invalid-argument"
    ) {
      const e = entries[i];
      deletions.push(
        db
          .collection("users")
          .doc(e.uid)
          .collection("fcmTokens")
          .doc(e.docId)
          .delete()
          .catch(() => {})
      );
    }
  });
  await Promise.all(deletions);
}

/* ──────────────────────── Flow 1: lesson added ──────────────────────── */

exports.onLessonCreated = onDocumentCreated(
  "lessons/{lessonId}",
  async (event) => {
    const snap = event.data;
    if (!snap) return;

    const lesson = snap.data() || {};
    const classId = lesson.classId;
    if (!classId) {
      logger.warn(`Lesson ${event.params.lessonId} has no classId — skipping.`);
      return;
    }

    const classDoc = await db.collection("classes").doc(classId).get();
    const className =
      (classDoc.exists && classDoc.get("name")) || "your class";
    const lessonTitle = lesson.title || "A new lesson";

    const tokenDocs = await tokenDocsForClassStudents(classId);
    await sendToTokenDocs(tokenDocs, {
      title: "📚 New Lesson Added",
      body: `${lessonTitle} was added to ${className}.`,
      data: {
        type: "lesson",
        classId: classId,
        lessonId: event.params.lessonId,
      },
    });
  }
);

/* ───────────────────────── Flow 2: quiz added ───────────────────────── */

exports.onQuizCreated = onDocumentCreated(
  "classes/{classId}/lessons/{lessonId}/quizzes/{quizId}",
  async (event) => {
    const snap = event.data;
    if (!snap) return;

    const quiz = snap.data() || {};
    const classId = event.params.classId;
    const lessonId = event.params.lessonId;

    const classDoc = await db.collection("classes").doc(classId).get();
    const className =
      (classDoc.exists && classDoc.get("name")) || "your class";
    const lessonTitle = quiz.lessonTitle || "a lesson";

    const tokenDocs = await tokenDocsForClassStudents(classId);
    await sendToTokenDocs(tokenDocs, {
      title: "📝 New Quiz Available",
      body: `A quiz for "${lessonTitle}" is ready in ${className}.`,
      data: {
        type: "quiz",
        classId: classId,
        lessonId: lessonId,
      },
    });
  }
);

/* ─────────────────── Flow 3: student submits a quiz ─────────────────── */

exports.onQuizSubmitted = onDocumentWritten(
  "lessons/{lessonId}/quizResults/{studentId}",
  async (event) => {
    const after = event.data && event.data.after;
    if (!after || !after.exists) return; // ignore deletes

    const result = after.data() || {};
    const lessonId = event.params.lessonId;
    const studentId = event.params.studentId;

    // The top-level lesson doc holds the owning teacher + title.
    const lessonDoc = await db.collection("lessons").doc(lessonId).get();
    if (!lessonDoc.exists) {
      logger.warn(`Lesson ${lessonId} missing — cannot notify teacher.`);
      return;
    }
    const teacherId = lessonDoc.get("teacherId");
    const lessonTitle = lessonDoc.get("title") || "a lesson";
    if (!teacherId) return;

    // Resolve a friendly student name.
    const studentDoc = await db.collection("users").doc(studentId).get();
    const studentName =
      (studentDoc.exists &&
        (studentDoc.get("name") || studentDoc.get("email"))) ||
      "A student";

    const score = result.score != null ? result.score : 0;
    const total = result.totalPoints != null ? result.totalPoints : 100;

    const tokenDocs = await tokenDocsForUser(teacherId);
    await sendToTokenDocs(tokenDocs, {
      title: "✅ Quiz Submitted",
      body: `${studentName} scored ${score}/${total} on "${lessonTitle}".`,
      data: {
        type: "quiz_result",
        lessonId: lessonId,
        classId: result.classId || "",
        studentId: studentId,
      },
    });
  }
);
