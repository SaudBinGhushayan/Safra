import 'package:flutter/material.dart';
<<<<<<< Updated upstream
=======
import 'package:safra/ui/CreateAccount.dart';
>>>>>>> Stashed changes
import 'package:safra/ui/authentication.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
<<<<<<< Updated upstream
=======
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.width;
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
                SizedBox(height: 500),
=======
                SizedBox(height: height + 10),
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
                        padding: const EdgeInsets.symmetric(
                            horizontal: 173, vertical: 9)),
=======
                        padding: EdgeInsets.symmetric(
                            horizontal: width - 240, vertical: 9)),
>>>>>>> Stashed changes
                    child: const Text("Login")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
<<<<<<< Updated upstream
                              builder: (context) => const authentication()));
=======
                              builder: (context) => const CreateAccount()));
>>>>>>> Stashed changes
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.grey,
                        textStyle: const TextStyle(fontSize: 20),
<<<<<<< Updated upstream
                        padding: const EdgeInsets.symmetric(
                            horizontal: 130, vertical: 9)),
=======
                        padding: EdgeInsets.symmetric(
                            horizontal: width - 284, vertical: 9)),
>>>>>>> Stashed changes
                    child: const Text("Create Account")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
