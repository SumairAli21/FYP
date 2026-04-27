import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/services/auth_service.dart';
import 'package:englify_app/services/cloudniry_service.dart';
import 'package:englify_app/services/firestore_keys.dart';

class ProfileService {
  final _firestore = FirebaseFirestore.instance;
  final _authservice = locator<AuthService>();
  final _cloudinary = locator<CloudinaryService>();

  // ── Upload profile image using existing CloudinaryService
  Future<String?> uploadProfileImage(File imageFile) async {
    try {
      final user = await _authservice.currentuser;
      if (user == null) return null;

      final timestamp =
          DateTime.now().millisecondsSinceEpoch.toString();

      // Reuse same pattern as classroom/lesson uploads
      final url = await _cloudinary.uploadProfilePicture(
        imageFile: imageFile,
        userId: user.uid,
      );

      return url;
    } catch (e) {
      print('Failed to upload profile image: $e');
      return null;
    }
  }

  // ── Save profile to Firestore
  Future<void> saveProfile({
    String? imageUrl,
    String? location,
  
  }) async {
    try {
      final user = await _authservice.currentuser;
      if (user == null) return;

      final Map<String, dynamic> data = {};
      if (imageUrl != null) data['profileImageUrl'] = imageUrl;
      if (location != null) data['location'] = location;


      await _firestore
          .collection(FirestoreKeys.users)
          .doc(user.uid)
          .set(data, SetOptions(merge: true));
    } catch (e) {
      print('Failed to save profile: $e');
    }
  }

  // ── Fetch profile
  Future<Map<String, dynamic>?> getProfile() async {
    try {
      final user = await _authservice.currentuser;
      if (user == null) return null;

      final doc = await _firestore
          .collection(FirestoreKeys.users)
          .doc(user.uid)
          .get();

      return doc.data();
    } catch (e) {
      print('Failed to get profile: $e');
      return null;
    }
  }

  // ── Check Google account
  Future<bool> isGoogleAccount() async {
    final user = await _authservice.currentuser;
    if (user == null) return false;
    return user.providerData
        .any((info) => info.providerId == 'google.com');
  }

  // ── Level based on quiz attempts
  int calculateLevel(int attempts) {
    if (attempts < 2) return 1;
    if (attempts < 6) return 2;
    if (attempts < 14) return 3;
    if (attempts < 30) return 4;
    return 5;
  }

  // ── Total quiz attempts
  Future<int> getTotalQuizAttempts() async {
    try {
      final user = await _authservice.currentuser;
      if (user == null) return 0;

      final snapshot = await _firestore
          .collection(FirestoreKeys.users)
          .doc(user.uid)
          .collection('quizResults')
          .get();

      return snapshot.docs.length;
    } catch (e) {
      return 0;
    }
  }
}