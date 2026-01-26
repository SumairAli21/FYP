import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final _users = FirebaseFirestore.instance.collection("users");
  Future<void> createuser({
    required String email,
    required String uid,
    required String role,
  }) async {
    await _users.doc(uid).set({
      'email': email,
      'role': role,
      'createdat': FieldValue.serverTimestamp(),
    });
  }

  Future<String?> getUserrole(String uid) async {
    final doc = await _users.doc(uid).get();
   return await doc.data()?['role'];
  }
}
