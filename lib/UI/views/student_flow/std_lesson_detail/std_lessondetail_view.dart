import 'package:englify_app/UI/views/student_flow/std_lesson_detail/std_lessondetail_viewmodel.dart';
import 'package:englify_app/UI/widgets/pdf_page_viewer.dart';
import 'package:englify_app/models/lesson_data_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class StdLessondetailView extends StatelessWidget {
  final LessonData lesson;
  final Map<String, dynamic> classroom;

  const StdLessondetailView({
    super.key,
    required this.lesson,
    required this.classroom,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLandscape = size.width > size.height;

    return ViewModelBuilder<StdLessondetailViewmodel>.reactive(
      viewModelBuilder: () =>
          StdLessondetailViewmodel(classroom: classroom, lesson: lesson),
      onViewModelReady: (model) => model.init(),
      builder: (context, model, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/images/dies_logo.png',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: Container(color: Colors.grey.withOpacity(0.1)),
              ),
              SafeArea(
                child: Column(
                  children: [
                    // ── Top bar
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: isLandscape ? 4 : 12,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: model.onBack,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: const Icon(Icons.arrow_back,
                                  color: Colors.black),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: Colors.white.withOpacity(0.4)),
                            ),
                            child: Row(
                              children: [
                                Image.asset('assets/images/coins.png',
                                    height: 20, width: 20),
                                const SizedBox(width: 3),
                                Text(
                                  model.scoretext,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      height: 2,
                      width: double.infinity,
                      color: const Color.fromARGB(90, 255, 255, 255),
                    ),

                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                          horizontal: isLandscape ? 40 : 16,
                          vertical: isLandscape ? 8 : 12,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            Text(
                              model.lessonNumberText,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white54,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Introduction to ${lesson.title}',
                              style: TextStyle(
                                fontSize: isLandscape ? 18 : 22,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            if (lesson.description.isNotEmpty)
                              Text(
                                lesson.description,
                                style: TextStyle(
                                  fontSize: isLandscape ? 12 : 14,
                                  color: Colors.white.withOpacity(0.7),
                                  height: 1.5,
                                ),
                              ),
                            const SizedBox(height: 16),

                            // Tags
                            Wrap(
                              spacing: 10,
                              runSpacing: 8,
                              children: [
                                _tag(
                                  icon: Icons.menu_book,
                                  label: 'Grammar Basics',
                                  bgColor: Colors.blue,
                                  textColor: Colors.white,
                                  iconColor: Colors.white,
                                ),
                                _tag(
                                  icon: Icons.edit_note,
                                  label: 'Mini Exercises',
                                  bgColor: Colors.white.withOpacity(0.9),
                                  textColor: Colors.black,
                                  iconColor: Colors.black,
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),

                            // ── Quiz + Fav row
                            Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: isLandscape ? 38 : 46,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            model.isQuizAttempted
                                                ? Colors.grey.shade600
                                                : const Color(0xFF2F6BFF),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                      onPressed: model.isQuizAttempted
                                          ? null
                                          : model.onAttemptQuiz,
                                      child: Text(
                                        model.isQuizAttempted
                                            ? 'Already Attempted ✓'
                                            : 'Attempt Quiz',
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),

                                // ✅ StatefulWidget — animation guaranteed kaam kare
                                _FavButton(
                                  isFavourite: model.isFavourite,
                                  isLoading: model.isTogglingFavourite,
                                  size: isLandscape ? 38.0 : 46.0,
                                  onTap: model.toggleFavourite,
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),

                            Container(
                              height: 2,
                              width: double.infinity,
                              color: const Color.fromARGB(98, 255, 255, 255),
                            ),
                            const SizedBox(height: 16),

                            _buildContent(context, model, lesson),
                            SizedBox(height: isLandscape ? 16 : 30),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _tag({
    required IconData icon,
    required String label,
    required Color bgColor,
    required Color textColor,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor, size: 16),
          const SizedBox(width: 6),
          Text(label,
              style: TextStyle(color: textColor, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    StdLessondetailViewmodel model,
    LessonData lessons,
  ) {
    final url = (lessons.contentUrl ?? '').trim().toLowerCase();

    if (url.contains('.jpg') ||
        url.contains('.png') ||
        url.contains('.jpeg')) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(lessons.contentUrl!.trim(), fit: BoxFit.contain),
      );
    }

    if (model.isFileSupported) {
      return FileAttachmentCard(
        fileUrl: lessons.contentUrl!.trim(),
        fileName: model.fileName,
        isDownloading: model.isDownloading,
        progress: model.downloadProgress,
        onTap: model.openFile,
      );
    }

    return Text(
      lessons.contentUrl ?? '',
      style: const TextStyle(fontSize: 15, height: 1.6, color: Colors.white),
    );
  }
}

// ✅ Alag StatefulWidget — isFavourite prop change hone pe
// didUpdateWidget se animation trigger hoga, guaranteed
class _FavButton extends StatefulWidget {
  final bool isFavourite;
  final bool isLoading;
  final double size;
  final VoidCallback onTap;

  const _FavButton({
    required this.isFavourite,
    required this.isLoading,
    required this.size,
    required this.onTap,
  });

  @override
  State<_FavButton> createState() => _FavButtonState();
}

class _FavButtonState extends State<_FavButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _scale = Tween<double>(begin: 1.0, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut),
    );
  }

  @override
  void didUpdateWidget(_FavButton old) {
    super.didUpdateWidget(old);
    // ✅ Jab bhi isFavourite change ho — bounce animation fire karo
    if (old.isFavourite != widget.isFavourite) {
      _scale = Tween<double>(begin: 0.6, end: 1.0).animate(
        CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut),
      );
      _ctrl.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

 @override
Widget build(BuildContext context) {
  return GestureDetector(
    onTap: widget.onTap,
    child: ScaleTransition(
      scale: _scale,
      child: Container(
        height: widget.size,
        width: widget.size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white, // ← container hamesha white
          boxShadow: [
            BoxShadow(
              color: widget.isFavourite
                  ? Colors.amber.withOpacity(0.4)
                  : Colors.black.withOpacity(0.1),
              blurRadius: widget.isFavourite ? 10 : 4,
              spreadRadius: widget.isFavourite ? 1 : 0,
            ),
          ],
        ),
        child: widget.isLoading
            ? Center(
                child: SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    color: widget.isFavourite
                        ? const Color(0xFFFFD700)
                        : Colors.grey,
                    strokeWidth: 2,
                  ),
                ),
              )
            : Icon(
                widget.isFavourite
                    ? Icons.bookmark
                    : Icons.bookmark_border,
                color: widget.isFavourite
                    ? const Color(0xFFFFD700) // ← yellow icon
                    : Colors.grey,            // ← grey icon
                size: widget.size * 0.48,
              ),
      ),
    ),
  );
}
}