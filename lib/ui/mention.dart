import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:safra/backend/snackBar.dart';
import 'package:safra/backend/storage.dart';
import 'package:safra/backend/supabase.dart';
import 'package:safra/objects/mentionClass.dart';
import 'package:safra/objects/participate.dart';
import 'package:safra/objects/user.dart';
import 'package:safra/ui/ContactUs.dart';
import 'package:safra/ui/FAQ.dart';
import 'package:safra/ui/accountInformation.dart';
import 'package:safra/ui/dashboardn.dart';
import 'package:safra/ui/homePage.dart';
import 'package:safra/ui/schedule1.dart';
import 'package:safra/ui/search.dart';
import 'package:safra/ui/stngs.dart';

class mention extends StatefulWidget {
  const mention({Key? key}) : super(key: key);

  @override
  State<mention> createState() => _mentionState();
}

class _mentionState extends State<mention> {
  final user = FirebaseAuth.instance.currentUser!;
  OverlayEntry? entry;
  String username = '';
  String comment_string = '';
  int likes = 0;
  int dislikes = 0;
  String comment_id = '';
  String participate_id = '${(Random().nextDouble() * 256).toStringAsFixed(4)}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 1000,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('images/BackgroundPics/background.png'),
          fit: BoxFit.cover,
        )),
        child: Column(
          children: [
            FutureBuilder<Users?>(
                future: Users.readUser(user.uid),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final users = snapshot.data!;
                    username = users.username;
                    return Row(
                      //menu icon
                      children: [
                        Container(
                            width: 33,
                            height: 33,
                            padding: EdgeInsets.only(top: 0.1, right: 9),
                            margin: const EdgeInsets.fromLTRB(5, 0, 1, 1),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.menu),
                              iconSize: 20,
                              onPressed: menu,
                            )),
                        const SizedBox(
                          height: 90,
                        ),
                        Container(
                          //profile icon
                          height: 50,
                          width: 140,
                          margin: const EdgeInsets.fromLTRB(228, 7, 1, 1),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 55,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: FutureBuilder(
                                    future: Storage.readImage(user.uid),
                                    builder: (BuildContext context, snapshot) {
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
                      ], //end1st row
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
            Container(
              margin: EdgeInsets.fromLTRB(15, 170, 240, 5),
              child: Text(
                "Notifcations",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(15, 5, 240, 5),
              child: Text(
                "Trip Requests",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
            ),
            SizedBox(
                height: 196,
                child: FutureBuilder<List<Mention>?>(
                    future: Mention.readRequests(user.uid),
                    builder: (context, snapshot) {
                      if (snapshot.data?.length == 0) {
                        return Center(
                            child: Text('No Requests',
                                style: TextStyle(color: Colors.blue)));
                      } else if (snapshot.hasError) {
                        return Text('Something went wrong');
                      } else if (snapshot.hasData) {
                        final requests = snapshot.data!;
                        return SizedBox(
                            height: 100,
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: requests.length,
                                itemBuilder: ((context, index) {
                                  return Column(
                                    children: [
                                      Row(children: [
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                left: 10, top: 10),
                                            child: Text(requests[index].message,
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(fontSize: 16)),
                                          ),
                                        ),
                                      ]),
                                      Container(
                                        margin: EdgeInsets.only(right: 200),
                                        child: Row(
                                          children: [
                                            IconButton(
                                                onPressed: () async {
                                                  addMember(
                                                      uid: user.uid,
                                                      username: username,
                                                      active: 'true',
                                                      participate_id:
                                                          participate_id,
                                                      trip_id: requests[index]
                                                          .trip_id);
                                                  snackBar.showSnackBarGreen(
                                                      'member added successfully');
                                                  await SupaBase_Manager()
                                                      .client
                                                      .from('mention')
                                                      .delete()
                                                      .match({
                                                    'mention_id':
                                                        requests[index]
                                                            .mentionId
                                                  }).execute();
                                                },
                                                icon: Icon(Icons.check,
                                                    color: Colors.green)),
                                            IconButton(
                                                onPressed: () async {
                                                  await SupaBase_Manager()
                                                      .client
                                                      .from('mention')
                                                      .delete()
                                                      .match({
                                                    'mention_id':
                                                        requests[index]
                                                            .mentionId
                                                  }).execute();
                                                  snackBar.showSnackBarGreen(
                                                      'Request from ${requests[index].susername} has been removed');
                                                },
                                                icon: Icon(Icons.delete_forever,
                                                    color: Colors.red))
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                })));
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    })),
            Container(
              padding: EdgeInsets.only(top: 57),
              margin: const EdgeInsets.only(top: 100),
              height: 200,
              width: 500,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      alignment: Alignment.bottomCenter,
                      image: AssetImage("images/NavigationBar/Navigator.jpg"))),
              child: Row(
                children: [
                  IconButton(
                    alignment: Alignment.topCenter,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const dashboardn()));
                    },
                    icon: Image.asset('images/NavigationBar/Dashboard.jpg'),
                    iconSize: 55,
                    padding: const EdgeInsets.only(left: 29, bottom: 29),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                        'images/NavigationBar/mentionactive (2).png'),
                    iconSize: 55,
                    padding: const EdgeInsets.only(left: 14, bottom: 29),
                  ),
                  Container(
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(27.5, 0.2, 30, 70),
                          child: CircleAvatar(
                              radius: 24,
                              backgroundColor:
                                  const Color.fromARGB(255, 250, 101, 2),
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
                              builder: (context) => const schedule1()));
                    },
                    icon: Image.asset('images/NavigationBar/Schedule.jpg'),
                    iconSize: 55,
                    padding: const EdgeInsets.only(left: 1, bottom: 29),
                    highlightColor: Colors.white,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => accountInformation()));
                    },
                    icon: Image.asset('images/NavigationBar/Profile.jpg'),
                    iconSize: 55,
                    padding: const EdgeInsets.only(left: 10, bottom: 26),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
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
