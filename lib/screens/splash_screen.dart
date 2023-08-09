import 'package:chatapp/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      Navigator.push(
          context, MaterialPageRoute(builder: ((context) => LoginScreen())));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Positioned(
            top: 110,
            width: 250,
            right: 90,
            child: Image.asset(
              'images/conversation.png',
            ),
          )
        ],
      ),
    );
  }
}
