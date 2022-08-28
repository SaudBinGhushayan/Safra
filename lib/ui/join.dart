import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:safra/objects/user.dart';
import 'package:safra/ui/dashboardn.dart';
import 'package:safra/ui/profile.dart';
import 'package:safra/ui/schedule1.dart';
import 'package:safra/ui/mention.dart';
import 'package:safra/ui/search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class join extends StatefulWidget {
  const join({Key? key}) : super(key: key);

  @override
  State<join> createState() => _joinState();
}

class _joinState extends State<join> {
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
                    body: Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage(
                              'images/BackgroundPics/background.jpg'),
                          fit: BoxFit.cover,
                        )),
                        child: SingleChildScrollView(
                          reverse: true,
                          child: Column(children: [
                            Row(
                              //menu icon
                              children: [
                                Container(
                                    width: 33,
                                    height: 33,
                                    margin: const EdgeInsets.fromLTRB(
                                        5, 40.5, 1, 1),
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    child: const Icon(
                                      Icons.menu,
                                      size: 20,
                                    )),
                                const SizedBox(
                                  height: 90,
                                ),
                                Container(
                                  //profile icon
                                  height: 50,
                                  width: 140,
                                  margin: const EdgeInsets.fromLTRB(
                                      228, 47.8, 1, 1),
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 55,
                                        width: 55,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                      ),
                                      Expanded(child: Text(users.username))
                                    ],
                                  ),
                                )
                              ], //end1st row
                            ),
                            Center(
                              //Jointrip,tripid,..
                              child: Column(
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(top: 200),
                                      child: Text(
                                        'Join trip',
                                        style: TextStyle(
                                            fontSize: 21,
                                            fontFamily: "verdana",
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black),
                                      )),
                                  Container(
                                    margin: EdgeInsets.only(top: 30),
                                    child: Text(
                                      'Please enter your trip id',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontFamily: "verdana",
                                          color: Colors.black),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 20),
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(40),
                                        ),
                                        color: Colors.white),
                                    child: const TextField(
                                      textAlign: TextAlign.left,
                                      style: TextStyle(),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(40),
                                          ),
                                        ),
                                        hintText: 'Trip id',
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 40),
                                  ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                          primary:
                                              Color.fromARGB(255, 2, 95, 172),
                                          textStyle:
                                              const TextStyle(fontSize: 20),
                                          padding: EdgeInsets.fromLTRB(
                                              160, 10, 160, 10)),
                                      child: const Text("Join")),
                                  Container(
                                    margin: const EdgeInsets.only(top: 150),
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
                                          padding: const EdgeInsets.only(
                                              left: 29, bottom: 29),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const mention()));
                                          },
                                          icon: Image.asset(
                                              'images/NavigationBar/Mention.jpg'),
                                          iconSize: 55,
                                          padding: const EdgeInsets.only(
                                              left: 14, bottom: 29),
                                        ),
                                        Container(
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        27.5, 0.2, 30, 70),
                                                child: CircleAvatar(
                                                    radius: 24,
                                                    backgroundColor:
                                                        const Color.fromARGB(
                                                            255, 250, 101, 2),
                                                    child: IconButton(
                                                      icon: const Icon(
                                                          Icons.search,
                                                          color: Colors.white),
                                                      iconSize: 31,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0.2),
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
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
                                          padding: const EdgeInsets.only(
                                              left: 1, bottom: 29),
                                          highlightColor: Colors.white,
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const profile()));
                                          },
                                          icon: Image.asset(
                                              'images/NavigationBar/Profile.jpg'),
                                          iconSize: 55,
                                          padding: const EdgeInsets.only(
                                              left: 10, bottom: 26),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            //      SizedBox(height: 39.5),
                          ]),
                        )));
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
