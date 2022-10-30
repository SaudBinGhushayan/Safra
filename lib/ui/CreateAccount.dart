import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safra/backend/snackBar.dart';
import 'package:safra/ui/login.dart';

import '../main.dart';
import '../objects/user.dart';
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
  final username = TextEditingController();
  final validatorKey = GlobalKey<FormState>();

  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  String phoneNumberValidation(String number) {
    if (number == null &&
        number.length < 11 &&
        number.length > 14 &&
        number.characters.first != '+') {
      return "Phone number isn't valid";
    } else
      return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        // width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.height,
        child: Form(
          key: validatorKey,
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (name) => name != null && name.length < 3
                    ? 'Enter 3 characters atleast'
                    : null,
                decoration: const InputDecoration(
                    hintText: 'Enter your name',
                    hintStyle: TextStyle(color: Colors.grey),
                    labelText: "Name",
                    labelStyle: TextStyle(color: Colors.grey)),
              ),
              TextFormField(
                  controller: username,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (username) =>
                      username != null && username.length < 3
                          ? 'Enter 3 characters atleast'
                          : null,
                  decoration: const InputDecoration(
                      hintText: 'Enter your username',
                      hintStyle: TextStyle(color: Colors.grey),
                      labelText: "Username",
                      labelStyle: TextStyle(color: Colors.grey))),
              TextFormField(
                  controller: email,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (email) =>
                      email != null && !EmailValidator.validate(email)
                          ? 'enter a valid email'
                          : null,
                  decoration: const InputDecoration(
                      hintText: 'example@email.com',
                      hintStyle: TextStyle(color: Colors.grey),
                      labelText: "Email",
                      labelStyle: TextStyle(color: Colors.grey))),
              TextFormField(
                  controller: password,
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (password) =>
                      password != null && password.length < 6
                          ? 'Enter 6 characters atleast'
                          : null,
                  decoration: const InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.grey),
                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.grey))),
              TextFormField(
                  controller: ConfirmPassword,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (conPass) =>
                      conPass != password.text ? 'Password unmatched' : null,
                  obscureText: true,
                  decoration: const InputDecoration(
                      hintText: 'Confirm Password',
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
                  onPressed: () async {
                    final valid = await Users.availableUsername(username.text);
                    if (!valid) {
                      snackBar.showSnackBarRed('User already registered');
                    } else {
                      signUp();
                    }
                  },
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
                                  builder: (context) => const login()));
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
    final isValid = validatorKey.currentState!.validate();
    if (!isValid) return;
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
      snackBar.showSnackBarRed(e.message);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const CreateAccount()));
      return;
    }

    final user = FirebaseAuth.instance.currentUser!;
    createUser(
        uid: user.uid,
        name: name.text,
        phoneNumber: phoneNumber.text,
        email: email.text,
        username: username.text);

    //to remove the loading screen
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
