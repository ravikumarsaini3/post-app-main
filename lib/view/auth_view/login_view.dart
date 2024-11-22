import 'package:flutter/material.dart';
import 'package:post_app/model_provider/auth_provider.dart';
import 'package:post_app/resourses/components/customelevatedbutton.dart';
import 'package:post_app/resourses/components/customtextbutton.dart';
import 'package:post_app/utility/routs/routsname.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
      return 'Please enter your email';
    } else if (!RegExp(r'^[\w-]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // Background image
          Image.asset(
            'lib/resourses/assets/images/g.jpeg', // Update the image path
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            color: Colors.black54,
            opacity: const AlwaysStoppedAnimation(0.7),
            colorBlendMode: BlendMode.darken,
          ),
          // Login Form
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                  key: _formKey,
                  child: Consumer<AuthProvider>(
                    builder: (context, value, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Welcome Back!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Login to your account',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 19,
                            ),
                          ),
                          const SizedBox(height: 40),
                          // Email Field
                          TextFormField(
                            controller: emailController,
                            focusNode: emailFocusNode,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              hintText: 'Enter your email',
                              prefixIcon: const Icon(Icons.email),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                  color: Colors.grey, // Color when not focused
                                  width: 2.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                  color: Colors.teal, // Color when focused
                                  width: 2.0,
                                ),
                              ),
                            ),
                            validator: emailValidator,
                            onFieldSubmitted: (value) {
                              FocusScope.of(context)
                                  .requestFocus(passwordFocusNode);
                            },
                          ),
                          const SizedBox(height: 20),
                          // Password Field
                          TextFormField(
                            controller: passwordController,
                            focusNode: passwordFocusNode,
                            obscureText: value.obsecure,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              hintText: 'Enter your password',
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: InkWell(
                                  onTap: () {
                                    value.setobsecure();
                                  },
                                  child: Icon(value.obsecure
                                      ? Icons.visibility
                                      : Icons.visibility_off)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                  color: Colors.grey, // Color when not focused
                                  width: 1.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                  color: Colors.teal, // Color when focused
                                  width: 1.0,
                                ),
                              ),
                            ),
                            validator: passwordValidator,
                            onFieldSubmitted: (value) {
                              passwordFocusNode.unfocus();
                            },
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              child: customtextbutton(
                                  onPressed: () {}, title: 'forget password?'),
                            ),
                          ),
                          const SizedBox(height: 40),
                          // Login Button
                          Customelevatedbutton(
                              loading: value.loading,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  value.login(emailController.text,
                                      passwordController.text, context);
                                }
                              },
                              title: 'Login'),
                          const SizedBox(height: 20),

                          customtextbutton(
                              onPressed: () {
                                Navigator.pushNamed(context, Routsname.signup);
                              },
                              title: 'if you have no account signup')
                        ],
                      );
                    },
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
