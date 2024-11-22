import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:post_app/utility/routs/routsname.dart';

class SplashService {
  void checklogin(context) {
    final auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    if (user == null) {
      Timer(
        const Duration(seconds: 2),
        () => Navigator.pushNamed(context, Routsname.login),
      );
    } else {
      Timer(
        const Duration(seconds: 2),
        () => Navigator.pushNamed(context, Routsname.home),
      );
    }
  }
}
