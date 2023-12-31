import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/chat_user.dart';
import '../screens/chat_screen.dart';

class ChatUserCard extends StatefulWidget {
  final ChatUser user;
  const ChatUserCard({super.key, required this.user});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      elevation: 2,
      color: Colors.white,
      child: InkWell(
        onTap: () {
          // for navigating to chat screen
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => ChatScreen(
                        user: widget.user,
                      ))));
        },
        child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: CachedNetworkImage(
                width: 70,
                imageUrl: widget.user.image.toString(),
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => CircleAvatar(
                  child: Icon(Icons.person),
                ),
              ),
            ),
            title: Text(widget.user.name.toString()),
            subtitle: Text(
              widget.user.about.toString(),
              maxLines: 1,
            ),
            trailing: Container(
              height: 15,
              width: 15,
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(15)),
            )
            /*
           Text(
            "12:00 PM",
            style: TextStyle(color: Colors.black54),
          ),
          */
            ),
      ),
    );
  }
}
