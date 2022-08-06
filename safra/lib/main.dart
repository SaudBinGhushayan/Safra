import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:safra/ui/homePage.dart';

import 'backend/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(Safra());
}

class Safra extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Safra",
      home: homePage(),
    );
  }
}
