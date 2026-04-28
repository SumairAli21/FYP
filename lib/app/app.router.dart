// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:englify_app/models/lesson_data_model.dart' as _i37;
import 'package:englify_app/UI/views/auth/auth_view.dart' as _i5;
import 'package:englify_app/UI/views/changepassword/changepassword_view.dart'
    as _i33;
import 'package:englify_app/UI/views/classroomcode/classroom_view.dart' as _i11;
import 'package:englify_app/UI/views/feedback/feedback_view.dart' as _i34;
import 'package:englify_app/UI/views/forgatepassword/forpass_view.dart' as _i12;
import 'package:englify_app/UI/views/login/login_view.dart' as _i7;
import 'package:englify_app/UI/views/onbording/onbording_view.dart' as _i3;
import 'package:englify_app/UI/views/personalization/personalization_view.dart'
    as _i9;
import 'package:englify_app/UI/views/privecy&policy/privecyandpolicy_view.dart'
    as _i17;
import 'package:englify_app/UI/views/Role_selection/role_selection.dart' as _i4;
import 'package:englify_app/UI/views/rules/rules_view.dart' as _i35;
import 'package:englify_app/UI/views/signup/signup_email_view.dart' as _i6;
import 'package:englify_app/UI/views/signup/signup_password_view.dart' as _i8;
import 'package:englify_app/UI/views/splach/splach_view.dart' as _i2;
import 'package:englify_app/UI/views/student_flow/bottom_navigation/bottom_navi_view.dart'
    as _i16;
import 'package:englify_app/UI/views/student_flow/profile/std_profile_view.dart'
    as _i32;
import 'package:englify_app/UI/views/student_flow/quiz_attempt/quiz_attempt_view.dart'
    as _i31;
import 'package:englify_app/UI/views/student_flow/select_lesson/std_select_lesson_view.dart'
    as _i30;
import 'package:englify_app/UI/views/student_flow/std_lesson_detail/std_lessondetail_view.dart'
    as _i29;
import 'package:englify_app/UI/views/student_flow/studenhome/student_home_view.dart'
    as _i13;
import 'package:englify_app/UI/views/student_flow/student_classroom_detail/student_classroom_detai_view.dart'
    as _i28;
import 'package:englify_app/UI/views/student_flow/student_dashboard/student_dashboard_view.dart'
    as _i14;
import 'package:englify_app/UI/views/student_flow/student_fav/student_fav_view.dart'
    as _i15;
import 'package:englify_app/UI/views/teacher_flow/classroom_create/classroom_create_view.dart'
    as _i19;
import 'package:englify_app/UI/views/teacher_flow/classroom_detail/classroomdetail_view.dart'
    as _i24;
import 'package:englify_app/UI/views/teacher_flow/create_lessons/create_lesson_view.dart'
    as _i25;
import 'package:englify_app/UI/views/teacher_flow/create_quiz/create_quiz_view.dart'
    as _i27;
import 'package:englify_app/UI/views/teacher_flow/lesson_detail/lesson_detail_view.dart'
    as _i26;
import 'package:englify_app/UI/views/teacher_flow/teacher_bottom_tabs/teacher_bottom_tab_view.dart'
    as _i23;
import 'package:englify_app/UI/views/teacher_flow/teacher_dashboard/teacher_dashboard_view.dart'
    as _i20;
import 'package:englify_app/UI/views/teacher_flow/teacher_home/teacher_home_view.dart'
    as _i10;
import 'package:englify_app/UI/views/teacher_flow/teacher_profile/teacher_profile_view.dart'
    as _i22;
import 'package:englify_app/UI/views/teacher_flow/teacher_tracker/teacher_tracker_view.dart'
    as _i21;
import 'package:englify_app/UI/views/terms&condition/terms&cond_view.dart'
    as _i18;
import 'package:flutter/material.dart' as _i36;
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i38;

class Routes {
  static const splachView = '/';

  static const onbordingView = '/onbording-view';

  static const roleSelection = '/role-selection';

  static const authView = '/auth-view';

  static const signupemailview = '/Signupemailview';

  static const loginView = '/login-view';

  static const signupPasswordView = '/signup-password-view';

  static const personalizationView = '/personalization-view';

  static const teacherHomeView = '/teacher-home-view';

  static const classroomcodeView = '/classroomcode-view';

  static const forpassView = '/forpass-view';

  static const studentHomeView = '/student-home-view';

  static const studentDashboardView = '/student-dashboard-view';

  static const studentFavView = '/student-fav-view';

  static const bottomNaviView = '/bottom-navi-view';

  static const privecyandpolicyView = '/privecyandpolicy-view';

  static const termsandcondView = '/termsandcond-view';

  static const classroomCreateView = '/classroom-create-view';

  static const teacherDashboardView = '/teacher-dashboard-view';

  static const teacherTrackerView = '/teacher-tracker-view';

  static const teacherProfileView = '/teacher-profile-view';

  static const teacherBottomTabView = '/teacher-bottom-tab-view';

  static const classroomdetailView = '/classroomdetail-view';

  static const createLessonView = '/create-lesson-view';

  static const lessonDetailView = '/lesson-detail-view';

  static const createQuizView = '/create-quiz-view';

  static const studentClassroomDetaiView = '/student-classroom-detai-view';

  static const stdLessondetailView = '/std-lessondetail-view';

  static const stdSelectLessonView = '/std-select-lesson-view';

  static const quizAttemptView = '/quiz-attempt-view';

  static const stdProfileView = '/std-profile-view';

  static const changePasswordView = '/change-password-view';

  static const feedbackView = '/feedback-view';

  static const rulesView = '/rules-view';

  static const all = <String>{
    splachView,
    onbordingView,
    roleSelection,
    authView,
    signupemailview,
    loginView,
    signupPasswordView,
    personalizationView,
    teacherHomeView,
    classroomcodeView,
    forpassView,
    studentHomeView,
    studentDashboardView,
    studentFavView,
    bottomNaviView,
    privecyandpolicyView,
    termsandcondView,
    classroomCreateView,
    teacherDashboardView,
    teacherTrackerView,
    teacherProfileView,
    teacherBottomTabView,
    classroomdetailView,
    createLessonView,
    lessonDetailView,
    createQuizView,
    studentClassroomDetaiView,
    stdLessondetailView,
    stdSelectLessonView,
    quizAttemptView,
    stdProfileView,
    changePasswordView,
    feedbackView,
    rulesView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(Routes.splachView, page: _i2.SplachView),
    _i1.RouteDef(Routes.onbordingView, page: _i3.OnbordingView),
    _i1.RouteDef(Routes.roleSelection, page: _i4.RoleSelection),
    _i1.RouteDef(Routes.authView, page: _i5.AuthView),
    _i1.RouteDef(Routes.signupemailview, page: _i6.Signupemailview),
    _i1.RouteDef(Routes.loginView, page: _i7.LoginView),
    _i1.RouteDef(Routes.signupPasswordView, page: _i8.SignupPasswordView),
    _i1.RouteDef(Routes.personalizationView, page: _i9.PersonalizationView),
    _i1.RouteDef(Routes.teacherHomeView, page: _i10.TeacherHomeView),
    _i1.RouteDef(Routes.classroomcodeView, page: _i11.ClassroomcodeView),
    _i1.RouteDef(Routes.forpassView, page: _i12.ForpassView),
    _i1.RouteDef(Routes.studentHomeView, page: _i13.StudentHomeView),
    _i1.RouteDef(Routes.studentDashboardView, page: _i14.StudentDashboardView),
    _i1.RouteDef(Routes.studentFavView, page: _i15.StudentFavView),
    _i1.RouteDef(Routes.bottomNaviView, page: _i16.BottomNaviView),
    _i1.RouteDef(Routes.privecyandpolicyView, page: _i17.PrivecyandpolicyView),
    _i1.RouteDef(Routes.termsandcondView, page: _i18.TermsandcondView),
    _i1.RouteDef(Routes.classroomCreateView, page: _i19.ClassroomCreateView),
    _i1.RouteDef(Routes.teacherDashboardView, page: _i20.TeacherDashboardView),
    _i1.RouteDef(Routes.teacherTrackerView, page: _i21.TeacherTrackerView),
    _i1.RouteDef(Routes.teacherProfileView, page: _i22.TeacherProfileView),
    _i1.RouteDef(Routes.teacherBottomTabView, page: _i23.TeacherBottomTabView),
    _i1.RouteDef(Routes.classroomdetailView, page: _i24.ClassroomdetailView),
    _i1.RouteDef(Routes.createLessonView, page: _i25.CreateLessonView),
    _i1.RouteDef(Routes.lessonDetailView, page: _i26.LessonDetailView),
    _i1.RouteDef(Routes.createQuizView, page: _i27.CreateQuizView),
    _i1.RouteDef(
      Routes.studentClassroomDetaiView,
      page: _i28.StudentClassroomDetaiView,
    ),
    _i1.RouteDef(Routes.stdLessondetailView, page: _i29.StdLessondetailView),
    _i1.RouteDef(Routes.stdSelectLessonView, page: _i30.StdSelectLessonView),
    _i1.RouteDef(Routes.quizAttemptView, page: _i31.QuizAttemptView),
    _i1.RouteDef(Routes.stdProfileView, page: _i32.StdProfileView),
    _i1.RouteDef(Routes.changePasswordView, page: _i33.ChangePasswordView),
    _i1.RouteDef(Routes.feedbackView, page: _i34.FeedbackView),
    _i1.RouteDef(Routes.rulesView, page: _i35.RulesView),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.SplachView: (data) {
      final args = data.getArgs<SplachViewArguments>(
        orElse: () => const SplachViewArguments(),
      );
      return _i36.MaterialPageRoute<dynamic>(
        builder: (context) => _i2.SplachView(key: args.key),
        settings: data,
      );
    },
    _i3.OnbordingView: (data) {
      final args = data.getArgs<OnbordingViewArguments>(
        orElse: () => const OnbordingViewArguments(),
      );
      return _i36.MaterialPageRoute<dynamic>(
        builder: (context) => _i3.OnbordingView(key: args.key),
        settings: data,
      );
    },
    _i4.RoleSelection: (data) {
      final args = data.getArgs<RoleSelectionArguments>(
        orElse: () => const RoleSelectionArguments(),
      );
      return _i36.MaterialPageRoute<dynamic>(
        builder: (context) => _i4.RoleSelection(key: args.key),
        settings: data,
      );
    },
    _i5.AuthView: (data) {
      final args = data.getArgs<AuthViewArguments>(
        orElse: () => const AuthViewArguments(),
      );
      return _i36.MaterialPageRoute<dynamic>(
        builder: (context) => _i5.AuthView(key: args.key),
        settings: data,
      );
    },
    _i6.Signupemailview: (data) {
      final args = data.getArgs<SignupemailviewArguments>(
        orElse: () => const SignupemailviewArguments(),
      );
      return _i36.MaterialPageRoute<dynamic>(
        builder: (context) => _i6.Signupemailview(key: args.key),
        settings: data,
      );
    },
    _i7.LoginView: (data) {
      final args = data.getArgs<LoginViewArguments>(
        orElse: () => const LoginViewArguments(),
      );
      return _i36.MaterialPageRoute<dynamic>(
        builder: (context) => _i7.LoginView(key: args.key),
        settings: data,
      );
    },
    _i8.SignupPasswordView: (data) {
      final args = data.getArgs<SignupPasswordViewArguments>(nullOk: false);
      return _i36.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i8.SignupPasswordView(key: args.key, email: args.email),
        settings: data,
      );
    },
    _i9.PersonalizationView: (data) {
      final args = data.getArgs<PersonalizationViewArguments>(
        orElse: () => const PersonalizationViewArguments(),
      );
      return _i36.MaterialPageRoute<dynamic>(
        builder: (context) => _i9.PersonalizationView(key: args.key),
        settings: data,
      );
    },
    _i10.TeacherHomeView: (data) {
      final args = data.getArgs<TeacherHomeViewArguments>(
        orElse: () => const TeacherHomeViewArguments(),
      );
      return _i36.MaterialPageRoute<dynamic>(
        builder: (context) => _i10.TeacherHomeView(key: args.key),
        settings: data,
      );
    },
    _i11.ClassroomcodeView: (data) {
      final args = data.getArgs<ClassroomcodeViewArguments>(
        orElse: () => const ClassroomcodeViewArguments(),
      );
      return _i36.MaterialPageRoute<dynamic>(
        builder: (context) => _i11.ClassroomcodeView(key: args.key),
        settings: data,
      );
    },
    _i12.ForpassView: (data) {
      final args = data.getArgs<ForpassViewArguments>(
        orElse: () => const ForpassViewArguments(),
      );
      return _i36.MaterialPageRoute<dynamic>(
        builder: (context) => _i12.ForpassView(key: args.key),
        settings: data,
      );
    },
    _i13.StudentHomeView: (data) {
      final args = data.getArgs<StudentHomeViewArguments>(
        orElse: () => const StudentHomeViewArguments(),
      );
      return _i36.MaterialPageRoute<dynamic>(
        builder: (context) => _i13.StudentHomeView(key: args.key),
        settings: data,
      );
    },
    _i14.StudentDashboardView: (data) {
      final args = data.getArgs<StudentDashboardViewArguments>(
        orElse: () => const StudentDashboardViewArguments(),
      );
      return _i36.MaterialPageRoute<dynamic>(
        builder: (context) => _i14.StudentDashboardView(key: args.key),
        settings: data,
      );
    },
    _i15.StudentFavView: (data) {
      final args = data.getArgs<StudentFavViewArguments>(
        orElse: () => const StudentFavViewArguments(),
      );
      return _i36.MaterialPageRoute<dynamic>(
        builder: (context) => _i15.StudentFavView(key: args.key),
        settings: data,
      );
    },
    _i16.BottomNaviView: (data) {
      final args = data.getArgs<BottomNaviViewArguments>(
        orElse: () => const BottomNaviViewArguments(),
      );
      return _i36.MaterialPageRoute<dynamic>(
        builder: (context) => _i16.BottomNaviView(key: args.key),
        settings: data,
      );
    },
    _i17.PrivecyandpolicyView: (data) {
      final args = data.getArgs<PrivecyandpolicyViewArguments>(
        orElse: () => const PrivecyandpolicyViewArguments(),
      );
      return _i36.MaterialPageRoute<dynamic>(
        builder: (context) => _i17.PrivecyandpolicyView(key: args.key),
        settings: data,
      );
    },
    _i18.TermsandcondView: (data) {
      final args = data.getArgs<TermsandcondViewArguments>(
        orElse: () => const TermsandcondViewArguments(),
      );
      return _i36.MaterialPageRoute<dynamic>(
        builder: (context) => _i18.TermsandcondView(key: args.key),
        settings: data,
      );
    },
    _i19.ClassroomCreateView: (data) {
      final args = data.getArgs<ClassroomCreateViewArguments>(
        orElse: () => const ClassroomCreateViewArguments(),
      );
      return _i36.MaterialPageRoute<dynamic>(
        builder: (context) => _i19.ClassroomCreateView(key: args.key),
        settings: data,
      );
    },
    _i20.TeacherDashboardView: (data) {
      final args = data.getArgs<TeacherDashboardViewArguments>(
        orElse: () => const TeacherDashboardViewArguments(),
      );
      return _i36.MaterialPageRoute<dynamic>(
        builder: (context) => _i20.TeacherDashboardView(key: args.key),
        settings: data,
      );
    },
    _i21.TeacherTrackerView: (data) {
      final args = data.getArgs<TeacherTrackerViewArguments>(
        orElse: () => const TeacherTrackerViewArguments(),
      );
      return _i36.MaterialPageRoute<dynamic>(
        builder: (context) => _i21.TeacherTrackerView(key: args.key),
        settings: data,
      );
    },
    _i22.TeacherProfileView: (data) {
      final args = data.getArgs<TeacherProfileViewArguments>(
        orElse: () => const TeacherProfileViewArguments(),
      );
      return _i36.MaterialPageRoute<dynamic>(
        builder: (context) => _i22.TeacherProfileView(key: args.key),
        settings: data,
      );
    },
    _i23.TeacherBottomTabView: (data) {
      final args = data.getArgs<TeacherBottomTabViewArguments>(
        orElse: () => const TeacherBottomTabViewArguments(),
      );
      return _i36.MaterialPageRoute<dynamic>(
        builder: (context) => _i23.TeacherBottomTabView(key: args.key),
        settings: data,
      );
    },
    _i24.ClassroomdetailView: (data) {
      final args = data.getArgs<ClassroomdetailViewArguments>(nullOk: false);
      return _i36.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i24.ClassroomdetailView(key: args.key, classroom: args.classroom),
        settings: data,
      );
    },
    _i25.CreateLessonView: (data) {
      final args = data.getArgs<CreateLessonViewArguments>(nullOk: false);
      return _i36.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i25.CreateLessonView(key: args.key, classid: args.classid),
        settings: data,
      );
    },
    _i26.LessonDetailView: (data) {
      final args = data.getArgs<LessonDetailViewArguments>(nullOk: false);
      return _i36.MaterialPageRoute<dynamic>(
        builder: (context) => _i26.LessonDetailView(
          key: args.key,
          classroom: args.classroom,
          lessons: args.lessons,
        ),
        settings: data,
      );
    },
    _i27.CreateQuizView: (data) {
      final args = data.getArgs<CreateQuizViewArguments>(nullOk: false);
      return _i36.MaterialPageRoute<dynamic>(
        builder: (context) => _i27.CreateQuizView(
          key: args.key,
          classid: args.classid,
          lessonid: args.lessonid,
          lessontitle: args.lessontitle,
        ),
        settings: data,
      );
    },
    _i28.StudentClassroomDetaiView: (data) {
      final args = data.getArgs<StudentClassroomDetaiViewArguments>(
        nullOk: false,
      );
      return _i36.MaterialPageRoute<dynamic>(
        builder: (context) => _i28.StudentClassroomDetaiView(
          key: args.key,
          classroom: args.classroom,
        ),
        settings: data,
      );
    },
    _i29.StdLessondetailView: (data) {
      final args = data.getArgs<StdLessondetailViewArguments>(nullOk: false);
      return _i36.MaterialPageRoute<dynamic>(
        builder: (context) => _i29.StdLessondetailView(
          key: args.key,
          lesson: args.lesson,
          classroom: args.classroom,
        ),
        settings: data,
      );
    },
    _i30.StdSelectLessonView: (data) {
      final args = data.getArgs<StdSelectLessonViewArguments>(nullOk: false);
      return _i36.MaterialPageRoute<dynamic>(
        builder: (context) => _i30.StdSelectLessonView(
          key: args.key,
          lesson: args.lesson,
          classroom: args.classroom,
        ),
        settings: data,
      );
    },
    _i31.QuizAttemptView: (data) {
      final args = data.getArgs<QuizAttemptViewArguments>(nullOk: false);
      return _i36.MaterialPageRoute<dynamic>(
        builder: (context) => _i31.QuizAttemptView(
          key: args.key,
          classId: args.classId,
          lessonId: args.lessonId,
          lessonTitle: args.lessonTitle,
        ),
        settings: data,
      );
    },
    _i32.StdProfileView: (data) {
      final args = data.getArgs<StdProfileViewArguments>(
        orElse: () => const StdProfileViewArguments(),
      );
      return _i36.MaterialPageRoute<dynamic>(
        builder: (context) => _i32.StdProfileView(key: args.key),
        settings: data,
      );
    },
    _i33.ChangePasswordView: (data) {
      final args = data.getArgs<ChangePasswordViewArguments>(
        orElse: () => const ChangePasswordViewArguments(),
      );
      return _i36.MaterialPageRoute<dynamic>(
        builder: (context) => _i33.ChangePasswordView(key: args.key),
        settings: data,
      );
    },
    _i34.FeedbackView: (data) {
      final args = data.getArgs<FeedbackViewArguments>(
        orElse: () => const FeedbackViewArguments(),
      );
      return _i36.MaterialPageRoute<dynamic>(
        builder: (context) => _i34.FeedbackView(key: args.key),
        settings: data,
      );
    },
    _i35.RulesView: (data) {
      final args = data.getArgs<RulesViewArguments>(
        orElse: () => const RulesViewArguments(),
      );
      return _i36.MaterialPageRoute<dynamic>(
        builder: (context) => _i35.RulesView(key: args.key),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class SplachViewArguments {
  const SplachViewArguments({this.key});

  final _i36.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant SplachViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class OnbordingViewArguments {
  const OnbordingViewArguments({this.key});

  final _i36.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant OnbordingViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class RoleSelectionArguments {
  const RoleSelectionArguments({this.key});

  final _i36.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant RoleSelectionArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class AuthViewArguments {
  const AuthViewArguments({this.key});

  final _i36.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant AuthViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class SignupemailviewArguments {
  const SignupemailviewArguments({this.key});

  final _i36.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant SignupemailviewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class LoginViewArguments {
  const LoginViewArguments({this.key});

  final _i36.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant LoginViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class SignupPasswordViewArguments {
  const SignupPasswordViewArguments({this.key, required this.email});

  final _i36.Key? key;

  final String email;

  @override
  String toString() {
    return '{"key": "$key", "email": "$email"}';
  }

  @override
  bool operator ==(covariant SignupPasswordViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.email == email;
  }

  @override
  int get hashCode {
    return key.hashCode ^ email.hashCode;
  }
}

class PersonalizationViewArguments {
  const PersonalizationViewArguments({this.key});

  final _i36.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant PersonalizationViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class TeacherHomeViewArguments {
  const TeacherHomeViewArguments({this.key});

  final _i36.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant TeacherHomeViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class ClassroomcodeViewArguments {
  const ClassroomcodeViewArguments({this.key});

  final _i36.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant ClassroomcodeViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class ForpassViewArguments {
  const ForpassViewArguments({this.key});

  final _i36.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant ForpassViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class StudentHomeViewArguments {
  const StudentHomeViewArguments({this.key});

  final _i36.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant StudentHomeViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class StudentDashboardViewArguments {
  const StudentDashboardViewArguments({this.key});

  final _i36.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant StudentDashboardViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class StudentFavViewArguments {
  const StudentFavViewArguments({this.key});

  final _i36.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant StudentFavViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class BottomNaviViewArguments {
  const BottomNaviViewArguments({this.key});

  final _i36.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant BottomNaviViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class PrivecyandpolicyViewArguments {
  const PrivecyandpolicyViewArguments({this.key});

  final _i36.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant PrivecyandpolicyViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class TermsandcondViewArguments {
  const TermsandcondViewArguments({this.key});

  final _i36.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant TermsandcondViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class ClassroomCreateViewArguments {
  const ClassroomCreateViewArguments({this.key});

  final _i36.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant ClassroomCreateViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class TeacherDashboardViewArguments {
  const TeacherDashboardViewArguments({this.key});

  final _i36.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant TeacherDashboardViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class TeacherTrackerViewArguments {
  const TeacherTrackerViewArguments({this.key});

  final _i36.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant TeacherTrackerViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class TeacherProfileViewArguments {
  const TeacherProfileViewArguments({this.key});

  final _i36.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant TeacherProfileViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class TeacherBottomTabViewArguments {
  const TeacherBottomTabViewArguments({this.key});

  final _i36.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant TeacherBottomTabViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class ClassroomdetailViewArguments {
  const ClassroomdetailViewArguments({this.key, required this.classroom});

  final _i36.Key? key;

  final Map<String, dynamic> classroom;

  @override
  String toString() {
    return '{"key": "$key", "classroom": "$classroom"}';
  }

  @override
  bool operator ==(covariant ClassroomdetailViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.classroom == classroom;
  }

  @override
  int get hashCode {
    return key.hashCode ^ classroom.hashCode;
  }
}

class CreateLessonViewArguments {
  const CreateLessonViewArguments({this.key, required this.classid});

  final _i36.Key? key;

  final String classid;

  @override
  String toString() {
    return '{"key": "$key", "classid": "$classid"}';
  }

  @override
  bool operator ==(covariant CreateLessonViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.classid == classid;
  }

  @override
  int get hashCode {
    return key.hashCode ^ classid.hashCode;
  }
}

class LessonDetailViewArguments {
  const LessonDetailViewArguments({
    this.key,
    required this.classroom,
    required this.lessons,
  });

  final _i36.Key? key;

  final Map<String, dynamic> classroom;

  final _i37.LessonData lessons;

  @override
  String toString() {
    return '{"key": "$key", "classroom": "$classroom", "lessons": "$lessons"}';
  }

  @override
  bool operator ==(covariant LessonDetailViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.classroom == classroom &&
        other.lessons == lessons;
  }

  @override
  int get hashCode {
    return key.hashCode ^ classroom.hashCode ^ lessons.hashCode;
  }
}

class CreateQuizViewArguments {
  const CreateQuizViewArguments({
    this.key,
    required this.classid,
    required this.lessonid,
    required this.lessontitle,
  });

  final _i36.Key? key;

  final String classid;

  final String lessonid;

  final String lessontitle;

  @override
  String toString() {
    return '{"key": "$key", "classid": "$classid", "lessonid": "$lessonid", "lessontitle": "$lessontitle"}';
  }

  @override
  bool operator ==(covariant CreateQuizViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.classid == classid &&
        other.lessonid == lessonid &&
        other.lessontitle == lessontitle;
  }

  @override
  int get hashCode {
    return key.hashCode ^
        classid.hashCode ^
        lessonid.hashCode ^
        lessontitle.hashCode;
  }
}

class StudentClassroomDetaiViewArguments {
  const StudentClassroomDetaiViewArguments({this.key, required this.classroom});

  final _i36.Key? key;

  final Map<String, dynamic> classroom;

  @override
  String toString() {
    return '{"key": "$key", "classroom": "$classroom"}';
  }

  @override
  bool operator ==(covariant StudentClassroomDetaiViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.classroom == classroom;
  }

  @override
  int get hashCode {
    return key.hashCode ^ classroom.hashCode;
  }
}

class StdLessondetailViewArguments {
  const StdLessondetailViewArguments({
    this.key,
    required this.lesson,
    required this.classroom,
  });

  final _i36.Key? key;

  final _i37.LessonData lesson;

  final Map<String, dynamic> classroom;

  @override
  String toString() {
    return '{"key": "$key", "lesson": "$lesson", "classroom": "$classroom"}';
  }

  @override
  bool operator ==(covariant StdLessondetailViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.lesson == lesson &&
        other.classroom == classroom;
  }

  @override
  int get hashCode {
    return key.hashCode ^ lesson.hashCode ^ classroom.hashCode;
  }
}

class StdSelectLessonViewArguments {
  const StdSelectLessonViewArguments({
    this.key,
    required this.lesson,
    required this.classroom,
  });

  final _i36.Key? key;

  final _i37.LessonData lesson;

  final Map<String, dynamic> classroom;

  @override
  String toString() {
    return '{"key": "$key", "lesson": "$lesson", "classroom": "$classroom"}';
  }

  @override
  bool operator ==(covariant StdSelectLessonViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.lesson == lesson &&
        other.classroom == classroom;
  }

  @override
  int get hashCode {
    return key.hashCode ^ lesson.hashCode ^ classroom.hashCode;
  }
}

class QuizAttemptViewArguments {
  const QuizAttemptViewArguments({
    this.key,
    required this.classId,
    required this.lessonId,
    required this.lessonTitle,
  });

  final _i36.Key? key;

  final String classId;

  final String lessonId;

  final String lessonTitle;

  @override
  String toString() {
    return '{"key": "$key", "classId": "$classId", "lessonId": "$lessonId", "lessonTitle": "$lessonTitle"}';
  }

  @override
  bool operator ==(covariant QuizAttemptViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.classId == classId &&
        other.lessonId == lessonId &&
        other.lessonTitle == lessonTitle;
  }

  @override
  int get hashCode {
    return key.hashCode ^
        classId.hashCode ^
        lessonId.hashCode ^
        lessonTitle.hashCode;
  }
}

class StdProfileViewArguments {
  const StdProfileViewArguments({this.key});

  final _i36.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant StdProfileViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class ChangePasswordViewArguments {
  const ChangePasswordViewArguments({this.key});

  final _i36.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant ChangePasswordViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class FeedbackViewArguments {
  const FeedbackViewArguments({this.key});

  final _i36.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant FeedbackViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class RulesViewArguments {
  const RulesViewArguments({this.key});

  final _i36.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant RulesViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

extension NavigatorStateExtension on _i38.NavigationService {
  Future<dynamic> navigateToSplachView({
    _i36.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.splachView,
      arguments: SplachViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToOnbordingView({
    _i36.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.onbordingView,
      arguments: OnbordingViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToRoleSelection({
    _i36.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.roleSelection,
      arguments: RoleSelectionArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToAuthView({
    _i36.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.authView,
      arguments: AuthViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToSignupemailview({
    _i36.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.signupemailview,
      arguments: SignupemailviewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToLoginView({
    _i36.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.loginView,
      arguments: LoginViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToSignupPasswordView({
    _i36.Key? key,
    required String email,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.signupPasswordView,
      arguments: SignupPasswordViewArguments(key: key, email: email),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToPersonalizationView({
    _i36.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.personalizationView,
      arguments: PersonalizationViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToTeacherHomeView({
    _i36.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.teacherHomeView,
      arguments: TeacherHomeViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToClassroomcodeView({
    _i36.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.classroomcodeView,
      arguments: ClassroomcodeViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToForpassView({
    _i36.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.forpassView,
      arguments: ForpassViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToStudentHomeView({
    _i36.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.studentHomeView,
      arguments: StudentHomeViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToStudentDashboardView({
    _i36.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.studentDashboardView,
      arguments: StudentDashboardViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToStudentFavView({
    _i36.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.studentFavView,
      arguments: StudentFavViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToBottomNaviView({
    _i36.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.bottomNaviView,
      arguments: BottomNaviViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToPrivecyandpolicyView({
    _i36.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.privecyandpolicyView,
      arguments: PrivecyandpolicyViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToTermsandcondView({
    _i36.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.termsandcondView,
      arguments: TermsandcondViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToClassroomCreateView({
    _i36.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.classroomCreateView,
      arguments: ClassroomCreateViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToTeacherDashboardView({
    _i36.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.teacherDashboardView,
      arguments: TeacherDashboardViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToTeacherTrackerView({
    _i36.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.teacherTrackerView,
      arguments: TeacherTrackerViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToTeacherProfileView({
    _i36.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.teacherProfileView,
      arguments: TeacherProfileViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToTeacherBottomTabView({
    _i36.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.teacherBottomTabView,
      arguments: TeacherBottomTabViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToClassroomdetailView({
    _i36.Key? key,
    required Map<String, dynamic> classroom,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.classroomdetailView,
      arguments: ClassroomdetailViewArguments(key: key, classroom: classroom),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToCreateLessonView({
    _i36.Key? key,
    required String classid,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.createLessonView,
      arguments: CreateLessonViewArguments(key: key, classid: classid),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToLessonDetailView({
    _i36.Key? key,
    required Map<String, dynamic> classroom,
    required _i37.LessonData lessons,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.lessonDetailView,
      arguments: LessonDetailViewArguments(
        key: key,
        classroom: classroom,
        lessons: lessons,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToCreateQuizView({
    _i36.Key? key,
    required String classid,
    required String lessonid,
    required String lessontitle,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.createQuizView,
      arguments: CreateQuizViewArguments(
        key: key,
        classid: classid,
        lessonid: lessonid,
        lessontitle: lessontitle,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToStudentClassroomDetaiView({
    _i36.Key? key,
    required Map<String, dynamic> classroom,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.studentClassroomDetaiView,
      arguments: StudentClassroomDetaiViewArguments(
        key: key,
        classroom: classroom,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToStdLessondetailView({
    _i36.Key? key,
    required _i37.LessonData lesson,
    required Map<String, dynamic> classroom,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.stdLessondetailView,
      arguments: StdLessondetailViewArguments(
        key: key,
        lesson: lesson,
        classroom: classroom,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToStdSelectLessonView({
    _i36.Key? key,
    required _i37.LessonData lesson,
    required Map<String, dynamic> classroom,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.stdSelectLessonView,
      arguments: StdSelectLessonViewArguments(
        key: key,
        lesson: lesson,
        classroom: classroom,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToQuizAttemptView({
    _i36.Key? key,
    required String classId,
    required String lessonId,
    required String lessonTitle,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.quizAttemptView,
      arguments: QuizAttemptViewArguments(
        key: key,
        classId: classId,
        lessonId: lessonId,
        lessonTitle: lessonTitle,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToStdProfileView({
    _i36.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.stdProfileView,
      arguments: StdProfileViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToChangePasswordView({
    _i36.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.changePasswordView,
      arguments: ChangePasswordViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToFeedbackView({
    _i36.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.feedbackView,
      arguments: FeedbackViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToRulesView({
    _i36.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.rulesView,
      arguments: RulesViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithSplachView({
    _i36.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.splachView,
      arguments: SplachViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithOnbordingView({
    _i36.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.onbordingView,
      arguments: OnbordingViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithRoleSelection({
    _i36.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.roleSelection,
      arguments: RoleSelectionArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithAuthView({
    _i36.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.authView,
      arguments: AuthViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithSignupemailview({
    _i36.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.signupemailview,
      arguments: SignupemailviewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithLoginView({
    _i36.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.loginView,
      arguments: LoginViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithSignupPasswordView({
    _i36.Key? key,
    required String email,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.signupPasswordView,
      arguments: SignupPasswordViewArguments(key: key, email: email),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithPersonalizationView({
    _i36.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.personalizationView,
      arguments: PersonalizationViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithTeacherHomeView({
    _i36.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.teacherHomeView,
      arguments: TeacherHomeViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithClassroomcodeView({
    _i36.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.classroomcodeView,
      arguments: ClassroomcodeViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithForpassView({
    _i36.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.forpassView,
      arguments: ForpassViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithStudentHomeView({
    _i36.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.studentHomeView,
      arguments: StudentHomeViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithStudentDashboardView({
    _i36.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.studentDashboardView,
      arguments: StudentDashboardViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithStudentFavView({
    _i36.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.studentFavView,
      arguments: StudentFavViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithBottomNaviView({
    _i36.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.bottomNaviView,
      arguments: BottomNaviViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithPrivecyandpolicyView({
    _i36.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.privecyandpolicyView,
      arguments: PrivecyandpolicyViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithTermsandcondView({
    _i36.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.termsandcondView,
      arguments: TermsandcondViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithClassroomCreateView({
    _i36.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.classroomCreateView,
      arguments: ClassroomCreateViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithTeacherDashboardView({
    _i36.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.teacherDashboardView,
      arguments: TeacherDashboardViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithTeacherTrackerView({
    _i36.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.teacherTrackerView,
      arguments: TeacherTrackerViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithTeacherProfileView({
    _i36.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.teacherProfileView,
      arguments: TeacherProfileViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithTeacherBottomTabView({
    _i36.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.teacherBottomTabView,
      arguments: TeacherBottomTabViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithClassroomdetailView({
    _i36.Key? key,
    required Map<String, dynamic> classroom,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.classroomdetailView,
      arguments: ClassroomdetailViewArguments(key: key, classroom: classroom),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithCreateLessonView({
    _i36.Key? key,
    required String classid,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.createLessonView,
      arguments: CreateLessonViewArguments(key: key, classid: classid),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithLessonDetailView({
    _i36.Key? key,
    required Map<String, dynamic> classroom,
    required _i37.LessonData lessons,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.lessonDetailView,
      arguments: LessonDetailViewArguments(
        key: key,
        classroom: classroom,
        lessons: lessons,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithCreateQuizView({
    _i36.Key? key,
    required String classid,
    required String lessonid,
    required String lessontitle,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.createQuizView,
      arguments: CreateQuizViewArguments(
        key: key,
        classid: classid,
        lessonid: lessonid,
        lessontitle: lessontitle,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithStudentClassroomDetaiView({
    _i36.Key? key,
    required Map<String, dynamic> classroom,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.studentClassroomDetaiView,
      arguments: StudentClassroomDetaiViewArguments(
        key: key,
        classroom: classroom,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithStdLessondetailView({
    _i36.Key? key,
    required _i37.LessonData lesson,
    required Map<String, dynamic> classroom,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.stdLessondetailView,
      arguments: StdLessondetailViewArguments(
        key: key,
        lesson: lesson,
        classroom: classroom,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithStdSelectLessonView({
    _i36.Key? key,
    required _i37.LessonData lesson,
    required Map<String, dynamic> classroom,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.stdSelectLessonView,
      arguments: StdSelectLessonViewArguments(
        key: key,
        lesson: lesson,
        classroom: classroom,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithQuizAttemptView({
    _i36.Key? key,
    required String classId,
    required String lessonId,
    required String lessonTitle,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.quizAttemptView,
      arguments: QuizAttemptViewArguments(
        key: key,
        classId: classId,
        lessonId: lessonId,
        lessonTitle: lessonTitle,
      ),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithStdProfileView({
    _i36.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.stdProfileView,
      arguments: StdProfileViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithChangePasswordView({
    _i36.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.changePasswordView,
      arguments: ChangePasswordViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithFeedbackView({
    _i36.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.feedbackView,
      arguments: FeedbackViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithRulesView({
    _i36.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.rulesView,
      arguments: RulesViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }
}
