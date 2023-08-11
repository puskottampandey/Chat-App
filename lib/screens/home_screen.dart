import 'package:chatapp/widgets/chat_user_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../api/api.dart';
import 'auth/login_screen.dart';
import 'package:chatapp/models/chat_user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ChatUser> list = [];
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
                await APIs.auth.signOut;
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: APIs.firestore.collection('Users').snapshots(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data?.docs;
              list =
                  data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];
            } else
              Center(child: CircularProgressIndicator());
            if (list.isNotEmpty) {
              return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return ChatUserCard(
                      user: list[index],
                    );
                  });
            } else {
              return Center(
                  child: Text(
                "NO Connection Found !",
                style: TextStyle(fontSize: 20),
              ));
            }
          }),
        ),
      ),
    );
  }
}
