import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PostService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addpost(String email, String password, String url) async {
    try {
      final User? user = auth.currentUser;

      if (user == null) {
        throw Exception("User not authenticated");
      }

      final String uid = user.uid;
      String documentid = DateTime.now().microsecondsSinceEpoch.toString();
      // Add post to Firestore under a collection (e.g., "posts")
      firestore.collection('posts').doc(documentid).set({
        'uid': uid,
        'email': email,
        'password': password,
        'url': url,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error adding post to Firestore: $e');
      rethrow;
    }
  }
}
