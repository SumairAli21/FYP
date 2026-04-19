import 'package:englify_app/UI/views/student_flow/studenhome/student_home_view_model.dart';
import 'package:englify_app/UI/widgets/custom_class_card.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class StudentHomeView extends StatelessWidget {
  const StudentHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StudentHomeViewModel>.reactive(
      viewModelBuilder: () => StudentHomeViewModel(),
      onViewModelReady: (model) => model.init(),
      builder: (context, model, child) {
        return SafeArea(
          child: Material(
            color: Colors.transparent,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    "assets/images/dies_logo.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${model.getGreeting()} 👋',
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "heading",
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                model.username,
                                style: TextStyle(
                                  fontSize: 16,
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

                      const SizedBox(height: 20),

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
                          controller: model.serachcontroller,
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

                      Expanded(
                        child: model.isBusy
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                ),
                              )
                            : model.filteredclass.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.class_outlined,
                                      size: 80,
                                      color: Colors.blue,
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      'No classes found',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      model.serachcontroller.text.isNotEmpty
                                          ? 'Join a class to get started'
                                          : 'Try a different search',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : GridView.builder(
                                padding: const EdgeInsets.only(bottom: 20),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 12,
                                      mainAxisSpacing: 12,
                                      childAspectRatio: 0.70,
                                    ),
                                itemCount: model.filteredclass.length,
                                itemBuilder: (context, index) {
                                  final classData = model.filteredclass[index];
                                  return ClassroomCard(
                                    classroomName: classData.name,
                                    classroomId: classData.id,
                                    imageUrl: classData.imageUrl,
                                    onTap: () {
                                      model.gotoclassroomdetail(classData);
                                    },
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 24,
                  bottom: 100, // bottom tabs ke upar
                  child: GestureDetector(
                    onTap: model.joinclass,
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
