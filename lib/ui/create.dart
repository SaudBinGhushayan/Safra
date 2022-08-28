import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:safra/objects/user.dart';
import 'package:safra/ui/dashboardn.dart';
import 'package:safra/ui/profile.dart';
import 'package:safra/ui/schedule1.dart';

class create extends StatefulWidget {
  const create({Key? key}) : super(key: key);

  @override
  State<create> createState() => _createState();
}

class _createState extends State<create> {
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
                    resizeToAvoidBottomInset: false,
                    body: Container(
                        //////1st column
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage(
                              'images/BackgroundPics/background.jpg'),
                          fit: BoxFit.cover,
                        )),
                        child: SingleChildScrollView(
                          child: Column(children: [
                            Row(
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
                              ],
                            ),
                            const SizedBox(height: 45),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(40),
                                      ),
                                      color: Colors.white),
                                  child: const TextField(
                                    style: TextStyle(),
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(40),
                                          ),
                                        ),
                                        hintText: 'Intrested in ?',
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        prefixIcon: const Icon(Icons.search,
                                            color: Color.fromARGB(
                                                255, 102, 101, 101))),
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(0, 60, 250, 0),
                                  child: const Text(
                                    'Categories',
                                    style: TextStyle(
                                        fontSize: 21, fontFamily: 'Verdana'),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Row(children: [
                                  Container(
                                      padding: const EdgeInsets.all(15),
                                      margin: const EdgeInsets.only(left: 20),
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(25),
                                          ),
                                          color: Colors.grey),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        "Activites",
                                        style: TextStyle(
                                            fontSize: 21,
                                            color: Colors.white,
                                            fontFamily: 'Verdana'),
                                      )),
                                  Container(
                                      padding: const EdgeInsets.all(16),
                                      margin: const EdgeInsets.only(left: 20),
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(25),
                                          ),
                                          color: Colors.grey),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        "Places",
                                        style: TextStyle(
                                            fontSize: 21,
                                            color: Colors.white,
                                            fontFamily: 'Verdana'),
                                      )),
                                ]),
                                SizedBox(height: 260),
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
                                        padding: const EdgeInsets.only(
                                            left: 29, bottom: 29),
                                      ),
                                      IconButton(
                                        onPressed: () {},
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
                            )
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
