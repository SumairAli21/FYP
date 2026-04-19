import 'package:englify_app/UI/views/teacher_flow/lesson_detail/lesson_detail_viewmodel.dart'; // ← new import
import 'package:englify_app/UI/widgets/pdf_page_viewer.dart';
import 'package:englify_app/models/lesson_data_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LessonDetailView extends StatelessWidget {
  final LessonData lessons;
  final Map<String, dynamic> classroom;
  LessonDetailView({super.key, required this.classroom, required this.lessons});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LessonDetailViewmodel>.reactive(
      viewModelBuilder: () =>
          LessonDetailViewmodel(lesson: lessons, classroom: classroom),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/dies_logo.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.grey.withOpacity(0.1),
                      Colors.grey.withOpacity(0.1),
                    ],
                  ),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: model.onback,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.arrow_back, color: Colors.black),
                            ),
                          ),
                          const SizedBox(width: 69),
                          Center(
                            child: Text(
                              model.className,
                              style: const TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                          const Center(
                            child: Text('-',
                                style: TextStyle(color: Colors.white, fontSize: 18)),
                          ),
                          Center(
                            child: Text(
                              model.classCode,
                              style: const TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 2,
                        width: double.infinity,
                        color: const Color.fromARGB(90, 255, 255, 255),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          model.lessonNumberText,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white54,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Introduction to ${lessons.title}',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (lessons.description.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            lessons.description,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.7),
                              height: 1.5,
                            ),
                          ),
                        ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Row(
                                children: [
                                  Icon(Icons.menu_book, color: Colors.white, size: 16),
                                  SizedBox(width: 6),
                                  Text("Grammar Basics",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12)),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Row(
                                children: [
                                  Icon(Icons.edit_note, color: Colors.black, size: 16),
                                  SizedBox(width: 6),
                                  Text("Mini Exercises",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 2,
                        width: double.infinity,
                        color: const Color.fromARGB(98, 255, 255, 255),
                      ),
                      const SizedBox(height: 16),

                      // ── CONTENT SECTION (yahan sirf yeh badla hai) ──
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: _buildContent(context, model, lessons),
                        ),
                      ),

                      // ── Create Quiz Button ──
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        child: SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2F6BFF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: model.oncratequiz,
                            child: const Text(
                              "Create Quiz",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ── Content builder — clean aur alag method ──
  Widget _buildContent(
      BuildContext context, LessonDetailViewmodel model, LessonData lessons) {
    final url = (lessons.contentUrl ?? "").trim().toLowerCase();

    // Image
    if (url.contains(".jpg") || url.contains(".png") || url.contains(".jpeg")) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          lessons.contentUrl!.trim(),
          fit: BoxFit.contain,
        ),
      );
    }

    // PDF / Word / PPT → WhatsApp style card
    if (model.isFileSupported) {
      return Align(
        alignment: Alignment.topCenter,
        child: FileAttachmentCard(
          fileUrl: lessons.contentUrl!.trim(),
          fileName: model.fileName,
          isDownloading: model.isDownloading,         // ← ViewModel se
          progress: model.downloadProgress,            // ← ViewModel se
          onTap: model.openFile,                       // ← ViewModel ka function
        ),
      );
    }

    // Plain text fallback
    return SingleChildScrollView(
      child: Text(
        lessons.contentUrl ?? '',
        style: const TextStyle(
          fontSize: 15,
          height: 1.6,
          color: Colors.white,
        ),
      ),
    );
  }
}