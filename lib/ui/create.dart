import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:safra/backend/storage.dart';
import 'package:safra/objects/user.dart';
import 'package:safra/ui/dashboardn.dart';
import 'package:safra/ui/profile.dart';
import 'package:safra/ui/schedule1.dart';
import 'package:safra/ui/mention.dart';


class create extends StatefulWidget {
  const create({Key? key}) : super(key: key);

  @override
  State<create> createState() => _createState();
}

class _createState extends State<create> {
  final user = FirebaseAuth.instance.currentUser!;
  OverlayEntry? entry;

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
                                        height: 550,
                                        width: 55,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        child: FutureBuilder(
                                            future: Storage.readImage(user.uid),
                                            builder: (BuildContext context,
                                                snapshot) {
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
                                                  itemBuilder:
                                                      (context, index) {
                                                    final colors = [
                                                      Colors.blue,
                                                      Colors.cyan
                                                    ];
                                                    final color = colors[
                                                        index % colors.length];
                                                    return DecoratedBox(
                                                        decoration:
                                                            BoxDecoration(
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
                              Text(
                                'Settings',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 21),
                              ),
                              SizedBox(height: 25),
                              Text(
                                'FAQ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 21),
                              ),
                              SizedBox(height: 25),
                              Text(
                                'Contact Us',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 21),
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 25),
                              TextButton(
                                onPressed: () =>
                                    FirebaseAuth.instance.signOut(),
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
