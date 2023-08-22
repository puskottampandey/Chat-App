import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/models/chat_user.dart';
import 'package:chatapp/widgets/message_card.dart';
import 'package:flutter/material.dart';

import '../api/api.dart';
import '../models/messages.dart';

class ChatScreen extends StatefulWidget {
  final ChatUser user;
  const ChatScreen({super.key, required this.user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Messages> _list = [];
  // custom appbar
  Widget _appbar() {
    return SafeArea(
      child: InkWell(
        onTap: () {},
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
              color: Colors.black,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: CachedNetworkImage(
                width: 50,
                imageUrl: widget.user.image.toString(),
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => CircleAvatar(
                  child: Icon(Icons.person),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.user.name.toString(),
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 1,
                ),
                Text("last seen not available")
              ],
            )
          ],
        ),
      ),
    );
  }

// chat input widget
  Widget _chatinput() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.emoji_emotions,
                      color: Colors.blue.shade700,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                          hintText: 'Type Something...',
                          hintStyle: TextStyle(color: Colors.blue.shade700),
                          border: InputBorder.none),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.image,
                      color: Colors.blue.shade700,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.camera_alt_rounded,
                      color: Colors.blue.shade700,
                    ),
                  )
                ],
              ),
            ),
          ),
          // sent button
          MaterialButton(
              onPressed: () {},
              minWidth: 0,
              padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 5),
              shape: CircleBorder(),
              color: Colors.blue.shade700,
              child: Icon(
                Icons.send,
                color: Colors.white,
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: _appbar(),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: APIs.getAllMessages(),
              builder: ((context, snapshot) {
                final data = snapshot.data?.docs;
                // list =
                //  data?.map((e) => ChatUser.fromJson(e.data())).toList() ??
                //   [];
                //  } else
                Center(child: CircularProgressIndicator());
                _list.clear();
                _list.add(
                  Messages(
                      told: 'xyz',
                      msg: 'hiii',
                      read: "",
                      type: Type.text,
                      fromId: APIs.user.uid,
                      sent: "12:00Pm"),
                );
                _list.add(
                  Messages(
                      told: APIs.user.uid,
                      msg: 'helloo',
                      read: "",
                      type: Type.text,
                      fromId: "xyz",
                      sent: "12:00AM"),
                );

                if (_list.isNotEmpty) {
                  return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: _list.length,
                      itemBuilder: (context, index) {
                        return MessageCard(messages: _list[index]);

                        // ChatUserCard(
                        //    user: isSearching ? _searchlist[index] : list[index],
                      });
                } else {
                  return Center(
                      child: Text(
                    "Say Hi! 👋",
                    style: TextStyle(fontSize: 20),
                  ));
                }
              }),
            ),
          ),
          _chatinput(),
        ],
      ),
    );
  }
}
