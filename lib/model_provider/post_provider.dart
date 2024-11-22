import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:post_app/firestore_service/post_service.dart';
import 'package:post_app/utility/utilis.dart';

class PostProvider with ChangeNotifier {
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

  File? _image;
  File? get image => _image;
  Uint8List? _imagew;
  Uint8List? get imagew => _imagew;
  final ImagePicker _pick = ImagePicker();

  Future<void> pickimage() async {
    try {
      final XFile? pickedimg =
          await _pick.pickImage(source: ImageSource.gallery);
      if (pickedimg != null) {
        if (kIsWeb) {
          _imagew = await pickedimg.readAsBytes();
        } else {
          _image = File(pickedimg.path);
        }

        notifyListeners();
        Utilis.showToast(message: 'picked img');
      } else {
        Utilis.showToast(message: 'No image selected');
      }
    } catch (e) {
      Utilis.showToast(message: e.toString());
    }
  }

  Future<String> uploadimage() async {
    try {
      String pathname = DateTime.now().microsecondsSinceEpoch.toString();
      FirebaseStorage storage = FirebaseStorage.instance;
      UploadTask uploadTask;

      if (image != null) {
        Reference ref = storage.ref().child(pathname);
        uploadTask = ref.putFile(image!);
        Utilis.showToast(message: 'Uploading image...');
      } else if (imagew != null) {
        Reference ref = storage.ref().child(pathname);
        uploadTask = ref.putData(imagew!);
        Utilis.showToast(message: 'Uploading image...');
      } else {
        throw Exception('No image to upload');
      }

      final TaskSnapshot taskSnapshot = await uploadTask;
      final String downloadurl = await taskSnapshot.ref.getDownloadURL();
      return downloadurl;
    } catch (e) {
      Utilis.showToast(message: 'Error uploading image: $e');
      return 'error';
    }
  }

  final PostService _postService = PostService();

  Future<dynamic> addpost(String email, String password, context) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        Utilis.showToast(message: 'User not authenticated');
        return;
      }

      setloading(true);
      String url = await uploadimage();

      _postService
          .addpost(
        email,
        password,
        url,
      )
          .then(
        (value) {
          Utilis.showToast(message: 'Post added successfully');
          Navigator.pop(context);
          notifyListeners();
          setloading(false);
        },
      ).onError(
        (error, stackTrace) {
          setloading(false);
          Utilis.showToast(message: 'Error adding post: $error');
        },
      );
    } catch (e) {
      setloading(false);
      Utilis.showToast(message: 'Error: $e');
    }
  }

  Future<dynamic> delete(String id) async {
    try {
      final ref =
          FirebaseFirestore.instance.collection('posts').doc(id).delete();
      Utilis.showToast(message: 'deleted');
    } catch (e) {
      Utilis.showToast(message: e.toString());
    }
  }

  Future<dynamic> update(String id, String email, String password) async {
    try {
      final ref = FirebaseFirestore.instance
          .collection('posts')
          .doc(id)
          .update({'email': email, 'password': password});
      Utilis.showToast(message: 'updated');
    } catch (e) {
      Utilis.showToast(message: e.toString());
    }
  }
}
