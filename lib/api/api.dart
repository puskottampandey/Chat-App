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
      image: user.photoURL.toString(),
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
