import 'package:flutter/material.dart';
import 'package:post_app/model_provider/auth_provider.dart';
import 'package:post_app/resourses/components/customelevatedbutton.dart';
import 'package:post_app/resourses/components/customtextbutton.dart';
import 'package:post_app/utility/routs/routsname.dart';
import 'package:provider/provider.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Clean up controllers and focus nodes
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  // Email validation method
  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!RegExp(r'^[\w-]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  // Password validation method
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
    var height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      body: Stack(
        children: [
          const Image(
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            color: Colors.black54,
            opacity: AlwaysStoppedAnimation(0.7),
            colorBlendMode: BlendMode.colorBurn,
            image: AssetImage('lib/resourses/assets/images/y.jpg'),
          ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                    key: _formKey, // Attach form key for validation
                    child: Consumer<AuthProvider>(
                      builder: (context, value, child) {
                        return Column(
                          children: [
                            const Text(
                              'Welcome  ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            const Text(
                              'Create New Account',
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.04,
                            ),
                            // Email TextFormField with validation
                            TextFormField(
                              controller: emailController,
                              focusNode: emailFocusNode,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                hintText: 'Enter email',
                                prefixIcon: const Icon(Icons.email_outlined),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      const BorderSide(color: Colors.green),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                ),
                              ),
                              validator: emailValidator, // Email validation
                              onFieldSubmitted: (value) {
                                FocusScope.of(context)
                                    .requestFocus(passwordFocusNode);
                              },
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            // Password TextFormField with validation
                            TextFormField(
                              controller: passwordController,
                              focusNode: passwordFocusNode,
                              obscureText:
                                  value.obsecure, // Hide password input
                              decoration: InputDecoration(
                                labelText: 'Password',
                                hintText: 'Enter password',
                                prefixIcon: const Icon(Icons.lock_outline),
                                suffixIcon: InkWell(
                                    onTap: () {
                                      value.setobsecure();
                                    },
                                    child: Icon(value.obsecure
                                        ? Icons.visibility
                                        : Icons.visibility_off)),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      const BorderSide(color: Colors.green),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                ),
                              ),
                              validator:
                                  passwordValidator, // Password validation
                              onFieldSubmitted: (value) {
                                passwordFocusNode.unfocus();
                              },
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: customtextbutton(
                                  onPressed: () {}, title: 'Forget password?'),
                            ),
                            SizedBox(
                              height: height * 0.04,
                            ),
                            // SignUp button with validation check
                            Customelevatedbutton(
                                loading: value.loading,
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    value.signup(emailController.text,
                                        passwordController.text, context);
                                  }
                                },
                                title: 'SignUp'),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            // Navigate to login screen
                            customtextbutton(
                                onPressed: () {
                                  Navigator.pushNamed(context, Routsname.login);
                                },
                                title: 'Already have an account? Login')
                          ],
                        );
                      },
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
