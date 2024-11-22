import 'package:flutter/material.dart';
import 'package:post_app/utility/routs/routsname.dart';
import 'package:post_app/view/add_post.dart';
import 'package:post_app/view/auth_view/login_view.dart';
import 'package:post_app/view/auth_view/signup_view.dart';
import 'package:post_app/view/post.dart';
import 'package:post_app/view/splash_view.dart';

class Routs {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routsname.home:
        return MaterialPageRoute(
          builder: (context) =>
              const Post(), // Ensure Post widget is imported and defined
        );

      case Routsname.login:
        return MaterialPageRoute(
          builder: (context) =>
              const LoginView(), // Ensure LoginView is imported and defined
        );

      case Routsname.signup:
        return MaterialPageRoute(
          builder: (context) =>
              const SignupView(), // Ensure SignupView is imported and defined
        );
      case Routsname.splash:
        return MaterialPageRoute(
          builder: (context) =>
              const SplashView(), // Ensure SignupView is imported and defined
        );
      case Routsname.addpost:
        return MaterialPageRoute(
          builder: (context) =>
              const AddPost(), // Ensure SignupView is imported and defined
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const SplashView(),
        );
    }
  }
}
