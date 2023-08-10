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
}
