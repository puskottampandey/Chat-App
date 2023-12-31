import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/helper/dialogs.dart';
import 'package:flutter/material.dart';

import 'package:chatapp/models/chat_user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

import '../api/api.dart';
import 'auth/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  final ChatUser user;
  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final formKey = GlobalKey<FormState>();
  String? _image;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      // for hiding
      // keyword
      child: Scaffold(
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
              // for showing progress dialog
              Dialogs.showProgressBar(context);
              //for sign out app
              await APIs.auth.signOut().then((value) async {
                await GoogleSignIn().signOut().then((value) => {
                      //for moving to home screen
                      Navigator.pop(context),
                      //for replacing the home screen with login screen
                      Navigator.pop(context),
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => LoginScreen())))
                    });
              });
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
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Stack(
                      children: [
                        // profile picture
                        _image != null
                            ?
                            //local image
                            ClipRRect(
                                child: Image.file(
                                  File(_image!),
                                  width: 150,
                                  height: 140,
                                  fit: BoxFit.fill,
                                ),
                              )
                            :
                            // image from server
                            ClipRRect(
                                child: CachedNetworkImage(
                                  width: 150,
                                  height: 140,
                                  imageUrl: widget.user.image.toString(),
                                  placeholder: (context, url) => Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      CircleAvatar(
                                    child: Icon(Icons.person),
                                  ),
                                ),
                              ),

                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: MaterialButton(
                            elevation: 1,
                            onPressed: () {
                              showModalBottomSheet(
                                  context: (context),
                                  builder: (context) {
                                    return Container(
                                      child: ListView(
                                        padding: EdgeInsets.only(
                                            top: 20, bottom: 10),
                                        shrinkWrap: true,
                                        children: [
                                          Center(
                                              child: Text(
                                            "Pick Profile Picture",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          )),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              InkWell(
                                                onTap: () async {
                                                  final ImagePicker picker =
                                                      ImagePicker();
                                                  final XFile? image =
                                                      await picker.pickImage(
                                                          source: ImageSource
                                                              .gallery,
                                                          imageQuality: 80);
                                                  if (image != null) {
                                                    image.path;
                                                    image.mimeType;
                                                    setState(() {
                                                      _image = image.path;
                                                    });
                                                    //  for updating the profile in  the firebase
                                                    APIs.updateProfilePicture(
                                                        File(_image!));
                                                    //hiding the bottom sheet
                                                    Navigator.pop(context);
                                                  }
                                                },
                                                child: Image.asset(
                                                  'images/picture.png',
                                                  height: 140,
                                                  width: 100,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  final ImagePicker picker =
                                                      ImagePicker();
                                                  final XFile? image =
                                                      await picker.pickImage(
                                                          source: ImageSource
                                                              .camera);
                                                  if (image != null) {
                                                    image.path;
                                                    setState(() {
                                                      _image = image.path;
                                                      APIs.updateProfilePicture(
                                                          File(_image!));
                                                      Navigator.pop(context);
                                                    });
                                                  }
                                                },
                                                child: Image.asset(
                                                  'images/camera.png',
                                                  height: 150,
                                                  width: 100,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                            },
                            shape: CircleBorder(),
                            color: Colors.white,
                            child: Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                          ),
                        )
                      ],
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
                      onSaved: (val) => APIs.me.name = val ?? '',
                      validator: (val) =>
                          val != null && val.isNotEmpty ? null : "Required",
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
                      onSaved: (val) => APIs.me.about = val ?? '',
                      validator: (val) =>
                          val != null && val.isNotEmpty ? null : 'Required',
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
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          APIs.updateUserInfo();
                          Dialogs.showSnackBar(
                              context, "Profile Updated Successfully");
                        }
                      },
                      icon: Icon(Icons.edit),
                      label: Text("Update"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
