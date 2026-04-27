import 'package:englify_app/UI/views/teacher_flow/teacher_home/teacher_home_view_model.dart';
import 'package:englify_app/UI/widgets/custom_class_card.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class TeacherHomeView extends StatelessWidget {
  const TeacherHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TeacherHomeViewModel>.reactive(
      viewModelBuilder: () => TeacherHomeViewModel(),
      onViewModelReady: (model) => model.loadClassrooms(),
      builder: (context, model, child) {
        return SafeArea(
          child: Material(
            color: Colors.transparent,
            child: Stack(
              children: [
                // ================= BACKGROUND IMAGE =================
                Positioned.fill(
                  child: Image.asset(
                    "assets/images/dies_logo.png",
                    fit: BoxFit.cover,
                  ),
                ),

                // ================= MAIN CONTENT =================
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ---------- HEADER ----------
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

                      const SizedBox(height: 24),

                      // ---------- SEARCH ----------
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

                      const SizedBox(height: 20),

                      // ---------- CLASSROOM LIST ----------
                      Expanded(
                        child: model.isBusy
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                ),
                              )
                            : model.classrooms.isEmpty
                                ? Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          model.searchcontroller.text.isNotEmpty
                                              ? Icons.search_off
                                              : Icons.class_outlined,
                                          size: 64,
                                          color: Colors.blue,
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          model.searchcontroller.text.isNotEmpty
                                              ? "No classrooms found"
                                              : "No classrooms yet.\nCreate one to get started!",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        if (model.searchcontroller.text.isNotEmpty)
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
                                    padding: const EdgeInsets.only(bottom: 10),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 12,
                                      mainAxisSpacing: 12,
                                      childAspectRatio: 0.70,
                                    ),
                                    itemCount: model.classrooms.length,
                                    itemBuilder: (context, index) {
                                      final classroom =
                                          model.classrooms[index];
                                      return ClassroomCard(
      classroomName: classroom['name'],
      classroomId: classroom['id'],
      imageUrl: classroom['imageUrl'], // ✅ ADD THIS LINE
      onTap: () => model.onClassroomTap(classroom),
    );
                                    },
                                  ),
                      ),
                    ],
                  ),
                ),

                // ================= FLOATING ADD BUTTON =================
                Positioned(
                  right: 24,
                  bottom: 70, // bottom tabs ke upar
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
