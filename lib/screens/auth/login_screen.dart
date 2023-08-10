import 'dart:io';
import 'package:chatapp/helper/dialogs.dart';
import 'package:chatapp/screens/home_screen.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../api/api.dart';

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

  Future<bool> isConnected() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      await InternetAddress.lookup('google.com');
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await APIs.auth.signInWithCredential(credential);
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text("Welcome")),
      ),
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: Duration(seconds: 2),
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
              onPressed: () async {
                bool iSConnected = await isConnected();
                if (iSConnected) {
                  Dialogs.showProgressBar(context);
                  signInWithGoogle().then((user) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => HomeScreen())));
                  });
                } else {
                  Dialogs.showSnackBar(context, "Check Internet Connection !");
                }
              },
              icon: Image.asset(
                'images/google.png',
                height: 20,
                width: 40,
              ),
              label: RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.blue.shade700, fontSize: 17),
                  children: [
                    TextSpan(text: " Login with "),
                    TextSpan(
                        text: "Google",
                        style: TextStyle(fontWeight: FontWeight.bold))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
