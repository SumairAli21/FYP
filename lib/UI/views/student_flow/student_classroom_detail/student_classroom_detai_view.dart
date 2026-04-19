import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:englify_app/UI/views/student_flow/student_classroom_detail/student_classroom_detail_viewmodel.dart';
import 'package:englify_app/UI/widgets/custom_lesson_card.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:stacked/stacked.dart';

class StudentClassroomDetaiView extends StatelessWidget {
  final Map<String, dynamic> classroom;
  StudentClassroomDetaiView({super.key, required this.classroom});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StudentClassroomDetailViewmodel>.reactive(
      viewModelBuilder: () => StudentClassroomDetailViewmodel(classroom),
      onViewModelReady: (model) => model.loadlesson(),
      builder: (context, model, child) {
        return Scaffold(
          body: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  image:  DecorationImage(
                    image: AssetImage("assets/images/dies_logo.png"),
                    fit: BoxFit.cover
                    )
                ),
              ),
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.grey.withOpacity(0.1),
                      Colors.grey.withOpacity(0.1),
                    ]
                    )
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                              child: Icon(Icons.arrow_back,  color: Colors.black,),
                            ),
                          ),
                          SizedBox(width: 110,),
                          Center(
                            child: Text(
                              model.className,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 5,),
                      Container(
                        height: 2,
                        width: double.infinity,
                        color: Color.fromARGB(38, 255, 255, 255),
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
                            )
                          ]
                        ),
                        child: TextField(
                          controller: model.serachcontroller,
                          cursorColor: Colors.black,
                          onChanged: model.onsearchchanged,
                          decoration: InputDecoration(
                            hintText: "search lesson",
                            prefixIcon: Icon(Icons.search, color: Colors.grey[400],),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(28),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 12)
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Expanded(
                        child: model.isBusy ? 
                        Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                        : model.lessons.isEmpty ?
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                model.serachcontroller.text.isNotEmpty ?
                                Icons.search_off
                                :Icons.menu_book_outlined,
                                size: 64,
                                color: Colors.white70,

                              ),
                              SizedBox(height: 16,),
                              Text(
                                model.serachcontroller.text.isNotEmpty ?
                                "No Lesson Found"
                                : "No Lessons Available Yet",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16
                                ),
                              ),
                              if(model.serachcontroller.text.isNotEmpty)
                              TextButton(onPressed: model.clearseach, child: Text(
                                "Clear Search",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20
                                ),
                              ))
                            ],
                          ),
                        )
                        : GridView.builder(
                          padding: EdgeInsets.only(bottom: 10),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 0.78
                            ), 
                            itemCount: model.lessons.length,
                          itemBuilder: (Context,Index){
                            final lesson = model.lessons[Index];
                            return LessonCard(lessonName: lesson.title, lessonId: lesson.id, onTap: () => model.gotolessondetail(lesson),imageUrl: lesson.imageUrl,);
                          }
                          )
                        )
                    ],
                  ),
                  )
                )
            ],
          ),
        );
      },
    );
  }
}
