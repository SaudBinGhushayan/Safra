import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:safra/models/authError.dart';
import 'package:safra/ui/dashboard.dart';
import 'package:safra/ui/homePage.dart';
import 'backend/firebase_options.dart';
import 'objects/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(Safra());
}

final navigatorKey = GlobalKey<NavigatorState>();

class Safra extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: authError.globalKey,
      navigatorKey: navigatorKey,
      title: 'Safra',
      home: mainPage(),
    );
  }
}

class mainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
          body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          } else if (snapshot.hasData) {
            return const dashboard();
          } else {
            return const homePage();
          }
        },
      ));
}
