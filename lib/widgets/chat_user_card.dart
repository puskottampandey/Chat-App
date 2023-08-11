import 'package:flutter/material.dart';

import '../models/chat_user.dart';

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
        onTap: () {},
        child: ListTile(
          leading: CircleAvatar(
            child: Image.network(
              widget.user.image.toString(),
              fit: BoxFit.cover,
            ),
          ),
          title: Text(widget.user.name.toString()),
          subtitle: Text(
            widget.user.about.toString(),
            maxLines: 1,
          ),
          trailing: Text(
            "12:00 PM",
            style: TextStyle(color: Colors.black54),
          ),
        ),
      ),
    );
  }
}
