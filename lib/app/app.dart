import 'package:englify_app/UI/views/Role_selection/role_selection.dart';
import 'package:englify_app/UI/views/auth/auth_view.dart';
import 'package:englify_app/UI/views/classroomcode/classroom_view.dart';
import 'package:englify_app/UI/views/forgatepassword/forpass_view.dart';
import 'package:englify_app/UI/views/login/login_view.dart';
import 'package:englify_app/UI/views/onbording/onbording_view.dart';
import 'package:englify_app/UI/views/personalization/personalization_view.dart';
import 'package:englify_app/UI/views/signup/signup_email_view.dart';
import 'package:englify_app/UI/views/signup/signup_password_view.dart';
import 'package:englify_app/UI/views/splach/splach_view.dart';
import 'package:englify_app/UI/views/teacher/teacher_home/teacher_home_view.dart';
import 'package:englify_app/services/DB_service.dart';
import 'package:englify_app/services/local_storage_service.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: SplachView, initial: true),
    MaterialRoute(page: OnbordingView),
    MaterialRoute(page: RoleSelection),
    MaterialRoute(page: AuthView),
    MaterialRoute(page: Signupemailview),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: SignupPasswordView),
    MaterialRoute(page: PersonalizationView),
    MaterialRoute(page: TeacherHomeView),
    MaterialRoute(page: ClassroomcodeView),
    MaterialRoute(page: ForpassView),

  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: LocalStorageService),
    LazySingleton(classType: DbService)
  ],
)
class App {}
