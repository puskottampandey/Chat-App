import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:chatapp/models/chat_user.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../api/api.dart';
import 'auth/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  final ChatUser user;
  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.blue.shade700),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: FloatingActionButton.extended(
          backgroundColor: Colors.red,
          onPressed: () async {
            await APIs.auth.signOut;
            await GoogleSignIn().signOut();
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => LoginScreen())));
          },
          icon: Icon(
            Icons.logout_outlined,
            color: Colors.white,
          ),
          label: Text(
            "Logout",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: CachedNetworkImage(
                  width: 120,
                  height: 120,
                  imageUrl: widget.user.image.toString(),
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              widget.user.email.toString(),
              style: TextStyle(color: Colors.blue.shade700),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: widget.user.name,
                decoration: InputDecoration(
                    label: Text("Name"),
                    hintText: "eg.Puskottam Pandey",
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: widget.user.about,
                decoration: InputDecoration(
                    label: Text("About"),
                    hintText: "eg.feeling happy",
                    prefixIcon: Icon(Icons.info_outline),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(), minimumSize: Size(50, 40)),
                onPressed: () {},
                icon: Icon(Icons.edit),
                label: Text("Update"))
          ],
        ),
      ),
    );
  }
}
