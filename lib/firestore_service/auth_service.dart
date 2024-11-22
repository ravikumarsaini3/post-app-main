import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  Future<dynamic> signupapi(String email, String password) async {
    try {
      final auth = FirebaseAuth.instance;
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return '$email and $password';
    } on FirebaseAuthException catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<dynamic> loginapi(String email, String password) async {
    try {
      final auth = FirebaseAuth.instance;
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return '$email and $password';
    } on FirebaseAuthException catch (e) {
      print(e);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
