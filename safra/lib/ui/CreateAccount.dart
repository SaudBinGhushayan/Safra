import 'package:flutter/material.dart';
import 'package:safra/backend/flutterfire.dart';
import 'package:safra/ui/authentication.dart';

import 'dashboard.dart';
import 'homePage.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController ConfirmPassword = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController PhoneNumber = TextEditingController();
  TextEditingController dob = TextEditingController();

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
                  obscureText: true,
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
                  controller: password,
                  obscureText: true,
                  decoration: const InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.grey),
                      labelText: "Confirm Password",
                      labelStyle: TextStyle(color: Colors.grey))),
              TextFormField(
                  controller: PhoneNumber,
                  obscureText: true,
                  decoration: const InputDecoration(
                      hintText: 'use your country key e.g. +966',
                      hintStyle: TextStyle(color: Colors.grey),
                      labelText: "PhoneNumber",
                      labelStyle: TextStyle(color: Colors.grey))),
              TextFormField(
                  controller: dob,
                  obscureText: true,
                  decoration: const InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.grey),
                      labelText: "Confirm Password",
                      labelStyle: TextStyle(color: Colors.grey))),
              SizedBox(height: MediaQuery.of(context).size.height / 90),
              ElevatedButton(
                  onPressed: () async {
                    bool rnv = await register(email.text, password.text);
                    if (rnv) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const authentication()));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(232, 9, 114, 199),
                      textStyle: const TextStyle(fontSize: 20),
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width - 250,
                          vertical: 9)),
                  child: const Text("Sign in")),
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
                  ]))
            ],
          ),
        ),
      ),
    );
  }
}
