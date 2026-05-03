import 'package:englify_app/UI/views/teacher_flow/classroom_detail/classroomdetail_viewmodel.dart';
import 'package:englify_app/UI/widgets/custom_lesson_card.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ClassroomdetailView extends StatelessWidget {
  final Map<String, dynamic> classroom;
  const ClassroomdetailView({super.key, required this.classroom});

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final screenHeight = MediaQuery.of(context).size.height;

    return ViewModelBuilder<ClassroomdetailViewmodel>.reactive(
      viewModelBuilder: () => ClassroomdetailViewmodel(classroom),
      onViewModelReady: (model) => model.loadlessons(),
      builder: (context, model, child) {
        return Scaffold(
          body: Stack(
            children: [
              // Background
              Positioned.fill(
                child: Image.asset(
                  'assets/images/dies_logo.png',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: Container(
                  color: Colors.grey.withOpacity(0.1),
                ),
              ),

              // Content
              SafeArea(
                child: Positioned.fill(
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: isLandscape ? 8 : 12,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: isLandscape ? 8 : 15),

                          // Header Row
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
                                  child: const Icon(Icons.arrow_back,
                                      color: Colors.black),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    '${model.className} - ${model.classCode}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 40),
                            ],
                          ),

                          const SizedBox(height: 5),
                          Container(
                            height: 2,
                            width: double.infinity,
                            color: const Color.fromARGB(38, 255, 255, 255),
                          ),
                          const SizedBox(height: 16),

                          // Search
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(28),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: TextField(
                              cursorColor: Colors.black,
                              controller: model.searchcontroller,
                              onChanged: model.onsearchchnage,
                              decoration: InputDecoration(
                                hintText: "Search Lesson",
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.grey[400],
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(28),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Grid
                          SizedBox(
                            height: isLandscape
                                ? screenHeight * 1.2
                                : screenHeight * 0.72,
                            child: model.isBusy
                                ? const Center(
                                    child: CircularProgressIndicator(
                                        color: Colors.white),
                                  )
                                : model.lessons.isEmpty
                                    ? Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              model.searchcontroller.text
                                                      .isNotEmpty
                                                  ? Icons.search_off
                                                  : Icons.menu_book_outlined,
                                              size: 64,
                                              color: Colors.white70,
                                            ),
                                            const SizedBox(height: 16),
                                            Text(
                                              model.searchcontroller.text
                                                      .isNotEmpty
                                                  ? "No lessons found"
                                                  : "No lessons yet.\nTap + to create one!",
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.white70,
                                              ),
                                            ),
                                            if (model.searchcontroller.text
                                                .isNotEmpty)
                                              TextButton(
                                                onPressed: model.onclearsearch,
                                                child: const Text(
                                                  "Clear Search",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      )
                                    : GridView.builder(
                                        physics:
                                            const AlwaysScrollableScrollPhysics(),
                                        padding:
                                            const EdgeInsets.only(bottom: 80),
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: isLandscape ? 3 : 2,
                                          crossAxisSpacing: 12,
                                          mainAxisSpacing: 12,
                                          childAspectRatio:
                                              isLandscape ? 1.0 : 0.78,
                                        ),
                                        itemCount: model.lessons.length,
                                        itemBuilder: (context, index) {
                                          final lesson = model.lessons[index];
                                          return LessonCard(
                                            lessonId: lesson.id,
                                            lessonName: lesson.title,
                                            imageUrl: lesson.imageUrl,
                                            onTap: () =>
                                                model.onlessontap(lesson),
                                          );
                                        },
                                      ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // FAB — duplicate hata diya, sirf ek rakha
              Positioned(
                right: 24,
                bottom: isLandscape ? 16 : 30,
                child: GestureDetector(
                  onTap: model.gotocreatelesson,
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: const BoxDecoration(
                      color: Color(0xFF2F6BFF),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.add, size: 32, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}