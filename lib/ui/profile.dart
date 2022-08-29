import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safra/backend/authError.dart';
import 'package:safra/backend/storage.dart';
import 'package:safra/ui/schedule1.dart';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  File? image;
  final user = FirebaseAuth.instance.currentUser!;
  Future pickImage() async {
    try {
      // final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      final image = await FilePicker.platform.pickFiles(
          allowMultiple: false,
          type: FileType.custom,
          allowedExtensions: ['png', 'jpg']);
      if (image == null) return;

      final imgPath = image.files.single.path!;
      final imgName = user.uid.toString();

      Storage.uploadFile(imgPath, imgName).then((value) => print('uploaded'));
      // setState(() {
      //   this.image = File(image.path);
      // });
    } on PlatformException catch (e) {
      authError.showSnackBar('Failed to pick image$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      const SizedBox(height: 30),
      Container(
          alignment: Alignment.topLeft,
          child: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const schedule1()));
              })),
      const SizedBox(height: 20),
      FutureBuilder(
          future: Storage.readImage(user.uid),
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              return Container(
                width: 300,
                height: 300,
                child: Image.network(
                  snapshot.data!.toString(),
                  fit: BoxFit.contain,
                ),
              );
            } else if (!snapshot.hasData) {
              return Icon(
                Icons.person,
                size: 160,
              );
            } else {
              return Center(
                  child: SpinKitCircle(
                size: 140,
                itemBuilder: (context, index) {
                  final colors = [Colors.blue, Colors.cyan];
                  final color = colors[index % colors.length];
                  return DecoratedBox(decoration: BoxDecoration(color: color));
                },
              ));
            }
          }),
      const SizedBox(height: 200),
      buildButton(
          title: 'Pick Photo', icon: Icons.image_outlined, callBack: pickImage),
    ])));
  }

  Widget buildButton(
          {required String title,
          required IconData icon,
          required VoidCallback callBack}) =>
      ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(56),
            primary: Colors.white,
            onPrimary: Colors.black,
            textStyle: const TextStyle(fontSize: 20)),
        onPressed: callBack,
        child: Row(
          children: [
            Icon(icon, size: 28),
            const SizedBox(width: 16),
            Text(title)
          ],
        ),
      );
}
