// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:englify_app/UI/views/auth/auth_view.dart' as _i5;
import 'package:englify_app/UI/views/login/login_view.dart' as _i7;
import 'package:englify_app/UI/views/onbording/onbording_view.dart' as _i3;
import 'package:englify_app/UI/views/Role_selection/role_selection.dart' as _i4;
import 'package:englify_app/UI/views/signup/signup_email_view.dart' as _i6;
import 'package:englify_app/UI/views/signup/signup_password_view.dart' as _i8;
import 'package:englify_app/UI/views/splach/splach_view.dart' as _i2;
import 'package:flutter/material.dart' as _i9;
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i10;

class Routes {
  static const splachView = '/';

  static const onbordingView = '/onbording-view';

  static const roleSelection = '/role-selection';

  static const authView = '/auth-view';

  static const signupemailview = '/Signupemailview';

  static const loginView = '/login-view';

  static const signupPasswordView = '/signup-password-view';

  static const all = <String>{
    splachView,
    onbordingView,
    roleSelection,
    authView,
    signupemailview,
    loginView,
    signupPasswordView,
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
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.SplachView: (data) {
      final args = data.getArgs<SplachViewArguments>(
        orElse: () => const SplachViewArguments(),
      );
      return _i9.MaterialPageRoute<dynamic>(
        builder: (context) => _i2.SplachView(key: args.key),
        settings: data,
      );
    },
    _i3.OnbordingView: (data) {
      final args = data.getArgs<OnbordingViewArguments>(
        orElse: () => const OnbordingViewArguments(),
      );
      return _i9.MaterialPageRoute<dynamic>(
        builder: (context) => _i3.OnbordingView(key: args.key),
        settings: data,
      );
    },
    _i4.RoleSelection: (data) {
      final args = data.getArgs<RoleSelectionArguments>(
        orElse: () => const RoleSelectionArguments(),
      );
      return _i9.MaterialPageRoute<dynamic>(
        builder: (context) => _i4.RoleSelection(key: args.key),
        settings: data,
      );
    },
    _i5.AuthView: (data) {
      final args = data.getArgs<AuthViewArguments>(
        orElse: () => const AuthViewArguments(),
      );
      return _i9.MaterialPageRoute<dynamic>(
        builder: (context) => _i5.AuthView(key: args.key),
        settings: data,
      );
    },
    _i6.Signupemailview: (data) {
      final args = data.getArgs<SignupemailviewArguments>(
        orElse: () => const SignupemailviewArguments(),
      );
      return _i9.MaterialPageRoute<dynamic>(
        builder: (context) => _i6.Signupemailview(key: args.key),
        settings: data,
      );
    },
    _i7.LoginView: (data) {
      final args = data.getArgs<LoginViewArguments>(
        orElse: () => const LoginViewArguments(),
      );
      return _i9.MaterialPageRoute<dynamic>(
        builder: (context) => _i7.LoginView(key: args.key),
        settings: data,
      );
    },
    _i8.SignupPasswordView: (data) {
      final args = data.getArgs<SignupPasswordViewArguments>(
        orElse: () => const SignupPasswordViewArguments(),
      );
      return _i9.MaterialPageRoute<dynamic>(
        builder: (context) => _i8.SignupPasswordView(key: args.key),
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

  final _i9.Key? key;

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

  final _i9.Key? key;

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

  final _i9.Key? key;

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

  final _i9.Key? key;

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

  final _i9.Key? key;

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

  final _i9.Key? key;

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
  const SignupPasswordViewArguments({this.key});

  final _i9.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant SignupPasswordViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

extension NavigatorStateExtension on _i10.NavigationService {
  Future<dynamic> navigateToSplachView({
    _i9.Key? key,
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
    _i9.Key? key,
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
    _i9.Key? key,
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
    _i9.Key? key,
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
    _i9.Key? key,
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
    _i9.Key? key,
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
    _i9.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return navigateTo<dynamic>(
      Routes.signupPasswordView,
      arguments: SignupPasswordViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> replaceWithSplachView({
    _i9.Key? key,
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
    _i9.Key? key,
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
    _i9.Key? key,
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
    _i9.Key? key,
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
    _i9.Key? key,
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
    _i9.Key? key,
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
    _i9.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
    transition,
  }) async {
    return replaceWith<dynamic>(
      Routes.signupPasswordView,
      arguments: SignupPasswordViewArguments(key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }
}
