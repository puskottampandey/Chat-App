import 'package:chatapp/screens/profile_screen.dart';
import 'package:chatapp/widgets/chat_user_card.dart';
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
  void initState() {
    super.initState();
    APIs.getSelfInfo();
  }

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
          // search user button
          IconButton(onPressed: () {}, icon: Icon(Icons.search_rounded)),
          // more feautures button
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => ProfileScreen(
                              user: APIs.me,
                            ))));
              },
              icon: Icon(Icons.more_vert)),
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
          stream: APIs.getAllUser(),
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
