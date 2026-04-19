import 'package:englify_app/UI/views/teacher_flow/create_lessons/create_leasson_viewmodel.dart';
import 'package:englify_app/UI/widgets/custom_lesson_sucess_dialog.dart';
import 'package:englify_app/UI/widgets/reusable_elevated_blue_button.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CreateLessonView extends StatelessWidget {
  String classid;
  CreateLessonView({super.key, required this.classid});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateLeassonViewmodel>.reactive(
      viewModelBuilder: () => CreateLeassonViewmodel(classid: classid),
      builder: (context, model, child) {
       
       if(!model.isBusy && model.generatedlessonid!= null){
         WidgetsBinding.instance.addPostFrameCallback((_) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => LessonSuccessDialog(
                onDismiss: () {
                  Navigator.pop(context);
                  model.resetForm();
                  Navigator.pop(context);
                },
              ),
            );
          });
       }

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ✅ Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/images/applogo_blue.png',
                          height: 150,
                          width: 200,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE9EDEE),
                          ),
                          onPressed: model.onback,
                          child: const Text(
                            "Back",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Create Lesson",
                      style: TextStyle(
                        fontFamily: "heading",
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Set up a space for your students to learn and grow together.",
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    const SizedBox(height: 20),

                    // ✅ LESSON CARD IMAGE PICKER - same as classroom image picker
                    Row(
                      children: const [
                        Text(
                          "Lesson Image",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          "*",
                          style: TextStyle(fontSize: 16, color: Colors.red),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: model.pickimage,
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: model.selectedImage != null
                              ? Colors.transparent
                              : const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: model.imageerror != null
                                ? Colors.red
                                : Colors.grey.shade300,
                            width: model.imageerror != null ? 1.5 : 1.2,
                          ),
                        ),
                        child: model.selectedImage != null
                            ? Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.file(
                                      model.selectedImage!,
                                      width: double.infinity,
                                      height: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: GestureDetector(
                                      onTap: model.removeimage,
                                      child: Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: const BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_photo_alternate,
                                    size: 60,
                                    color: model.imageerror != null
                                        ? Colors.red
                                        : Colors.grey,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Tap to add lesson image",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: model.imageerror != null
                                          ? Colors.red
                                          : Colors.black54,
                                    ),
                                  ),
                                  if (model.imageerror != null)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Text(
                                        model.imageerror!,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // ✅ Lesson Name
                    Row(
                      children: const [
                        Text(
                          "Lesson Name",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          "*",
                          style: TextStyle(fontSize: 16, color: Colors.red),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      cursorColor: Colors.black,
                      controller: model.lessonnamecontroller,
                      onChanged: model.onlesseonnamechnaged,
                      style: const TextStyle(color: Colors.black),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        errorText: model.lesssonnameerror,
                        hintText: "e.g. Room & Pronoun Basics",
                        hintStyle: const TextStyle(color: Colors.black38),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1.2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: Color(0xFF2F6BFF), width: 1.6),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: Colors.redAccent, width: 1.2),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: Colors.redAccent, width: 1.6),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // ✅ Class Description (optional)
                    const Text(
                      "Class Description",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      cursorColor: Colors.black,
                      controller: model.descriptioncontroller,
                      maxLines: 4,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText:
                            "Briefly describe what students will learn in this lesson.",
                        hintStyle: const TextStyle(color: Colors.black38),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1.2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: Color(0xFF2F6BFF), width: 1.6),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // ✅ Lesson Content file upload
                    Row(
                      children: const [
                        Text(
                          "Lesson Content",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          "*",
                          style: TextStyle(fontSize: 16, color: Colors.red),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: model.pickContentFile,
                      child: Container(
                        height: 120,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: model.contenterror != null
                                ? Colors.red
                                : Colors.grey.shade300,
                            width: model.contenterror != null ? 1.5 : 1.2,
                          ),
                        ),
                        child: model.selectedcontentfile != null
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF2F6BFF)
                                            .withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Icon(
                                        Icons.insert_drive_file,
                                        color: Color(0xFF2F6BFF),
                                        size: 30,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            model.selectedfilename ?? '',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black87,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 4),
                                          const Text(
                                            "Tap to change file",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black38,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: model.removecontentfile,
                                      child: Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: const BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.upload_file,
                                    size: 40,
                                    color: model.contenterror != null
                                        ? Colors.red
                                        : Colors.grey,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Write & upload your content here",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: model.contenterror != null
                                          ? Colors.red
                                          : Colors.black54,
                                    ),
                                  ),
                                  if (model.contenterror != null)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Text(
                                        model.contenterror!,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                      ),
                    ),
                    const SizedBox(height: 100),

                    // ✅ Publish button
                    AppButton(
                      title: "Publish Now",
                      onTap: model.onpublishlesson,
                      isLoading: model.isBusy,
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
