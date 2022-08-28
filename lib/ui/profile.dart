import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safra/models/authError.dart';
import 'package:safra/ui/schedule1.dart';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (image == null) return;

      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      authError.showSnackBar('Failed to pick image$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Column(children: [
      SizedBox(height: 30),
      Container(
          alignment: Alignment.topLeft,
          child: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const schedule1()));
              })),
      SizedBox(height: 20),
      image != null
          ? Image.file(image!, width: 160, height: 160, fit: BoxFit.cover)
          : Icon(
              Icons.person,
              size: 160,
            ),
      SizedBox(height: 200),
      buildButton(
          title: 'Pick Photo', icon: Icons.image_outlined, callBack: pickImage)
    ])));
  }

  Widget buildButton(
          {required String title,
          required IconData icon,
          required VoidCallback callBack}) =>
      ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: Size.fromHeight(56),
            primary: Colors.white,
            onPrimary: Colors.black,
            textStyle: TextStyle(fontSize: 20)),
        child: Row(
          children: [
            Icon(icon, size: 28),
            const SizedBox(width: 16),
            Text(title)
          ],
        ),
        onPressed: callBack,
      );
}
