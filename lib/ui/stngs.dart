import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:safra/ui/AccountSettings.dart';
import 'package:safra/ui/dashboardn.dart';

class stngs extends StatefulWidget {
  const stngs({Key? key}) : super(key: key);

  @override
  State<stngs> createState() => _stngsState();
}

class _stngsState extends State<stngs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            //////1st column
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('images/BackgroundPics/AltBackground.jpg'),
              fit: BoxFit.fill,
            )),
            child: Column(
              children: [
                const SizedBox(height: 50),
                Container(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const dashboardn()));
                        })),
                SizedBox(height: 20),
                Text('Settings',
                    style: TextStyle(
                        fontSize: 33,
                        color: const Color.fromARGB(255, 75, 74, 74))),
                const SizedBox(height: 80),
                Row(
                  children: [
                    const Padding(padding: EdgeInsets.only(left: 10)),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.person),
                      iconSize: 33,
                      color: const Color.fromARGB(255, 75, 74, 74),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 10)),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AccountSettings()));
                        },
                        child: const Text('Account Settings',
                            style: TextStyle(
                                color: Color.fromARGB(255, 75, 74, 74),
                                fontSize: 21,
                                fontWeight: FontWeight.normal))),
                    const Padding(padding: EdgeInsets.only(left: 110)),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_forward_ios),
                      color: const Color.fromARGB(255, 75, 74, 74),
                      iconSize: 22,
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 8, 20, 20),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Color.fromARGB(255, 75, 74, 74)))),
                ),
                Row(
                  children: [
                    const Padding(padding: EdgeInsets.only(left: 10)),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.notifications),
                      iconSize: 33,
                      color: const Color.fromARGB(255, 75, 74, 74),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 10)),
                    TextButton(
                        onPressed: () {},
                        child: const Text('Notifications',
                            style: TextStyle(
                                color: Color.fromARGB(255, 75, 74, 74),
                                fontSize: 21,
                                fontWeight: FontWeight.normal))),
                    const Padding(padding: EdgeInsets.only(left: 150)),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_forward_ios),
                      color: const Color.fromARGB(255, 75, 74, 74),
                      iconSize: 22,
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 8, 20, 20),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Color.fromARGB(255, 75, 74, 74)))),
                ),
                Row(
                  children: [
                    const Padding(padding: EdgeInsets.only(left: 10)),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.remove_red_eye),
                      iconSize: 33,
                      color: const Color.fromARGB(255, 75, 74, 74),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 10)),
                    TextButton(
                        onPressed: () {},
                        child: const Text('Appearance',
                            style: TextStyle(
                                color: Color.fromARGB(255, 75, 74, 74),
                                fontSize: 21,
                                fontWeight: FontWeight.normal))),
                    const Padding(padding: EdgeInsets.only(left: 160)),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_forward_ios),
                      color: const Color.fromARGB(255, 75, 74, 74),
                      iconSize: 22,
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 8, 20, 20),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Color.fromARGB(255, 75, 74, 74)))),
                ),
                Row(
                  children: [
                    const Padding(padding: EdgeInsets.only(left: 10)),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.feedback),
                      iconSize: 33,
                      color: const Color.fromARGB(255, 75, 74, 74),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 10)),
                    TextButton(
                        onPressed: () {},
                        child: const Text('Send Feedback',
                            style: TextStyle(
                                color: Color.fromARGB(255, 75, 74, 74),
                                fontSize: 21,
                                fontWeight: FontWeight.normal))),
                    const Padding(padding: EdgeInsets.only(left: 130)),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_forward_ios),
                      color: const Color.fromARGB(255, 75, 74, 74),
                      iconSize: 22,
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 8, 20, 20),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Color.fromARGB(255, 75, 74, 74)))),
                ),
                Row(
                  children: [
                    const Padding(padding: EdgeInsets.only(left: 10)),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.question_mark_sharp),
                      iconSize: 33,
                      color: const Color.fromARGB(255, 75, 74, 74),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 10)),
                    TextButton(
                        onPressed: () {},
                        child: const Text('About',
                            style: TextStyle(
                                color: Color.fromARGB(255, 75, 74, 74),
                                fontSize: 21,
                                fontWeight: FontWeight.normal))),
                    const Padding(padding: EdgeInsets.only(left: 217)),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_forward_ios),
                      color: const Color.fromARGB(255, 75, 74, 74),
                      iconSize: 22,
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 8, 20, 20),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Color.fromARGB(255, 75, 74, 74)))),
                ),
              ],
            )));
  }
}
