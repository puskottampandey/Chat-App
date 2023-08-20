import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dialogs {
  static void showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        backgroundColor: Colors.blue.shade700,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 1),
      ),
    );
  }

  static void showProgressBar(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) => Center(
        child: CircularProgressIndicator(
          color: Colors.blue.shade700,
        ),
      ),
    );
  }

  static void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: (context),
        builder: (context) {
          return Container(
            child: ListView(
              padding: EdgeInsets.only(top: 20, bottom: 10),
              shrinkWrap: true,
              children: [
                Center(
                    child: Text(
                  "Pick Profile Picture",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Image.asset(
                        'images/picture.png',
                        height: 140,
                        width: 100,
                      ),
                    ),
                    InkWell(
                      onTap: () {},
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
  }
}
