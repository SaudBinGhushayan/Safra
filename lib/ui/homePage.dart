import 'package:flutter/material.dart';
import 'package:safra/ui/CreateAccount.dart';
import 'package:safra/ui/login.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image:
                      AssetImage('images/BackgroundPics/Home_Page_image.jpg'),
                  fit: BoxFit.cover)),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Safra',
                  style: TextStyle(
                      fontFamily: 'Cursive',
                      fontSize: 40,
                      color: Color.fromARGB(255, 95, 94, 94),
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const Text(
                  'سفره',
                  style: TextStyle(
                      fontFamily: 'Cursive',
                      fontSize: 40,
                      color: Color.fromARGB(255, 95, 94, 94),
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: height + 10),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const login()));
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 2, 95, 172),
                        textStyle: const TextStyle(fontSize: 20),
                        padding: EdgeInsets.symmetric(
                            horizontal: width - 240, vertical: 9)),
                    child: const Text("Login")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CreateAccount()));
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.grey,
                        textStyle: const TextStyle(fontSize: 20),
                        padding: EdgeInsets.symmetric(
                            horizontal: width - 284, vertical: 9)),
                    child: const Text("Create Account")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
