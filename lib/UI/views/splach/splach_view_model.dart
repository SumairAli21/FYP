import 'package:englify_app/app/app.locator.dart';
import 'package:englify_app/app/app.router.dart';
import 'package:englify_app/services/local_storage_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SplachViewModel extends BaseViewModel {
  final _localstorage = locator<LocalStorageService>();
  final _navigationservice = locator<NavigationService>();

  Future<void> runsetuplogic() async {
    await Future.delayed(Duration(seconds: 3));

    final isfirstlaunch = await _localstorage.isfirstlaunch();

    if (isfirstlaunch) {
      _navigationservice.replaceWithOnbordingView();
      return;
    }
    final role = await _localstorage.getuserrole();
    if (role == null) {
      _navigationservice.replaceWithRoleSelection();
      return;
    }
    final login = await _localstorage.getislogin();
    if (!login) {
      _navigationservice.replaceWithAuthView();
      return;
    }
    if (role == "teacher") {
      _navigationservice.replaceWithTeacherHomeView();
      return;
    }
    final classroomjoin = await _localstorage.isclassroomjoined();
    if (!classroomjoin) {
      _navigationservice.replaceWithPersonalizationView();
      return;
    }
    _navigationservice.replaceWithStudentHomeView();
  }
}



// yea kam krne se phele hume is pe focus krna hoga take time waste na ho hamara ok bat suno hum ofline DB use kr rehy hain toh yea teacher or student ko interact kese kr way ga like teacher koi content upload kre ga wo toh aus ke app ke ofline DB me store hoga na student ke pass toh alag app hoga aus ka data base bh alag bane ga ofline like teacher ne class create ki wo toh ausi ke DB me store hogi na ise kese handle krengay hum   bohot solid sawal hai 👍 aur honestly — FYP level ka real-world question hai. Tum bilkul sahi soch rahe ho.  Main pehle problem ko clear words me bolta hoon, phir practical solutions deta hoon (simple → advanced).  🔴 CORE PROBLEM (jo tum feel kar rahe ho) English:  Tum offline local DB (SQLite) use kar rahe ho  Teacher aur Student alag devices pe hain  Teacher ka data sirf usi ke phone ki DB me save hota hai  Student ke phone me wo data pohanch hi nahi sakta   HYBRID MODEL (Offline + Online)

// Ye tumhare FYP ke liye PERFECT hai

// Kaise kaam karega?
// Cheez	Kaise
// Login	Offline (SQLite)
// Name, Role	Local Storage
// Teacher Content	Online (Firebase / API)
// Student Fetch	Internet se
// Reading	Offline cache possible
// FLOW (simple):
// 👨‍🏫 Teacher

// Login (offline ok)

// Class create kare

// Content upload kare

// Content internet pe Firebase / API me save

// 👨‍🎓 Student

// Login

// Class code enter kare

// App server se data fetch kare

// Student dekhe / sunay / read kare

// 📌 Internet sirf sync ke liye use hota hai

// Tools (easy & free)

// 🔥 Firebase Firestore (BEST)

// Firebase Storage (audio files)

// Firebase Auth (optional)

// Examiner ko bolo:
// “Offline-first architecture with online synchronization”
