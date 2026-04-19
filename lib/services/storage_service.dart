import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// Upload classroom image to Firebase Storage
  /// Returns the download URL
  Future<String> uploadClassroomImage({
    required File imageFile,
    required String classId,
  }) async {
    try {
      print("📤 Uploading image for class: $classId");
      
      // Create a unique file path
      final String fileName = 'classroom_${classId}_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final Reference storageRef = _storage.ref().child('classroom_images/$fileName');

      // Upload the file
      final UploadTask uploadTask = storageRef.putFile(imageFile);
      
      // Wait for upload to complete
      final TaskSnapshot snapshot = await uploadTask;
      
      // Get the download URL
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      
      print("✅ Image uploaded successfully: $downloadUrl");
      return downloadUrl;
      
    } catch (e) {
      print("❌ Error uploading image: $e");
      throw Exception("Failed to upload image: $e");
    }
  }

  /// Delete classroom image from Firebase Storage
  Future<void> deleteClassroomImage(String imageUrl) async {
    try {
      final Reference storageRef = _storage.refFromURL(imageUrl);
      await storageRef.delete();
      print("✅ Image deleted successfully");
    } catch (e) {
      print("❌ Error deleting image: $e");
    }
  }
}