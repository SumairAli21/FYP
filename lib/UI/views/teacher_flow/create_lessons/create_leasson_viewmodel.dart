import 'dart:io';

import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/services/auth_service.dart';
import 'package:englify_app/services/cloudniry_service.dart';
import 'package:englify_app/services/create_lesson_service.dart';
import 'package:englify_app/services/firestore_keys.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CreateLeassonViewmodel extends BaseViewModel {
  final _navigationservice = locator<NavigationService>();
  final _authservice = locator<AuthService>();
  final _cloudinaryservice = locator<CloudinaryService>();
  final _lessonservice = locator<CreateLessonService>();

  final String classid;
  CreateLeassonViewmodel({required this.classid});

  final lessonnamecontroller = TextEditingController();
  final descriptioncontroller = TextEditingController();

  String? lesssonnameerror;
  String? imageerror;
  String? contenterror;
  String? generatedlessonid;

  File? selectedImage;
  final ImagePicker _imagePicker = ImagePicker();

  File? selectedcontentfile;
  String? selectedfilename;
  String? selectedfileexe;

  List lessons = [];
bool isLoadingLessons = false;

  void onback() {
    _navigationservice.back();
  }

  Future<void> init() async {
  isLoadingLessons = true;
  notifyListeners();

  try {
    lessons = await _lessonservice.getlesssonsdata(classid);
  } catch (e) {
    print("❌ Failed to load lessons: $e");
  }

  isLoadingLessons = false;
  notifyListeners();
}

  Future<void> pickimage() async {
    try {
      final XFile? pickimage = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 1080,
        maxWidth: 1080,
        imageQuality: 85,
      );

      if (pickimage != null) {
        selectedImage = File(pickimage.path);
        imageerror = null;
        notifyListeners();
      }
    } catch (e) {
      imageerror = "Failed to pick image. Please try again.";
      notifyListeners();
    }
  }

  void removeimage() {
    selectedImage = null;
    imageerror = "please select a lesson image";
    notifyListeners();
  }

  Future<void> pickContentFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png', 'doc', 'docx', 'mp4'],
        allowMultiple: false,
      );

      if (result != null && result.files.single.path != null) {
        selectedcontentfile = File(result.files.single.path!);
        selectedfilename = result.files.single.name;
        selectedfileexe = result.files.single.extension ?? 'pdf';
        contenterror = null;
        print("✅ Content file selected: $selectedfilename");
        notifyListeners();
      }
    } catch (e) {
      print("❌ Error picking file: $e");
      contenterror = "Failed to pick file. Please try again.";
      notifyListeners();
    }
  }

  void removecontentfile() {
    selectedcontentfile = null;
    selectedfileexe = null;
    selectedfilename = null;
    contenterror = "please select content file";
    notifyListeners();
  }

  void onlesseonnamechnaged(String value) {
    if (value.isEmpty) {
      lesssonnameerror = 'lesson name is required';
    } else {
      lesssonnameerror = null;
    }
    notifyListeners();
  }

  bool _validatform() {
    bool isvalid = true;
    if (selectedImage == null) {
      imageerror = "please select the image";
      isvalid = false;
    } else {
      imageerror = null;
    }

    if (lessonnamecontroller.text.isEmpty) {
      lesssonnameerror = "Lesson name is required";
      isvalid = false;
    } else {
      lesssonnameerror = null;
    }

    if (selectedcontentfile == null) {
      contenterror = "Please select content file";
      isvalid = false;
    } else {
      contenterror = null;
    }

    notifyListeners();
    return isvalid;
  }

  Future<void> onpublishlesson() async {
    if (!_validatform()) {
      return;
    }

    setBusy(true);
    try {
      final teacherId = _authservice.currentuser!.uid.toString();

      if (teacherId.isEmpty) {
        setBusy(false);
        return;
      }
      final tempId = DateTime.now().millisecondsSinceEpoch.toString();
      String? imageurl;

      try {
        imageurl = await _cloudinaryservice.uploadLessonImage(
          imageFile: selectedImage!,
          lessonId: tempId,
        );
      } catch (e) {
        imageerror = "Failed to upload image";
        setBusy(false);
        notifyListeners();
        return;
      }
      String? contentUrl;
      try {
        contentUrl = await _cloudinaryservice.uploadLessonContent(
          contentFile: selectedcontentfile!,
          lessonId: tempId,
          fileExtension: selectedfileexe ?? "pdf",
        );
      } catch (e) {
        setBusy(false);
        contenterror = "Failed to upload contentfile";
        notifyListeners();
        return;
      }

      final lessonId = await _lessonservice.createlesson(
        classid: classid,
        teacherid: teacherId,
        lessontitle: lessonnamecontroller.text.trim(),
        description: descriptioncontroller.text.trim(),
        contenturl: contentUrl,
        imageurl: imageurl,
      );

      generatedlessonid = lessonId;

      await init();
      setBusy(false);
      notifyListeners();
    } catch (e) {
      setBusy(false);
      notifyListeners();
    }
  }

  void resetForm() {
    generatedlessonid = null;
    selectedImage = null;
    selectedcontentfile = null;
    selectedfilename = null;
    selectedfileexe = null;
    lessonnamecontroller.clear();
    descriptioncontroller.clear();
    imageerror = null;
    lesssonnameerror = null;
    contenterror = null;
    notifyListeners();
  }

  @override
  void dispose() {
    lessonnamecontroller.dispose();
    descriptioncontroller.dispose();
    super.dispose();
  }
}
