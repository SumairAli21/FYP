import 'package:englify_app/UI/views/teacher_flow/classroom_detail/classroomdetail_viewmodel.dart';
import 'package:englify_app/UI/widgets/custom_lesson_card.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ClassroomdetailView extends StatelessWidget {
  final Map<String, dynamic> classroom;
  const ClassroomdetailView({super.key, required this.classroom});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ClassroomdetailViewmodel>.reactive(
      viewModelBuilder: () => ClassroomdetailViewmodel(classroom),
      onViewModelReady: (model)=> model.loadlessons(),
      builder: (context, model, child) {
        
            return Scaffold(
              body: Stack(
                children: [
                  Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/dies_logo.png'), // Tumhari image path
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
                  padding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15,),
                      Row(
                      children: [
                        GestureDetector(
                          onTap: model.onback,
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.arrow_back,color: Colors.black,),
                          ),
                        ),
                         
                         SizedBox(width: 69,),
                           
                          Center(
                            child: Text(
                              model.className,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                           
                          
                          Center(
                            child: Text(
                              '-',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          
                           
                          Center(
                            child: Text(
                              model.classCode,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ), 
                      ],
                    ),
                     SizedBox(height: 5,),
                    Container(
                            height: 2,
                            width: double.infinity,
                            color: const Color.fromARGB(38, 255, 255, 255),
                          ),
                          SizedBox(height: 20,),
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
                      
                      SizedBox(height: 20,),
                      Expanded(
                        child: model.isBusy?
                        Center(
                          child: CircularProgressIndicator(color: Colors.white,),
                        )
                        :model.lessons.isEmpty
                        ?Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          model.searchcontroller.text.isNotEmpty
                                              ? Icons.search_off
                                              : Icons.menu_book_outlined,
                                          size: 64,
                                          color: Colors.white70,
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          model.searchcontroller.text.isNotEmpty
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
                        :GridView.builder(
                                    padding:
                                        const EdgeInsets.only(bottom: 10),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 12,
                                      mainAxisSpacing: 12,
                                      childAspectRatio: 0.78,
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
                  )
                ),
                Positioned(
                  right: 24,
                  bottom: 100, // bottom tabs ke upar
                  child: GestureDetector(
                    onTap: model.gotocreatelesson,
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

                Positioned(
                  right: 24,
                  bottom: 100, // bottom tabs ke upar
                  child: GestureDetector(
                    onTap: model.gotocreatelesson,
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
            );
          },
        );
      }
    
  
}
