import 'package:flutter/material.dart';

class customtextbutton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  const customtextbutton(
      {super.key, required this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white70,
          ),
        ),
      ),
    );
  }
}
