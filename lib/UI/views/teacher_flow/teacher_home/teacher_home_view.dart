import 'package:englify_app/UI/views/teacher_flow/teacher_home/teacher_home_view_model.dart';
import 'package:englify_app/UI/widgets/custom_class_card.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class TeacherHomeView extends StatelessWidget {
  const TeacherHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final screenHeight = MediaQuery.of(context).size.height;

    return ViewModelBuilder<TeacherHomeViewModel>.reactive(
      viewModelBuilder: () => TeacherHomeViewModel(),
      onViewModelReady: (model) => model.loadClassrooms(),
      builder: (context, model, child) {
        return SafeArea(
          child: Material(
            color: Colors.transparent,
            child: Stack(
              children: [
                // ── Background
                Positioned.fill(
                  child: Image.asset(
                    "assets/images/dies_logo.png",
                    fit: BoxFit.cover,
                  ),
                ),

                // ── Content
                Positioned.fill(
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        24,
                        16,
                        24,
                        isLandscape ? 20 : 100, // ✅ landscape mein kam padding
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Welcome back! 👋",
                                    style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "heading",
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "Learn and grow daily.",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.notifications,
                                  color: Color(0xFF2F6BFF),
                                ),
                              ),
                            ],
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
                              onChanged: model.onSearchChanged,
                              decoration: InputDecoration(
                                hintText: "Search Classroom",
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

                          // Grid area
                          SizedBox(
                            // ✅ landscape mein choti height, portrait mein badi
                            height: isLandscape
                                ? screenHeight * 1.2
                                : screenHeight * 0.75,
                            child: model.isBusy
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : model.classrooms.isEmpty
                                    ? Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              model.searchcontroller.text
                                                      .isNotEmpty
                                                  ? Icons.search_off
                                                  : Icons.class_outlined,
                                              size: 64,
                                              color: Colors.white70,
                                            ),
                                            const SizedBox(height: 16),
                                            Text(
                                              model.searchcontroller.text
                                                      .isNotEmpty
                                                  ? "No classrooms found"
                                                  : "No classrooms yet.\nCreate one to get started!",
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.white70,
                                              ),
                                            ),
                                            if (model.searchcontroller.text
                                                .isNotEmpty)
                                              TextButton(
                                                onPressed: model.clearSearch,
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
                                            const EdgeInsets.only(bottom: 10),
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          // ✅ landscape mein 3 columns, portrait mein 2
                                          crossAxisCount: isLandscape ? 3 : 2,
                                          crossAxisSpacing: 12,
                                          mainAxisSpacing: 12,
                                          // ✅ landscape mein cards chote
                                          childAspectRatio:
                                              isLandscape ? 1.0 : 0.70,
                                        ),
                                        itemCount: model.classrooms.length,
                                        itemBuilder: (context, index) {
                                          final classroom =
                                              model.classrooms[index];
                                          return ClassroomCard(
                                            classroomName: classroom['name'],
                                            classroomId: classroom['id'],
                                            imageUrl: classroom['imageUrl'],
                                            onTap: () =>
                                                model.onClassroomTap(classroom),
                                          );
                                        },
                                      ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // ── FAB
                Positioned(
                  right: 24,
                  bottom: isLandscape ? 16 : 70,
                  child: GestureDetector(
                    onTap: model.oncreateclassroom,
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: const BoxDecoration(
                        color: Color(0xFF2F6BFF),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 32,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}