import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/services/auth_service.dart';
import 'package:englify_app/services/firestore_keys.dart';
import 'package:firebase_core/firebase_core.dart';

class PointsService {
  final _firestore = FirebaseFirestore.instance;
  final _authservice = locator<AuthService>();

  Future<int> gettotalcoin() async {
    try {
      final user = await _authservice.currentuser;
      if (user == null) {
        return 0;
      }
      final doc = await _firestore
          .collection(FirestoreKeys.users)
          .doc(user.uid)
          .get();
      return (doc.data()?['totalCoins'] ?? 0) as int;
    } catch (e) {
      print('faild to get user points');
      return 0;
    }
  }

  Future<int?> getquizpoints(String lessonid) async {
  try {
    final user = await _authservice.currentuser;
    if (user == null) return null; // ← null
    final doc = await _firestore
        .collection(FirestoreKeys.users)
        .doc(user.uid)
        .collection('quizResults')
        .doc(lessonid)
        .get();
    if (!doc.exists) return null; // ← null
    return (doc.data()?['score'] ?? 0) as int;
  } catch (e) {
    print('faild to get student quiz score');
    return null; // ← null, 0 nahi
  }
}

  Future<void> savequizresult({
    required String lessonId,
    required String classId,
    required int score,
    required int totalPoints,
  }) async {
    try {
      final user = await _authservice.currentuser;
      if (user == null) return;

      final userRef = _firestore.collection(FirestoreKeys.users).doc(user.uid);

      await userRef.collection('quizResults').doc(lessonId).set({
        'lessonId': lessonId,
        'classId': classId,
        'score': score,
        'totalPoints': totalPoints,
        'attemptedAt': FieldValue.serverTimestamp(),
      });
      await userRef.set({
        'totalCoins': FieldValue.increment(score),
      }, SetOptions(merge: true));
    } catch (e) {
      print('failed to save quiz prints');
    }
  }

  Future<bool> isquizattempted(String lessonid) async {
    try {
      final user = await _authservice.currentuser;
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
