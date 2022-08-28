import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:safra/ui/create.dart';
import 'package:safra/ui/dashboardn.dart';
import 'package:safra/ui/join.dart';
import 'package:safra/ui/profile.dart';

import '../objects/user.dart';

class schedule1 extends StatefulWidget {
  const schedule1({super.key});
  @override
  State<schedule1> createState() => _schedule1();
}

class _schedule1 extends State<schedule1> {
  final user = FirebaseAuth.instance.currentUser!;

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
                      image: AssetImage('images/BackgroundPics/background.jpg'),
                      fit: BoxFit.cover,
                    )),

                    child: Column(children: [
                      Row(
                        children: [
                          Container(
                              width: 33,
                              height: 33,
                              margin: EdgeInsets.fromLTRB(5, 69.4, 1, 1),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Icon(
                                Icons.menu,
                                size: 20,
                              )),
                          SizedBox(
                            height: 90,
                          ),
                          Container(
                            height: 50,
                            width: 132,
                            margin: EdgeInsets.fromLTRB(202, 70, 3, 1),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: 55,
                                  width: 55,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                ),
                                Expanded(child: Text(users.username))
                              ],
                            ),
                          )
                        ],
                      ),
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 135, 135, 0),
                          child: Text(
                            'What do you Prefer ?',
                            style:
                                TextStyle(fontSize: 21, fontFamily: 'Verdana'),
                          )),
                      SizedBox(height: 150),
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
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const create()));
                          },
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
                        margin: const EdgeInsets.only(top: 26),
                        height: 200,
                        width: 500,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
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
                              onPressed: () {},
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
                                          onPressed: () {},
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
                                        builder: (context) => const profile()));
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
}
