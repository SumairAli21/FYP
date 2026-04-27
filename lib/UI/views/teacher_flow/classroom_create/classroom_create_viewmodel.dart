import 'dart:io';
import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/services/auth_service.dart';
import 'package:englify_app/services/classroom_service.dart';
import 'package:englify_app/services/cloudniry_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ClassroomCreateViewmodel extends BaseViewModel {

  final _navigationService=
      locator<NavigationService>();

  final _classroomService=
      locator<classroomservice>();

  final _authService=
      locator<AuthService>();

  final _cloudinaryService=
      locator<CloudinaryService>();


  final classroomnamecontroller=
      TextEditingController();

  final studentcountcontroller=
      TextEditingController();


  String? classroomnameerror;
  String? studentcounterror;
  String? imageerror;

  String? generatedClassCode;

  File? selectedImage;

  final ImagePicker _picker=
      ImagePicker();




  void onback(){
    _navigationService.back();
  }


  Future<void> pickImage() async{
    try{

      final XFile? picked=
          await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth:1080,
        maxHeight:1080,
        imageQuality:85,
      );

      if(picked!=null){
        selectedImage=File(picked.path);
        imageerror=null;
        notifyListeners();
      }

    }catch(e){
      imageerror=
      "Failed to pick image";
      notifyListeners();
    }
  }



  void removeImage(){
    selectedImage=null;
    imageerror=
      "Please select classroom image";
    notifyListeners();
  }



  void onclassroomnamechanged(
      String value){

    if(value.isEmpty){
      classroomnameerror=
      "Classroom name required";
    }else{
      classroomnameerror=null;
    }

    notifyListeners();
  }



void onstudentcountchanged(
    String value){

if(value.isEmpty){
 studentcounterror=
 "Maximum students required";
}

else if(
 int.tryParse(value)==null){
 studentcounterror=
 "Enter valid number";
}

else{

 int count=int.parse(value);

 if(count<1){
   studentcounterror=
   "Minimum 1 student";
 }

 else if(count>59){
   studentcounterror=
   "Maximum 59 students";
 }

 else{
   studentcounterror=null;
 }

}

notifyListeners();

}



bool _validateForm(){

bool valid=true;


if(selectedImage==null){
 imageerror=
 "Classroom image required";
 valid=false;
}


if(classroomnamecontroller
.text.trim().isEmpty){

 classroomnameerror=
 "Classroom name required";

 valid=false;

}


if(studentcountcontroller
.text.trim().isEmpty){

 studentcounterror=
 "Student count required";

 valid=false;

}

notifyListeners();

return valid;

}



Future<void> oncreateclassroom() async {

if(!_validateForm()) return;

setBusy(true);

try{

final teacherId=
_authService.currentuser?.uid;

if(teacherId==null){
 setBusy(false);
 return;
}

String? imageUrl;

if(selectedImage!=null){

imageUrl=
await _cloudinaryService
.uploadClassroomImage(
imageFile:selectedImage!,
classId:DateTime.now()
.millisecondsSinceEpoch
.toString(),
);

}


final classCode=
await _classroomService
.createclass(
 classname:
 classroomnamecontroller
 .text.trim(),

 teacher_id:teacherId,

 maxstudents:
 int.parse(
 studentcountcontroller
 .text.trim()
 ),

 imageUrl:imageUrl,
);


generatedClassCode=
classCode;


setBusy(false);

notifyListeners();

}
catch(e){

print(e);

setBusy(false);

}

}




void resetClassCode(){

generatedClassCode=null;

selectedImage=null;

classroomnamecontroller.clear();

studentcountcontroller.clear();

imageerror=null;
classroomnameerror=null;
studentcounterror=null;

notifyListeners();

}



@override
void dispose(){

classroomnamecontroller.dispose();

studentcountcontroller.dispose();

super.dispose();

}

}