import 'package:chatapp/models/chat_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class APIs {
  // for authentication
  static FirebaseAuth auth = FirebaseAuth.instance;
  // for accessing cloud firestore database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static User get user => auth.currentUser!;
// for checking if user exists or not?
  static Future<bool> userExists() async {
    return (await firestore.collection('Users').doc(user.uid).get()).exists;
  }

  //for creating the user
  static Future<void> userCreate() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final Chatuser = ChatUser(
      id: user.uid,
      name: user.displayName.toString(),
      about: "hey i my name is puskottam pandey",
      email: "puskottam@gmail.com",
      image:
          "https://imgs.search.brave.com/w_9euVJ_7WSUD9opXg8rB8JcdYopdzf8v862OxpW0fI/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9pbWFn/ZXMudW5zcGxhc2gu/Y29tL3Bob3RvLTE0/OTI2ODEyOTAwODIt/ZTkzMjgzMjk0MWU2/P2l4bGliPXJiLTQu/MC4zJml4aWQ9TTN3/eE1qQTNmREI4TUh4/elpXRnlZMmg4TVRK/OGZIQmxjbk52Ym54/bGJud3dmSHd3Zkh4/OE1BPT0mdz0xMDAw/JnE9ODA.jpeg",
      createdAt: time,
      isOnline: time,
      lastActive: time,
      pushToken: "",
    );
    return await firestore
        .collection('Users')
        .doc(user.uid)
        .set(Chatuser.toJson());
  }
}
