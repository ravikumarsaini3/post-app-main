import 'package:flutter/material.dart';
import 'package:post_app/firestore_service/splash_service.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final SplashService _splash = SplashService();
  @override
  void initState() {
    // TODO: implement initState
    _splash.checklogin(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FlutterLogo(
              size: 69,
            ),
            const SizedBox(
              height: 30,
            ),
            RichText(
              text: const TextSpan(children: [
                TextSpan(
                    text: 'Welcome \n',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                    )),
                TextSpan(
                    text: '     to the     ',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                TextSpan(
                    text: 'Post App \n',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ))
              ]),
            )
          ],
        ),
      ),
    );
  }
}
