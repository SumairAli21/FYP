import 'dart:io';
import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/services/auth_service.dart';
import 'package:englify_app/services/cloudniry_service.dart';
import 'package:englify_app/services/online_DB_service.dart';
import 'package:englify_app/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ClassroomCreateViewmodel extends BaseViewModel {
  final _navigationservice = locator<NavigationService>();
  final _classroomservice = locator<classroomservice>();
  final _authservice = locator<AuthService>();
  final _cloudinaryService = locator<CloudinaryService>();

  final classroomnamecontroller = TextEditingController();
  final descriptioncontroller = TextEditingController();
  final studentcountcontroller = TextEditingController();

  String? classroomnameerror;
  String? studentcounterror;
  String? imageerror; // ✅ Add image error
  String? generatedClassCode;
  
  File? selectedImage;
  final ImagePicker _imagePicker = ImagePicker();

  void onback() {
    _navigationservice.back();
  }

  // ✅ Pick image from gallery
  Future<void> pickImage() async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1080,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        selectedImage = File(pickedFile.path);
        imageerror = null; // ✅ Clear error when image selected
        print("✅ Image selected: ${pickedFile.path}");
        notifyListeners();
      }
    } catch (e) {
      print("❌ Error picking image: $e");
      imageerror = "Failed to pick image. Please try again.";
      notifyListeners();
    }
  }

  // ✅ Remove selected image
  void removeImage() {
    selectedImage = null;
    imageerror = "Please select a classroom image"; // ✅ Show error again
    notifyListeners();
  }

  void onclassroomnamechanged(String value) {
    if (value.isEmpty) {
      classroomnameerror = "Classroom name is required";
    } else {
      classroomnameerror = null;
    }
    notifyListeners();
  }

  void onstudentcountchanged(String value) {
    if (value.isEmpty) {
      studentcounterror = "Maximum students is required";
    } else if (int.tryParse(value) == null) {
      studentcounterror = "Please enter a valid number";
    } else {
      final count = int.parse(value);
      if (count < 1) {
        studentcounterror = "Minimum 1 student required";
      } else if (count > 59) {
        studentcounterror = "Maximum 59 students allowed (total 60 with teacher)";
      } else {
        studentcounterror = null;
      }
    }
    notifyListeners();
  }

  // ✅ UPDATED - Validate image as REQUIRED
  bool _validateForm() {
    bool isValid = true;

    // ✅ Validate image FIRST (REQUIRED)
    if (selectedImage == null) {
      imageerror = "Please select a classroom image";
      isValid = false;
    } else {
      imageerror = null;
    }

    // Validate classroom name
    if (classroomnamecontroller.text.trim().isEmpty) {
      classroomnameerror = "Classroom name is required";
      isValid = false;
    } else {
      classroomnameerror = null;
    }

    // Validate student count
    if (studentcountcontroller.text.trim().isEmpty) {
      studentcounterror = "Maximum students is required";
      isValid = false;
    } else if (int.tryParse(studentcountcontroller.text.trim()) == null) {
      studentcounterror = "Please enter a valid number";
      isValid = false;
    } else {
      final count = int.parse(studentcountcontroller.text.trim());
      if (count < 1 || count > 59) {
        studentcounterror = "Must be between 1 and 59 students";
        isValid = false;
      } else {
        studentcounterror = null;
      }
    }

    notifyListeners();
    return isValid;
  }

  void oncreateclassroom() async {
    // ✅ Validate form (includes image check)
    if (!_validateForm()) {
      print("❌ Form validation failed");
      return;
    }

    setBusy(true);

    try {
      final teacherId = _authservice.currentuser?.uid;
      
      if (teacherId == null) {
        print("❌ Error: No teacher ID found");
        setBusy(false);
        return;
      }

      final maxStudents = int.parse(studentcountcontroller.text.trim());
      
      String? imageUrl;

      // ✅ Upload image (GUARANTEED to exist because of validation)
      if (selectedImage != null) {
        print("📤 Uploading classroom image...");
        final tempClassId = DateTime.now().millisecondsSinceEpoch.toString();
        
        try {
         imageUrl = await _cloudinaryService.uploadClassroomImage(
  imageFile: selectedImage!,
  classId: tempClassId,
);
          print("✅ Image uploaded successfully: $imageUrl");
        } catch (uploadError) {
          print("❌ Image upload failed: $uploadError");
          setBusy(false);
          imageerror = "Failed to upload image. Please try again.";
          notifyListeners();
          return;
        }
      }

      // ✅ Create classroom with image URL
      print("🏫 Creating classroom...");
      final classCode = await _classroomservice.createclass(
        classname: classroomnamecontroller.text.trim(),
        teacher_id: teacherId,
        description: descriptioncontroller.text.trim(),
        maxstudents: maxStudents,
        imageUrl: imageUrl, // ✅ Always has value now
      );

      print("✅ Classroom created successfully with code: $classCode");
      generatedClassCode = classCode;
      setBusy(false);
      notifyListeners();
      
    } catch (e) {
      print("❌ Error creating classroom: $e");
      setBusy(false);
      
      if (e.toString().contains("Maximum students must be between")) {
        studentcounterror = "Invalid student limit";
      } else {
        // Generic error - could show dialog here
        print("Unexpected error: $e");
      }
      notifyListeners();
    }
  }

  void resetClassCode() {
    generatedClassCode = null;
    selectedImage = null;
    classroomnamecontroller.clear();
    descriptioncontroller.clear();
    studentcountcontroller.clear();
    imageerror = null;
    classroomnameerror = null;
    studentcounterror = null;
    notifyListeners();
  }

  @override
  void dispose() {
    classroomnamecontroller.dispose();
    descriptioncontroller.dispose();
    studentcountcontroller.dispose();
    super.dispose();
  }
}