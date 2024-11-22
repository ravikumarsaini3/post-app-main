import 'package:flutter/material.dart';
import 'package:post_app/model_provider/post_provider.dart';
import 'package:provider/provider.dart';

class Postfunction {
  TextEditingController updatecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  Future<void> updatepost(context, id, title, password) async {
    final post = Provider.of<PostProvider>(context, listen: false);
    updatecontroller.text = title;
    passwordcontroller.text = password;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // Rounded corners
          ),
          backgroundColor:
              Theme.of(context).dialogTheme.backgroundColor, // Adjusts to theme
          title: Row(
            children: [
              Icon(Icons.edit,
                  color:
                      Theme.of(context).primaryColor), // Adapts to theme color
              const SizedBox(width: 8),
              Text('Update Post',
                  style: Theme.of(context).dialogTheme.titleTextStyle),
            ],
          ),
          content: SizedBox(
            height: 130,
            child: Column(
              children: [
                TextField(
                  controller: updatecontroller,
                  decoration: const InputDecoration(
                    labelText: 'name',
                    labelStyle: TextStyle(),
                    prefixIcon: Icon(
                      Icons.account_circle,
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: passwordcontroller,
                  decoration: const InputDecoration(
                    labelText: 'phone',
                    prefixIcon: Icon(
                      Icons.phone,
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton.icon(
              onPressed: () {
                post.update(id, updatecontroller.text, passwordcontroller.text);
                Navigator.pop(context);
              },
              icon: const Icon(Icons.check, color: Colors.green),
              label:
                  const Text('Update', style: TextStyle(color: Colors.green)),
            ),
            TextButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.cancel, color: Colors.red),
              label: const Text('Cancel', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
