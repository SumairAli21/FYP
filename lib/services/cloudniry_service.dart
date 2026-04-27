import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';

class CloudinaryService {
  // ✅ Your Cloudinary credentials
  static const String cloudName = 'dkswfrmz0';
  static const String apiKey = '122888724262782';
  static const String apiSecret = '9WgILzL2V5AkDX2QWtpABBK-Qic';
  static const String uploadUrl =
      'https://api.cloudinary.com/v1_1/$cloudName/image/upload';
  static const String rawUploadUrl =
      'https://api.cloudinary.com/v1_1/$cloudName/raw/upload';

  Future<String> uploadClassroomImage({
    required File imageFile,
    required String classId,
  }) async {
    try {
      print("\n📤 ===== CLOUDINARY UPLOAD STARTED =====");
      print("📂 File path: ${imageFile.path}");

      // Check file exists
      if (!await imageFile.exists()) {
        throw Exception("Image file not found at: ${imageFile.path}");
      }

      final fileSize = await imageFile.length();
      print("📊 File size: ${(fileSize / 1024).toStringAsFixed(2)} KB");

      // Read file as bytes
      final bytes = await imageFile.readAsBytes();

      // Generate timestamp
      final timestamp = (DateTime.now().millisecondsSinceEpoch ~/ 1000)
          .toString();

      // Prepare upload parameters
      final folder = 'englify_classrooms';
      final publicId = 'class_$classId';

      // Create signature string
      final paramsToSign =
          'folder=$folder&public_id=$publicId&timestamp=$timestamp';
      final stringToSign = '$paramsToSign$apiSecret';

      // Generate SHA-1 signature
      final signatureBytes = utf8.encode(stringToSign);
      final digest = sha1.convert(signatureBytes);
      final signature = digest.toString();

      print("🔐 Signature generated");
      print("⏳ Uploading...");

      // Create multipart request
      final request = http.MultipartRequest('POST', Uri.parse(uploadUrl));

      // Add file
      request.files.add(
        http.MultipartFile.fromBytes(
          'file',
          bytes,
          filename: 'classroom_$classId.jpg',
        ),
      );

      // Add fields
      request.fields['api_key'] = apiKey;
      request.fields['timestamp'] = timestamp;
      request.fields['signature'] = signature;
      request.fields['folder'] = folder;
      request.fields['public_id'] = publicId;

      // Send request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print("📡 Response status: ${response.statusCode}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final imageUrl = data['secure_url'] as String;

        print("✅ Upload successful!");
        print("🔗 URL: $imageUrl");
        print("===== UPLOAD COMPLETED =====\n");

        return imageUrl;
      } else {
        print("❌ Upload failed!");
        print("Response: ${response.body}");
        throw Exception("Upload failed with status ${response.statusCode}");
      }
    } catch (e) {
      print("❌ Upload error: $e");
      print("===== UPLOAD FAILED =====\n");
      throw Exception("Failed to upload image: $e");
    }
  }

  Future<void> deleteImage(String imageUrl) async {
    try {
      print("🗑️ Image deletion requested: $imageUrl");
      // Optional: Implement deletion if needed
      print("✅ Deletion logged");
    } catch (e) {
      print("❌ Delete error: $e");
    }
  }

  Future<String> uploadLessonImage({
    required File imageFile,
    required String lessonId,
  }) async {
    try {
      print("\n📤 ===== LESSON IMAGE UPLOAD STARTED =====");

      if (!await imageFile.exists()) {
        throw Exception("Image file not found at: ${imageFile.path}");
      }

      final bytes = await imageFile.readAsBytes();
      final timestamp = (DateTime.now().millisecondsSinceEpoch ~/ 1000)
          .toString();

      const folder = 'englify_lessons';
      final publicId = 'lesson_img_$lessonId';

      final paramsToSign =
          'folder=$folder&public_id=$publicId&timestamp=$timestamp';
      final stringToSign = '$paramsToSign$apiSecret';
      final digest = sha1.convert(utf8.encode(stringToSign));
      final signature = digest.toString();

      final request = http.MultipartRequest('POST', Uri.parse(uploadUrl));
      request.files.add(
        http.MultipartFile.fromBytes(
          'file',
          bytes,
          filename: 'lesson_img_$lessonId.jpg',
        ),
      );
      request.fields['api_key'] = apiKey;
      request.fields['timestamp'] = timestamp;
      request.fields['signature'] = signature;
      request.fields['folder'] = folder;
      request.fields['public_id'] = publicId;

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final imageUrl = data['secure_url'] as String;
        print("✅ Lesson image uploaded: $imageUrl");
        print("===== LESSON IMAGE UPLOAD COMPLETED =====\n");
        return imageUrl;
      } else {
        throw Exception(
          "Upload failed with status ${response.statusCode}: ${response.body}",
        );
      }
    } catch (e) {
      print("❌ Lesson image upload error: $e");
      throw Exception("Failed to upload lesson image: $e");
    }
  }

  // ── Profile picture upload
  Future<String> uploadProfilePicture({
    required File imageFile,
    required String userId,
  }) async {
    try {
      print("\n📤 ===== PROFILE IMAGE UPLOAD STARTED =====");

      if (!await imageFile.exists()) {
        throw Exception("Image file not found");
      }

      final bytes = await imageFile.readAsBytes();
      final timestamp = (DateTime.now().millisecondsSinceEpoch ~/ 1000)
          .toString();

      const folder = 'user/userprofile/profileimage';
      final publicId = 'profile_$userId';

      final paramsToSign =
          'folder=$folder&public_id=$publicId&timestamp=$timestamp';
      final stringToSign = '$paramsToSign$apiSecret';
      final digest = sha1.convert(utf8.encode(stringToSign));
      final signature = digest.toString();

      final request = http.MultipartRequest('POST', Uri.parse(uploadUrl));
      request.files.add(
        http.MultipartFile.fromBytes(
          'file',
          bytes,
          filename: 'profile_$userId.jpg',
        ),
      );
      request.fields['api_key'] = apiKey;
      request.fields['timestamp'] = timestamp;
      request.fields['signature'] = signature;
      request.fields['folder'] = folder;
      request.fields['public_id'] = publicId;

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final imageUrl = data['secure_url'] as String;
        print("✅ Profile image uploaded: $imageUrl");
        return imageUrl;
      } else {
        throw Exception(
          "Upload failed: ${response.statusCode}: ${response.body}",
        );
      }
    } catch (e) {
      print("❌ Profile image upload error: $e");
      throw Exception("Failed to upload profile image: $e");
    }
  }

  // ─────────────────────────────────────────
  // 2️⃣  Lesson CONTENT FILE upload (PDF, doc, etc.)
  // ─────────────────────────────────────────
  Future<String> uploadLessonContent({
    required File contentFile,
    required String lessonId,
    required String fileExtension,
  }) async {
    try {
      print("\n📤 ===== LESSON CONTENT UPLOAD STARTED =====");

      if (!await contentFile.exists()) {
        throw Exception("Content file not found at: ${contentFile.path}");
      }

      final bytes = await contentFile.readAsBytes();
      final timestamp = (DateTime.now().millisecondsSinceEpoch ~/ 1000)
          .toString();

      const folder = 'englify_lessons_content';
      final publicId = 'lesson_content_$lessonId';

      // Use raw upload for PDFs/docs, image upload for images
      final isImage = [
        'jpg',
        'jpeg',
        'png',
        'gif',
        'webp',
      ].contains(fileExtension.toLowerCase());
      final endpoint = isImage ? uploadUrl : rawUploadUrl;

      final paramsToSign =
          'folder=$folder&public_id=$publicId&timestamp=$timestamp';
      final stringToSign = '$paramsToSign$apiSecret';
      final digest = sha1.convert(utf8.encode(stringToSign));
      final signature = digest.toString();

      final request = http.MultipartRequest('POST', Uri.parse(endpoint));
      request.files.add(
        http.MultipartFile.fromBytes(
          'file',
          bytes,
          filename: 'lesson_content_$lessonId.$fileExtension',
        ),
      );
      request.fields['api_key'] = apiKey;
      request.fields['timestamp'] = timestamp;
      request.fields['signature'] = signature;
      request.fields['folder'] = folder;
      request.fields['public_id'] = publicId;

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final contentUrl = data['secure_url'] as String;
        print("✅ Lesson content uploaded: $contentUrl");
        print("===== LESSON CONTENT UPLOAD COMPLETED =====\n");
        return contentUrl;
      } else {
        throw Exception(
          "Upload failed with status ${response.statusCode}: ${response.body}",
        );
      }
    } catch (e) {
      print("❌ Lesson content upload error: $e");
      throw Exception("Failed to upload lesson content: $e");
    }
  }
}
