// ignore_for_file: deprecated_member_use, use_build_context_synchronously, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safra/models/authError.dart';
import 'package:safra/ui/login.dart';

import '../models/Dialogs.dart';

class forgetPassword extends StatefulWidget {
  const forgetPassword({super.key});

  @override
  State<forgetPassword> createState() => _forgetPasswordState();
}

class _forgetPasswordState extends State<forgetPassword> {
  Dialogs dialog = new Dialogs();
  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 15),
              Container(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const login()));
                      })),
              SizedBox(height: MediaQuery.of(context).size.height / 15),
              const Text(
                'Forgot password ?',
                style: TextStyle(
                    fontFamily: 'Verdana',
                    fontSize: 28,
                    fontWeight: FontWeight.w500),
              ),
              const Text(
                '''Please insert your email to send 
                a new password.''',
                style: TextStyle(
                  fontFamily: 'Verdana',
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 20),
              TextFormField(
                controller: email,
                decoration: const InputDecoration(
                  hintText: 'example@email.com',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 20),
              ElevatedButton(
                onPressed: verifyEmail,
                child: Text('Continue'),
                style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(232, 9, 114, 199),
                    textStyle: const TextStyle(fontSize: 20),
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 2.8,
                        vertical: 9)),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future verifyEmail() async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()),
      );
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
      dialog.informatino(context, "Succeded !",
          "Your new password has been sent to your email.");
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      print(e);

      authError.showSnackBar(e.message);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const forgetPassword()));
      return;
    }
  }
}
