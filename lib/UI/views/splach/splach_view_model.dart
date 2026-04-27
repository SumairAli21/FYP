import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/app/app.router.dart';
import 'package:englify_app/services/auth_service.dart';
import 'package:englify_app/services/local_storage_service.dart';
import 'package:englify_app/services/classroom_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SplachViewModel extends BaseViewModel {

 final _localstorage=
 locator<LocalStorageService>();

 final _navigationservice=
 locator<NavigationService>();

 final _authservice=
 locator<AuthService>();

 final _classroomservice=
 locator<classroomservice>();


 Future<void> runsetuplogic() async {

 await Future.delayed(
 Duration(seconds:3)
 );


 final isfirstlaunch=
 await _localstorage
 .isfirstlaunch();

 if(isfirstlaunch){

 _navigationservice
 .replaceWithOnbordingView();

 return;

 }



 final role=
 await _localstorage
 .getuserrole();

 if(role==null){

 _navigationservice
 .replaceWithRoleSelection();

 return;

 }



 final login=
 await _localstorage
 .getislogin();

 if(!login){

 _navigationservice
 .replaceWithAuthView();

 return;

 }



 // TEACHER FLOW
 if(role=="teacher"){

 _navigationservice
 .replaceWithTeacherBottomTabView();

 return;

 }



 // STUDENT FLOW
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

 await _localstorage
 .setclassroomjointrue();

 _navigationservice
 .replaceWithBottomNaviView();

 return;

 }

 else{

 await _localstorage
 .clearclassroomjoin();

 _navigationservice
 .replaceWithPersonalizationView();

 return;

 }

 }

 catch(e){

 print(
 "Error checking classes: $e"
 );

 _navigationservice
 .replaceWithPersonalizationView();

 return;

 }

 }


 // fallback
 _navigationservice
 .replaceWithPersonalizationView();

 }

}