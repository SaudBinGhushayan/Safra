import 'package:flutter/material.dart';
<<<<<<< Updated upstream
=======
import 'package:safra/backend/flutterfire.dart';
import 'package:safra/ui/CreateAccount.dart';
import 'package:safra/ui/dashboard.dart';
import 'package:safra/ui/forgetPassword.dart';
import 'package:safra/ui/homePage.dart';
>>>>>>> Stashed changes

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
<<<<<<< Updated upstream
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
=======
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
                onPressed: () async {
                  bool nv = await signIn(email.text, password.text);
                  if (nv) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const dashboard()));
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
>>>>>>> Stashed changes
  }
}
