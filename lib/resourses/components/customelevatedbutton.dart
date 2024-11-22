import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Customelevatedbutton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final bool loading;
  const Customelevatedbutton(
      {super.key,
      required this.onPressed,
      required this.title,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 350,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, foregroundColor: Colors.white),
          child: loading
              ? const SpinKitFadingCircle(
                  color: Colors.white, // You can change the color
                  size: 40.0, // Size of the loader
                )
              : Text(
                  title,
                  style: const TextStyle(fontSize: 20),
                )),
    );
  }
}
