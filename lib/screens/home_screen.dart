import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'auth/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Kurakani",
          style: TextStyle(color: Colors.blue.shade700),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search_rounded)),
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut;
                await GoogleSignIn().signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => LoginScreen())));
              },
              icon: Icon(Icons.logout_rounded))
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () {},
          child: Icon(
            Icons.people_rounded,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
