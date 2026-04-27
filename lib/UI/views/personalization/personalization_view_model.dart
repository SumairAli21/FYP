import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/app/app.router.dart';
import 'package:englify_app/services/auth_service.dart';
import 'package:englify_app/services/local_storage_service.dart';
import 'package:englify_app/services/classroom_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PersonalizationViewModel
extends BaseViewModel {

final _navigationservice=
locator<NavigationService>();

final _localstorageservice=
locator<LocalStorageService>();

final _authservice=
locator<AuthService>();

final _classroomservice=
locator<classroomservice>();


final usernamecontroller=
TextEditingController();


String? errormessage;



Future<void> oncontinue() async {

errormessage=null;
notifyListeners();

final username=
usernamecontroller.text.trim();


if(username.isEmpty){

errormessage=
"Please enter your name";

notifyListeners();

return;

}


if(username.length<2){

errormessage=
"Name must be at least 2 characters";

notifyListeners();

return;

}


setBusy(true);


try{

await _localstorageservice
.saveusername(username);

print(
"Username saved: $username"
);


final savedName=
await _localstorageservice
.getusername();

if(savedName!=username){
throw Exception(
"Username save failed"
);
}



final user=
_authservice.currentuser;



if(user!=null){

try{

final hasClasses=
await _classroomservice
.hasStudentJoinedAnyClass(
user.uid
);


if(hasClasses){

await _localstorageservice
.setclassroomjointrue();

setBusy(false);

_navigationservice
.replaceWithBottomNaviView();

return;

}

else{

setBusy(false);

_navigationservice
.replaceWithClassroomcodeView();

return;

}

}

catch(e){

print(
"Class check error $e"
);

setBusy(false);

_navigationservice
.replaceWithClassroomcodeView();

return;

}

}



setBusy(false);

_navigationservice
.replaceWithClassroomcodeView();

}

catch(e){

print(e);

setBusy(false);

errormessage=
"Failed to save. Try again.";

notifyListeners();

}

}



@override
void dispose(){

usernamecontroller.dispose();

super.dispose();

}

}