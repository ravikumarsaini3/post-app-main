import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:post_app/model_provider/post_provider.dart';
import 'package:post_app/resourses/components/customelevatedbutton.dart';
import 'package:provider/provider.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone';
    }
    return null;
  }

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height * 1;

    return Scaffold(
      // backgroundColor: Colors.black,

      body: Consumer<PostProvider>(
        builder: (context, value, child) {
          return Stack(
            children: [
              Image.asset(
                'lib/resourses/assets/images/bbb.jpg', // Update the image path
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                color: Colors.black54,
                opacity: const AlwaysStoppedAnimation(0.7),
                colorBlendMode: BlendMode.darken,
              ),
              SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.04,
                        ),
                        Stack(
                          children: [
                            CircleAvatar(
                                radius: 80,
                                backgroundImage: (!kIsWeb &&
                                        value.image != null)
                                    ? FileImage(value.image!)
                                    : (kIsWeb && value.imagew != null)
                                        ? MemoryImage(value.imagew!)
                                        // ignore: prefer_const_constructors
                                        : AssetImage(
                                            'lib/resourses/assets/images/a.jpg')),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: IconButton(
                                onPressed: () {
                                  value.pickimage();
                                },
                                icon: const Icon(
                                  Icons.add_a_photo,
                                  size: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        TextFormField(
                          controller: emailController,
                          focusNode: emailFocusNode,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'name',
                            hintText: 'enter your name',
                            prefixIcon: Icon(Icons.account_circle),
                          ),
                          validator: nameValidator,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context)
                                .requestFocus(passwordFocusNode);
                          },
                        ),
                        const SizedBox(height: 10),
                        // Password Field
                        TextFormField(
                          controller: passwordController,
                          focusNode: passwordFocusNode,
                          obscureText: value.obsecure,
                          decoration: InputDecoration(
                            labelText: 'phone',
                            hintText: 'enter phone number',
                            prefixIcon: const Icon(Icons.phone),
                            suffixIcon: InkWell(
                                onTap: () {
                                  value.setobsecure();
                                },
                                child: Icon(value.obsecure
                                    ? Icons.visibility
                                    : Icons.visibility_off)),
                          ),
                          validator: emailValidator,
                          onFieldSubmitted: (value) {
                            passwordFocusNode.unfocus();
                          },
                        ),
                        SizedBox(
                          height: height * 0.08,
                        ),
                        Customelevatedbutton(
                            loading: value.loading,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                value.addpost(emailController.text,
                                    passwordController.text, context);
                              }
                            },
                            title: 'Add')
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
