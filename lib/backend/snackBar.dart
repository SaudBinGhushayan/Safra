import 'package:flutter/material.dart';

class snackBar {
  static final globalKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackBarRed(String? text) {
    if (text == null) return;

    final snackBar = SnackBar(content: Text(text), backgroundColor: Colors.red);

    globalKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
  static showSnackBarGreen(String? text) {
    if (text == null) return;

    final snackBar = SnackBar(content: Text(text), backgroundColor: Colors.green);

    globalKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
