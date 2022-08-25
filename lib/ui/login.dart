import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safra/models/authError.dart';
import 'package:safra/ui/CreateAccount.dart';
import 'package:safra/ui/dashboard.dart';
import 'package:safra/ui/forgetPassword.dart';
import 'package:safra/ui/homePage.dart';

import '../main.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => loginState();
}

class loginState extends State<login> {
  final email = TextEditingController();
  final password = TextEditingController();

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
          child: Column(children: [
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
              'Login',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Verdana'),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 150),
            const Text(
              '''      Welcome back,
  Sign in to continue.''',
              style: TextStyle(
                  color: Colors.grey, fontSize: 18, fontFamily: 'Verdana'),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 100),
            TextFormField(
              controller: email,
              decoration: const InputDecoration(
                hintText: 'example@email.com',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
            TextFormField(
                controller: password,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Colors.grey),
                )),
            Container(
                alignment: Alignment.bottomLeft,
                child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const forgetPassword()));
                    },
                    child: const Text('Forgot Password?',
                        style: TextStyle(fontStyle: FontStyle.italic)))),
            SizedBox(height: MediaQuery.of(context).size.height / 50),
            ElevatedButton(
                onPressed: signIn,
                style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(232, 9, 114, 199),
                    textStyle: const TextStyle(fontSize: 20),
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width - 250,
                        vertical: 9)),
                child: const Text("Sign in")),
            Container(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                "Don't have an account ?",
                style: TextStyle(color: Colors.grey),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CreateAccount()));
                  },
                  child: const Text('Create account'))
            ]))
          ]),
        ),
      ),
    );
  }

  Future signIn() async {
    //to show the loading screen
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );
    try {
      // signing in authentication
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());
    } on FirebaseAuthException catch (e) {
      // print(e);

      authError.showSnackBar(e.message);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const login()));
      return;
    }
    //to remove the loading screen
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
