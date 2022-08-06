import 'package:flutter/material.dart';

class authentication extends StatefulWidget {
  const authentication({super.key});

  @override
  State<authentication> createState() => authenticationState();
}

class authenticationState extends State<authentication> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextFormField(
            controller: email,
            decoration: InputDecoration(
                hintText: 'example@email.com',
                hintStyle: TextStyle(color: Colors.white),
                labelText: "Email",
                labelStyle: TextStyle(color: Colors.white)),
          ),
          TextFormField(
              controller: password,
              obscureText: true,
              decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Colors.white),
                  labelText: "Password",
                  labelStyle: TextStyle(color: Colors.white))),
          Container(
              width: MediaQuery.of(context).size.width / 1.4,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white,
              ),
              child: MaterialButton(onPressed: () {}, child: Text('Register'))),
          Container(
              width: MediaQuery.of(context).size.width / 1.4,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white,
              ),
              child: MaterialButton(onPressed: () {}, child: Text('Login'))),
        ],
      ),
    ));
  }
}
