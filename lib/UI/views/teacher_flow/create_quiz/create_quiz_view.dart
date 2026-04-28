import 'package:dio/dio.dart';
import 'package:englify_app/UI/views/teacher_flow/create_quiz/create_quiz_viewmodel.dart';
import 'package:englify_app/UI/widgets/reusable_button_white.dart';
import 'package:englify_app/UI/widgets/reusable_elevated_blue_button.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:stacked/stacked.dart';

class CreateQuizView extends StatelessWidget {
  final String classid;
  final String lessonid;
  final String lessontitle;

  CreateQuizView({
    super.key,
    required this.classid,
    required this.lessonid,
    required this.lessontitle,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateQuizViewmodel>.reactive(
      viewModelBuilder: () => CreateQuizViewmodel(
        classId: classid,
        lessonId: lessonid,
        lessonTitle: lessontitle,
      ),
      onViewModelReady: (model)=> model.init(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: const Color(0xFFF2F4F8),
          body: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/dies_logo.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.black.withOpacity(0.35),
              ),
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: model.onBack,
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                                size: 20,
                              ),
                            ),
                          ),
                          SizedBox(width: 69),
                          Expanded(
                            child: Text(
                              'Create Quiz',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 2,
                        width: double.infinity,
                        color: const Color.fromARGB(90, 255, 255, 255),
                      ),
                      SizedBox(height: 30),
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
                          controller: model.scrollController,
                          itemCount: model.questions.length,
                          itemBuilder: (context, qindex) {
                            final question = model.questions[qindex];
                            return _buildQuestionCard(
                              context,
                              model,
                              qindex,
                              question,
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: Column(
                          children: [
                            AppButtonWhite(title: "Add New Question", onTap: ()=> model.addQuestion(context)),
                              SizedBox(height: 12,),
                           SizedBox(
width: double.infinity,
height:52,
child: ElevatedButton(

onPressed:
model.canPublish
? ()=>model.publishQuiz(context)
: null,

style:
ElevatedButton.styleFrom(
backgroundColor:
model.quizAlreadyCreated
? Colors.grey.shade600
: const Color(0xFF2F6BFF),

shape:
RoundedRectangleBorder(
borderRadius:
BorderRadius.circular(12),
),
),

child: Row(
mainAxisAlignment:
MainAxisAlignment.center,
children: [

if(model.isBusy)...[
SizedBox(
height:18,
width:18,
child:
CircularProgressIndicator(
strokeWidth:2,
valueColor:
AlwaysStoppedAnimation(
Colors.white
),
),
),
SizedBox(width:12),
],

Text(

model.quizAlreadyCreated
? "Quiz Already Created ✓"
: "Publish Quiz",

style: TextStyle(
color: Colors.white,
fontSize:18,
fontWeight:
FontWeight.w600,
),

)

],
),
),
)
                                 ],
                        ),
                        )
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
}

Widget _buildQuestionCard(
  BuildContext context,
  CreateQuizViewmodel model,
  int qIndex,
  QuestionForm question,
) {
  final height = MediaQuery.of(context).size.height;

  return Container(
    height: height * 0.62,
    margin: EdgeInsets.only(bottom: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.white, width: 1.5),
    ),
    child: SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Question ${qIndex + 1}',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.white, // ← white text
                ),
              ),
              Spacer(),
              if (model.questions.length > 1)
                GestureDetector(
                  onTap: () => model.removeQuestion(qIndex),
                  child: Container(
                    height: 50,
                    width: 50,

                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.delete_outlined,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 15),
          TextField(
            cursorColor: Colors.black,
            controller: question.questionController,
            onChanged: (_) => model.notifyListeners(),
            maxLines: 2,
            minLines: 1,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              hintText: 'Enter your question here....',
              hintStyle: TextStyle(color: Colors.black, fontSize: 14),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.white, width: 1.2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.white, width: 1.5),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
          ),
          SizedBox(height: 15),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: question.options.length,
            itemBuilder: (context, oIndex) {
              final option = question.options[oIndex];
              return Padding(padding: EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                 
                  SizedBox(width: 2,),
                  Expanded(
                    child: TextField(
                      cursorColor: Colors.black,
                      controller: option.controller,
                      onChanged: (_)=> model.notifyListeners(),
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        prefixIcon: GestureDetector(
      onTap: ()=> model.selectCorrectAnswer(qIndex, oIndex),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            border: Border.all(
              color: option.isCorrect ? Colors.green : Colors.grey,
              width: 2,
            ),
            shape: BoxShape.circle,
          ),
          child: option.isCorrect
              ? Center(
                  child: Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                )
              : null,
        ),
      ),
    ),

        hintText: 'Option ${String.fromCharCode(65 + oIndex)} ',
        hintStyle: TextStyle(color: Colors.black, fontSize: 14),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.white, width: 1.2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.white, width: 1.5),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 10,
              ),
                      ),
                    )
                    ),
                    SizedBox(width: 8,),
                    GestureDetector(
                  onTap: () => model.removeOption(qIndex,oIndex,context),
                  child: Container(
                    height: 50,
                    width: 50,

                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.delete_outlined,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
                ],

              ),
              );
            },
          ),
          SizedBox(height: 15,),
          GestureDetector(
            onTap: ()=> model.addOption(qIndex, context),
            child: Row(
              children: [
                Icon(Icons.add, color: const Color(0xFF2F6BFF), size: 25),
                  SizedBox(width: 4),
                  Text(
                    'Add option',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

              ],
            ),
          ),
          SizedBox(height: 4,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
                children: [
                  const Text(
                    'Required',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                   Spacer(),
                  Transform.scale(
  scale: 0.8,
  child: Switch(
    value: question.isRequired,
    onChanged: (_) => model.toggleRequired(qIndex),

    // 👇 MAIN FIX
    thumbColor: MaterialStateProperty.all(Colors.white),

    trackColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return const Color(0xFF2F6BFF); 
      }
      return Colors.grey.shade400; 
    }),
  ),
)
                ],
              ),
              
          ),
          SizedBox(height: 10),

Padding(
  padding: const EdgeInsets.symmetric(horizontal: 10),
  child: Row(
    children: [
      const Text(
        'Timer',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),

      Spacer(),

      Transform.scale(
        scale: 0.8,
        child: Switch(
          value: question.timerEnabled,
          onChanged: (_) => model.toggleTimer(qIndex),

          thumbColor:
              MaterialStateProperty.all(
                Colors.white,
              ),

          trackColor:
           MaterialStateProperty.resolveWith(
            (states) {
              if (states.contains(
                MaterialState.selected,
              )) {
                return const Color(
                  0xFF2F6BFF,
                );
              }

              return Colors.grey.shade400;
            },
          ),
        ),
      ),
    ],
  ),
),

if(question.timerEnabled)...[

SizedBox(height:12),

TextField(
  cursorColor: Colors.black,

  controller:
      question.timerController,

  keyboardType:
      TextInputType.number,

  style: const TextStyle(
    color: Colors.black,
  ),

  decoration: InputDecoration(
    hintText: "Seconds (15)",

    hintStyle: TextStyle(
      color: Colors.black54,
      fontSize:14,
    ),

    filled:true,
    fillColor: Colors.white,

    enabledBorder:
      OutlineInputBorder(
        borderRadius:
          BorderRadius.circular(30),

        borderSide:
         BorderSide(
          color: Colors.black,
          width:1.2,
         ),
      ),

    focusedBorder:
      OutlineInputBorder(
        borderRadius:
         BorderRadius.circular(30),

        borderSide:
         BorderSide(
          color: Colors.black,
          width:1.5,
         ),
      ),

    contentPadding:
      EdgeInsets.symmetric(
        horizontal:16,
        vertical:12,
      ),
  ),
),

]
        ],
      ),
    ),
  );
}
