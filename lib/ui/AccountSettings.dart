import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:safra/ui/dashboardn.dart';
import 'package:safra/ui/stngs.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({Key? key}) : super(key: key);

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
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
                                  builder: (context) => const stngs()));
                        })),
                const SizedBox(height: 20),
                const Text('Account Settings',
                    style: TextStyle(
                        fontSize: 33, color: Color.fromARGB(255, 75, 74, 74))),
                const SizedBox(height: 80),
                Row(
                  children: [
                    const Padding(padding: EdgeInsets.only(left: 10)),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.pin_drop),
                      iconSize: 33,
                      color: const Color.fromARGB(255, 75, 74, 74),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 10)),
                    TextButton(
                        onPressed: () {},
                        child: const Text('Location',
                            style: TextStyle(
                                color: Color.fromARGB(255, 75, 74, 74),
                                fontSize: 21,
                                fontWeight: FontWeight.normal))),
                    const Padding(padding: EdgeInsets.only(left: 183)),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_forward_ios),
                      color: const Color.fromARGB(255, 75, 74, 74),
                      iconSize: 22,
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Color.fromARGB(255, 75, 74, 74)))),
                ),
                Row(
                  children: [
                    const Padding(padding: EdgeInsets.only(left: 10)),
                    IconButton(
                      onPressed: () {},
                      icon: new Icon(Icons.change_circle),
                      iconSize: 33,
                      color: const Color.fromARGB(255, 75, 74, 74),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 10)),
                    TextButton(
                        onPressed: () {},
                        child: const Text('Change Username',
                            style: TextStyle(
                                color: Color.fromARGB(255, 75, 74, 74),
                                fontSize: 21,
                                fontWeight: FontWeight.normal))),
                    const Padding(padding: EdgeInsets.only(left: 95)),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_forward_ios),
                      color: const Color.fromARGB(255, 75, 74, 74),
                      iconSize: 22,
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: const Color.fromARGB(255, 75, 74, 74)))),
                ),
                Row(
                  children: [
                    const Padding(padding: EdgeInsets.only(left: 10)),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.key),
                      iconSize: 33,
                      color: const Color.fromARGB(255, 75, 74, 74),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 10)),
                    TextButton(
                        onPressed: () {},
                        child: const Text('Change Password',
                            style: TextStyle(
                                color: Color.fromARGB(255, 75, 74, 74),
                                fontSize: 21,
                                fontWeight: FontWeight.normal))),
                    const Padding(padding: EdgeInsets.only(left: 100)),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_forward_ios),
                      color: const Color.fromARGB(255, 75, 74, 74),
                      iconSize: 22,
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: const BorderSide(
                              color: Color.fromARGB(255, 75, 74, 74)))),
                ),
                Row(
                  children: [
                    const Padding(padding: EdgeInsets.only(left: 10)),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.info),
                      iconSize: 33,
                      color: const Color.fromARGB(255, 75, 74, 74),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 10)),
                    TextButton(
                        onPressed: () {},
                        child: const Text('Account Info',
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
                  margin: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Color.fromARGB(255, 75, 74, 74)))),
                ),
                Row(
                  children: [
                    const Padding(padding: EdgeInsets.only(left: 10)),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.delete),
                      iconSize: 33,
                      color: const Color.fromARGB(255, 75, 74, 74),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 10)),
                    TextButton(
                        onPressed: () {},
                        child: const Text('Delete Account',
                            style: TextStyle(
                                color: Color.fromARGB(255, 75, 74, 74),
                                fontSize: 21,
                                fontWeight: FontWeight.normal))),
                    const Padding(padding: EdgeInsets.only(left: 125)),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_forward_ios),
                      color: const Color.fromARGB(255, 75, 74, 74),
                      iconSize: 22,
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Color.fromARGB(255, 75, 74, 74)))),
                ),
              ],
            )));
  }
}
