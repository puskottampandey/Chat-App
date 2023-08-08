import 'package:chatapp/screens/home_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isanimated = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _isanimated = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Welcome")),
      ),
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: Duration(seconds: 1),
            top: 110,
            width: 250,
            right: _isanimated ? 90 : 0,
            child: Image.asset(
              'images/conversation.png',
            ),
          ),
          Positioned(
            left: 68,
            bottom: 200,
            width: 300,
            child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => HomeScreen())));
                },
                icon: Image.asset(
                  'images/google.png',
                  height: 20,
                  width: 40,
                ),
                label: RichText(
                    text: TextSpan(
                        style: TextStyle(
                            color: Colors.blue.shade700, fontSize: 17),
                        children: [
                      TextSpan(text: " Login with "),
                      TextSpan(
                          text: "Google",
                          style: TextStyle(fontWeight: FontWeight.bold))
                    ]))),
          ),
        ],
      ),
    );
  }
}
