import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:safra/backend/storage.dart';
import 'package:safra/ui/ContactUs.dart';
import 'package:safra/ui/FAQ.dart';
import 'package:safra/ui/Generate.dart';
import 'package:safra/ui/accountInformation.dart';
import 'package:safra/ui/create.dart';
import 'package:safra/ui/dashboardn.dart';
import 'package:safra/ui/homePage.dart';
import 'package:safra/ui/join.dart';
import 'package:safra/ui/mention.dart';
import 'package:safra/ui/search.dart';
import 'package:safra/ui/searchtrip.dart';
import 'package:safra/ui/stngs.dart';
import 'package:safra/ui/simple_dialogs.dart';
import '../objects/user.dart';
import 'package:safra/ui/searchtrip.dart';

class schedule1 extends StatefulWidget {
  const schedule1({super.key});
  @override
  State<schedule1> createState() => _schedule1();
}

class _schedule1 extends State<schedule1> {
  final user = FirebaseAuth.instance.currentUser!;
  OverlayEntry? entry;
  Future<void> scheduleoption() async {
    switch (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text('Select your option'),
            children: [
              Container(
                height: 50,
                width: 40,
                padding: EdgeInsets.only(right: 270),
                // color: Color.fromARGB(255, 16, 13, 201),
                child: TextButton(
                    child: Text(
                      'Search',
                      style: TextStyle(),
                    ),
                    onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const searchtrip())),
                        }),
              ),
              Container(
                padding: EdgeInsets.only(right: 258),
                child: TextButton(
                    child: Text('Manually'),
                    onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const create())),
                        }),
              ),
              Container(
                padding: EdgeInsets.only(right: 258),
                child: TextButton(
                    child: Text('Generate'),
                    onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Generate())),
                        }),
              )
            ],
          );
        })) {
      case option.Generate:
        print('Generate');
        break;
      case option.Generate:
        print('Manually');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<Users?>(
            future: Users.readUser(user.uid),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              } else if (snapshot.hasData) {
                final users = snapshot.data!;
                return Scaffold(
                  drawer: Drawer(),
                  body: Container(
                    //////1st column
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage('images/BackgroundPics/background.png'),
                      fit: BoxFit.cover,
                    )),

                    child: Column(children: [
                      Row(
                        children: [
                          Container(
                              width: 33,
                              height: 33,
                              padding: EdgeInsets.only(top: 0.1, right: 9),
                              margin: const EdgeInsets.fromLTRB(5, 12, 1, 1),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: IconButton(
                                  icon: const Icon(Icons.menu),
                                  iconSize: 20,
                                  onPressed: menu)),
                          SizedBox(
                            height: 90,
                          ),
                          Container(
                            //profile icon
                            height: 50,
                            width: 140,
                            margin: const EdgeInsets.fromLTRB(228, 19, 1, 1),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: 550,
                                  width: 55,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: FutureBuilder(
                                      future: Storage.readImage(user.uid),
                                      builder:
                                          (BuildContext context, snapshot) {
                                        if (snapshot.connectionState ==
                                                ConnectionState.done &&
                                            snapshot.hasData) {
                                          return ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            child: Image.network(
                                              snapshot.data!.toString(),
                                              fit: BoxFit.contain,
                                              width: 300,
                                              height: 300,
                                            ),
                                          );
                                        } else if (!snapshot.hasData) {
                                          return const Icon(
                                            Icons.person,
                                            size: 20,
                                          );
                                        } else {
                                          return Center(
                                              child: SpinKitCircle(
                                            size: 140,
                                            itemBuilder: (context, index) {
                                              final colors = [
                                                Colors.blue,
                                                Colors.cyan
                                              ];
                                              final color =
                                                  colors[index % colors.length];
                                              return DecoratedBox(
                                                  decoration: BoxDecoration(
                                                      color: color));
                                            },
                                          ));
                                        }
                                      }),
                                ),
                                Expanded(child: Text(users.username))
                              ],
                            ),
                          )
                        ],
                      ),
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 165, 135, 0),
                          child: Text(
                            'What do you Prefer ?',
                            style:
                                TextStyle(fontSize: 21, fontFamily: 'Verdana'),
                          )),
                      Spacer(),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const join()));
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 2, 95, 172),
                              textStyle: const TextStyle(fontSize: 20),
                              padding: EdgeInsets.fromLTRB(160, 10, 160, 10)),
                          child: const Text("Join")),
                      SizedBox(height: 30),
                      ElevatedButton(
                          onPressed: scheduleoption,
                          style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 2, 95, 172),
                              textStyle: const TextStyle(fontSize: 20),
                              padding: EdgeInsets.fromLTRB(150, 10, 150, 10)),
                          child: const Text("Create")),
                      SizedBox(
                        height: 69,
                      ),

                      //bottomnavigationbar
                      Container(
                        padding: EdgeInsets.only(top: 57),
                        margin: const EdgeInsets.only(top: 26),
                        height: 200,
                        width: 500,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                alignment: Alignment.bottomCenter,
                                image: AssetImage(
                                    "images/NavigationBar/Navigator.jpg"))),
                        child: Row(
                          children: [
                            IconButton(
                              alignment: Alignment.topCenter,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const dashboardn()));
                              },
                              icon: Image.asset(
                                  'images/NavigationBar/Dashboard.jpg'),
                              iconSize: 55,
                              padding:
                                  const EdgeInsets.only(left: 29, bottom: 29),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const mention()));
                              },
                              icon: Image.asset(
                                  'images/NavigationBar/Mention.jpg'),
                              iconSize: 55,
                              padding:
                                  const EdgeInsets.only(left: 14, bottom: 29),
                            ),
                            Container(
                                child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        27.5, 0.2, 30, 70),
                                    child: CircleAvatar(
                                        radius: 24,
                                        backgroundColor: const Color.fromARGB(
                                            255, 250, 101, 2),
                                        child: IconButton(
                                          icon: const Icon(Icons.search,
                                              color: Colors.white),
                                          iconSize: 31,
                                          padding: const EdgeInsets.all(0.2),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const search()));
                                          },
                                        )))),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const schedule1()));
                              },
                              icon: Image.asset(
                                  'images/NavigationBar/ScheduleActive.jpg'),
                              iconSize: 55,
                              padding:
                                  const EdgeInsets.only(left: 1, bottom: 29),
                              highlightColor: Colors.white,
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            accountInformation()));
                              },
                              icon: Image.asset(
                                  'images/NavigationBar/Profile.jpg'),
                              iconSize: 55,
                              padding:
                                  const EdgeInsets.only(left: 10, bottom: 26),
                            ),
                          ],
                        ),
                      )
                    ]),
                  ),
                );
              } else {
                return Center(
                    child: SpinKitCircle(
                  size: 140,
                  itemBuilder: (context, index) {
                    final colors = [Colors.blue, Colors.cyan];
                    final color = colors[index % colors.length];
                    return DecoratedBox(
                        decoration: BoxDecoration(color: color));
                  },
                ));
              }
            }));
  }

  void menu() {
    entry = OverlayEntry(
        builder: (context) => Card(
              margin: EdgeInsets.all(0),
              color: Colors.black54.withOpacity(0.8),
              child: Column(children: [
                const SizedBox(height: 200),
                Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 30),
                    child: Text('Menu',
                        style: TextStyle(color: Colors.grey, fontSize: 21))),
                SizedBox(height: 40),
                Container(
                    color: Colors.black12.withOpacity(0.5),
                    child: Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(top: 10, left: 30),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const stngs())),
                                  hideMenu()
                                },
                                child: const Text(
                                  'Settings',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 21,
                                  ),
                                ),
                              ),
                              SizedBox(height: 25),
                              TextButton(
                                onPressed: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const FAQ())),
                                  hideMenu()
                                },
                                child: const Text(
                                  'FAQ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 21,
                                  ),
                                ),
                              ),
                              SizedBox(height: 25),
                              TextButton(
                                onPressed: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const contactUs())),
                                  hideMenu()
                                },
                                child: const Text(
                                  'Contact Us',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 21,
                                  ),
                                ),
                              ),
                              SizedBox(height: 25),
                              TextButton(
                                onPressed: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const homePage())),
                                  FirebaseAuth.instance.signOut(),
                                  hideMenu()
                                },
                                child: const Text(
                                  'Sign out',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 21,
                                  ),
                                ),
                              )
                            ]))),
                SizedBox(height: 40),
                ElevatedButton.icon(
                  onPressed: hideMenu,
                  icon: Icon(Icons.visibility_off),
                  label: Text('back'),
                )
              ]),
            ));

    final overlay = Overlay.of(context);
    overlay?.insert(entry!);
  }

  void hideMenu() {
    entry?.remove();
    entry = null;
  }
}

enum option { Generate, Manually, search }
