import 'package:flutter/material.dart';
import 'package:safra/ui/authentication.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/Home_Page_image.jpg'),
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
                SizedBox(height: 500),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const authentication()));
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 2, 95, 172),
                        textStyle: const TextStyle(fontSize: 20),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 173, vertical: 9)),
                    child: const Text("Login")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const authentication()));
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.grey,
                        textStyle: const TextStyle(fontSize: 20),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 130, vertical: 9)),
                    child: const Text("Create Account")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
