# Englify — FCM Cloud Functions

Server-side notification fan-out for the Englify app. The Flutter client only
writes Firestore documents and stores device tokens; these functions deliver
the actual pushes, so no admin credentials ever ship inside the APK.

## Functions

| Function          | Trigger                                                        | Notifies                  |
| ----------------- | -------------------------------------------------------------- | ------------------------- |
| `onLessonCreated` | `lessons/{lessonId}` created                                   | All students of the class |
| `onQuizCreated`   | `classes/{classId}/lessons/{lessonId}/quizzes/{quizId}` created| All students of the class |
| `onQuizSubmitted` | `lessons/{lessonId}/quizResults/{studentId}` written           | The lesson's teacher      |

## Prerequisites

- Firebase project on the **Blaze (pay-as-you-go)** plan — Cloud Functions v2
  cannot deploy on the free Spark plan.
- Firebase CLI: `npm install -g firebase-tools`
- Node.js 20 installed locally.

## Deploy

```bash
# from the project root (where firebase.json lives)
firebase login
cd functions
npm install
cd ..
firebase deploy --only functions
```

The first deploy enables the required Google Cloud APIs automatically
(Cloud Functions, Cloud Build, Artifact Registry, Eventarc).

## Logs

```bash
firebase functions:log
```

## Notes

- Device tokens are read from `users/{uid}/fcmTokens/*`. Tokens that FCM
  reports as permanently invalid are pruned automatically after a failed send.
- `onQuizSubmitted` uses `onDocumentWritten` so re-attempts also notify the
  teacher (the result doc id is the studentId, so a re-attempt is an update,
  not a create).
