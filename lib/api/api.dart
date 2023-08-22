import 'dart:io';

import 'package:chatapp/models/chat_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class APIs {
  // for authentication
  static FirebaseAuth auth = FirebaseAuth.instance;
  // for accessing cloud firestore database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  // for accessing  firebase Storage
  static FirebaseStorage storage = FirebaseStorage.instance;
  // for storing the self information\
  static late ChatUser me;
  //for  return current user
  static User get user => auth.currentUser!;
// for checking if user exists or not?
  static Future<bool> userExists() async {
    return (await firestore.collection('Users').doc(user.uid).get()).exists;
  }

//for getting current user info
  static Future<void> getSelfInfo() async {
    await firestore.collection('Users').doc(user.uid).get().then((user) async {
      if (user.exists) {
        me = ChatUser.fromJson(user.data()!);
      } else {
        await userCreate().then((value) => getSelfInfo());
      }
    });
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

//getting all users from firestore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUser() {
    return firestore
        .collection('Users')
        .where('id', isNotEqualTo: user.uid)
        .snapshots();
  }

  // for updating the user information
  static Future<void> updateUserInfo() async {
    return await firestore.collection('Users').doc(user.uid).update({
      'name': me.name,
      'about': me.about,
    });
  }

// update profile picture of user
  static Future<void> updateProfilePicture(File file) async {
    // getting image file extension
    final ext = file.path.split('.').last;

    // storage file ref with path
    final ref = storage.ref().child('profile.picture/${user.uid}.$ext');

    // uploading image
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      p0.bytesTransferred / 1000;
    });

    //updating image in firestore database
    me.image = await ref.getDownloadURL();
    await firestore.collection('Users').doc(user.uid).update({
      'image': me.image,
    });
  }

// getting all messages of a specfic conversion from firesotore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages() {
    return firestore
        .collection('messages')
        .where('id', isNotEqualTo: user.uid)
        .snapshots();
  }
}
