import 'package:flutter/material.dart';
import 'package:post_app/model_provider/auth_provider.dart';
import 'package:post_app/model_provider/post_provider.dart';
import 'package:post_app/utility/routs/routs.dart';
import 'package:post_app/utility/routs/routsname.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PostProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          brightness: Brightness.dark,
          useMaterial3: true,
        ),
        initialRoute: Routsname.splash, // Ensure this is correct
        onGenerateRoute: Routs.generateRoute, // Ensure this is correct
      ),
    );
  }
}
