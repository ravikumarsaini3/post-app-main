import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:post_app/firestore_service/auth_service.dart';
import 'package:post_app/utility/routs/routsname.dart';
import 'package:post_app/utility/utilis.dart';

class AuthProvider with ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  setloading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool _obsecure = false;
  bool get obsecure => _obsecure;
  setobsecure() {
    _obsecure = !_obsecure;
    notifyListeners();
  }

  Future<dynamic> login(String email, String password, context) async {
    AuthService authservice = AuthService();
    try {
      setloading(true);
      await authservice.loginapi(email, password).then(
        (value) {
          Utilis.showToast(message: 'login Successfull');
          Navigator.pushNamed(context, Routsname.home);
          setloading(false);
        },
      ).onError(
        (error, stackTrace) {
          setloading(false);
          Utilis.showToast(message: error.toString());
        },
      );
    } on FirebaseAuthException catch (e) {
      setloading(false);
      Utilis.showToast(message: e.toString());
    } catch (e) {
      setloading(false);
      Utilis.showToast(message: e.toString());
    }
  }

  Future<dynamic> signup(String email, String password, context) async {
    AuthService authservice = AuthService();
    try {
      setloading(true);
      await authservice.signupapi(email, password).then(
        (value) {
          Utilis.showToast(message: 'Signup Successfull');
          Navigator.pushNamed(context, Routsname.home);
          setloading(false);
        },
      ).onError(
        (error, stackTrace) {
          setloading(false);
          Utilis.showToast(message: error.toString());
        },
      );
    } on FirebaseAuthException catch (e) {
      setloading(false);
      Utilis.showToast(message: e.toString());
    } catch (e) {
      setloading(false);
      Utilis.showToast(message: e.toString());
    }
  }
}
