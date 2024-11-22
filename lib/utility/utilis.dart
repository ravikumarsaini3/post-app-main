import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utilis {
  static void showToast({
    required String message,
    toastLength = Toast.LENGTH_SHORT,
    gravity = ToastGravity.BOTTOM,
    backgroundColor = Colors.black,
    textColor = Colors.white,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: toastLength, // or Toast.LENGTH_LONG
      gravity: gravity,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: 16.0,
    );
  }
}
