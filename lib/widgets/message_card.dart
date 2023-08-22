import 'package:chatapp/api/api.dart';
import 'package:flutter/material.dart';

import '../models/messages.dart';

class MessageCard extends StatefulWidget {
  const MessageCard({super.key, required this.messages});
  final Messages messages;

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    return APIs.user.uid == widget.messages.fromId
        ? greenMessages()
        : blueMessages();
  }

  // sender or another user messages
  Widget blueMessages() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //message content
        Flexible(
          child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.sizeOf(context).width * .04,
                vertical: MediaQuery.sizeOf(context).width * 0.01),
            padding: EdgeInsets.all(MediaQuery.sizeOf(context).width * .04),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 221, 245, 255),
              border: Border.all(color: Colors.blue.shade700),
              // making borders curved
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
            ),
            child: Text(
              widget.messages.msg!,
              style: TextStyle(fontSize: 15, color: Colors.black87),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 7),
          child: Text(
            widget.messages.sent!,
          ),
        ),
      ],
    );
  }

  //our messaages
  Widget greenMessages() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      //message content

      Padding(
        padding: const EdgeInsets.only(left: 9),
        child: Text(
          widget.messages.sent!,
        ),
      ),
      Flexible(
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.sizeOf(context).width * .04,
              vertical: MediaQuery.sizeOf(context).width * 0.01),
          padding: EdgeInsets.all(MediaQuery.sizeOf(context).width * .04),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 218, 255, 176),
            border: Border.all(color: Colors.green.shade700),
            // making borders curved
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30)),
          ),
          child: Text(
            widget.messages.msg!,
            style: TextStyle(fontSize: 15, color: Colors.black87),
          ),
        ),
      ),
    ]);
  }
}
