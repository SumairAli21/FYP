import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/services/auth_service.dart';
import 'package:englify_app/services/firestore_keys.dart';

class PointsService {
  final _firestore = FirebaseFirestore.instance;
  final _authservice = locator<AuthService>();

  Future<int> gettotalcoin() async {
    try {
      final user = _authservice.currentuser;
      if (user == null) return 0;
      final doc = await _firestore
          .collection(FirestoreKeys.users)
          .doc(user.uid)
          .get();
      return (doc.data()?['totalCoins'] as num?)?.toInt() ?? 0;
    } catch (e) {
      print('❌ failed to get user points: $e');
      return 0;
    }
  }

  Future<int?> getquizpoints(String lessonid) async {
    try {
      final user = _authservice.currentuser;
      if (user == null) return null;
      final doc = await _firestore
          .collection(FirestoreKeys.users)
          .doc(user.uid)
          .collection('quizResults')
          .doc(lessonid)
          .get();
      if (!doc.exists) return null;
      return (doc.data()?['score'] as num?)?.toInt();
    } catch (e) {
      print('❌ failed to get student quiz score: $e');
      return null;
    }
  }

  /// Saves quiz result in TWO places:
  ///
  /// 1. users/{studentId}/quizResults/{lessonId}
  ///    → student's own record
  ///
  /// 2. lessons/{lessonId}/quizResults/{studentId}
  ///    → teacher dashboard reads from here
  ///    (lessons are top-level collection with classId field)
  Future<void> savequizresult({
    required String lessonId,
    required String classId,
    required int score,
    required int totalPoints,
  }) async {
    try {
      final user = _authservice.currentuser;
      if (user == null) {
        print('❌ savequizresult: user is null');
        return;
      }
      final studentId = user.uid;
      final now = FieldValue.serverTimestamp();

      // ── 1. Student's own record (for student-side display)
      await _firestore
          .collection(FirestoreKeys.users)
          .doc(studentId)
          .collection('quizResults')
          .doc(lessonId)
          .set({
        'lessonId': lessonId,
        'classId': classId,
        'score': score,
        'totalPoints': totalPoints,
        'attemptedAt': now,
        'attemptCount': FieldValue.increment(1),
      }, SetOptions(merge: true));

      // ── 2. Top-level lessons/{lessonId}/quizResults/{studentId}
      //    DashboardService reads quizResults from this path
      await _firestore
          .collection(FirestoreKeys.lessons)
          .doc(lessonId)
          .collection('quizResults')
          .doc(studentId)
          .set({
        'studentId': studentId,
        'lessonId': lessonId,
        'classId': classId,
        'score': score,
        'totalPoints': totalPoints,
        'attemptedAt': now,
        'attemptCount': FieldValue.increment(1),
      }, SetOptions(merge: true));

      // ── 3. Update student total coins
      await _firestore
          .collection(FirestoreKeys.users)
          .doc(studentId)
          .set({'totalCoins': FieldValue.increment(score)},
              SetOptions(merge: true));

      print('✅ Quiz saved — student: $studentId | score: $score/$totalPoints');
    } catch (e) {
      print('❌ Failed to save quiz result: $e');
    }
  }

  Future<bool> isquizattempted(String lessonid) async {
    try {
      final user = _authservice.currentuser;
      if (user == null) return false;
      final doc = await _firestore
          .collection(FirestoreKeys.users)
          .doc(user.uid)
          .collection('quizResults')
          .doc(lessonid)
          .get();
      return doc.exists;
    } catch (e) {
      return false;
    }
  }
}