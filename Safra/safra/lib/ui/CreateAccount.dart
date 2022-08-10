import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safra/backend/flutterfire.dart';
import 'package:safra/ui/authentication.dart';

import '../main.dart';
import '../objects/user.dart';
import 'dashboard.dart';
import 'homePage.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final name = TextEditingController();
  final password = TextEditingController();
  final ConfirmPassword = TextEditingController();
  final email = TextEditingController();
  final phoneNumber = TextEditingController();

  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 15),
              Container(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const homePage()));
                      })),
              SizedBox(height: MediaQuery.of(context).size.height / 200),
              const Text(
                'Create Account',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Verdana'),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 150),
              const Text(
                '''              Create your new account to join 
     with millions of unforgettable experiences''',
                style: TextStyle(
                    color: Colors.grey, fontSize: 18, fontFamily: 'Verdana'),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 100),
              TextFormField(
                controller: name,
                decoration: const InputDecoration(
                    hintText: 'Enter your name',
                    hintStyle: TextStyle(color: Colors.grey),
                    labelText: "Name",
                    labelStyle: TextStyle(color: Colors.grey)),
              ),
              TextFormField(
                  controller: email,
                  decoration: const InputDecoration(
                      hintText: 'example@email.com',
                      hintStyle: TextStyle(color: Colors.grey),
                      labelText: "Email",
                      labelStyle: TextStyle(color: Colors.grey))),
              TextFormField(
                  controller: password,
                  obscureText: true,
                  decoration: const InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.grey),
                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.grey))),
              TextFormField(
                  controller: ConfirmPassword,
                  obscureText: true,
                  decoration: const InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.grey),
                      labelText: "Confirm Password",
                      labelStyle: TextStyle(color: Colors.grey))),
              TextFormField(
                  controller: phoneNumber,
                  decoration: const InputDecoration(
                      hintText: 'use your country key e.g. +966',
                      hintStyle: TextStyle(color: Colors.grey),
                      labelText: "PhoneNumber",
                      labelStyle: TextStyle(color: Colors.grey))),
              SizedBox(height: MediaQuery.of(context).size.height / 90),
              ElevatedButton(
                  onPressed: signUp,
                  style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(232, 9, 114, 199),
                      textStyle: const TextStyle(fontSize: 20),
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width - 250,
                          vertical: 9)),
                  child: const Text("Register")),
              Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    const Text(
                      "Already have an account ?",
                      style: TextStyle(color: Colors.grey),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const authentication()));
                        },
                        child: const Text(
                          'Sign in',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ))
                  ])),
            ],
          ),
        ),
      ),
    );
  }

  Future signUp() async {
    //to show the loading screen
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );
    try {
      // signing in authentication
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
    createUser(
        uid: Random().nextInt(100),
        name: name.text,
        phoneNumber: phoneNumber.text,
        email: email.text);

    //to remove the loading screen
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
