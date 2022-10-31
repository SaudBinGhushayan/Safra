// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:safra/backend/storage.dart';
import 'package:safra/backend/supabase.dart';
import 'package:safra/objects/Trips.dart';
import 'package:safra/objects/TripsInfo.dart';
import 'package:safra/objects/displayTripsInfo.dart';
import 'package:safra/objects/user.dart';
import 'package:safra/ui/ContactUs.dart';
import 'package:safra/ui/FAQ.dart';
import 'package:safra/ui/ManageActivities.dart';
import 'package:safra/ui/ManageTrips.dart';
import 'package:safra/ui/accountInformation.dart';
import 'package:safra/ui/search.dart';
import 'package:safra/ui/stngs.dart';
import 'package:safra/ui/homePage.dart';
import 'package:safra/ui/schedule1.dart';
import 'package:safra/ui/stngs.dart';
import 'package:safra/ui/mention.dart';
import 'package:safra/ui/test.dart';

class dashboardn extends StatefulWidget {
  const dashboardn({Key? key}) : super(key: key);

  @override
  State<dashboardn> createState() => _dashboardnState();
}

class _dashboardnState extends State<dashboardn> {
  final user = FirebaseAuth.instance.currentUser!;
  List<String> links = [];

  OverlayEntry? entry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<Users?>(
            future: Users.readUser(user.uid),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final users = snapshot.data!;
                return Scaffold(
                    body: Container(
                  //////1st column
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('images/BackgroundPics/background.png'),
                    fit: BoxFit.cover,
                  )),

                  child: Column(
                    children: [
                      Row(
                        //menu icon
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
                                onPressed: menu,
                              )),
                          const SizedBox(
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
                        ], //end1st row
                      ),
                      // ElevatedButton(
                      //     onPressed: () {
                      //       Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //               builder: (context) => test()));
                      //     },
                      //     child: Text('Testing area')),
                      Row(
                        //2ndrow
                        children: [
                          Container(
                              //Your next activity
                              margin: const EdgeInsets.only(left: 30, top: 170),
                              child: Row(children: [
                                Text(
                                  'Your Next Activity',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 19,
                                  ),
                                ),
                                SizedBox(width: 100),
                                TextButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ManageActivities()));
                                    },
                                    label: Text('Manage'),
                                    icon: Icon(Icons.manage_history))
                              ])),
                        ],
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                          height: 196,
                          child: FutureBuilder<List<Trips>?>(
                              future:
                                  Trips.displayNearestTripActivities(user.uid),
                              builder: (context, snapshot) {
                                if (snapshot.data?.length == 0) {
                                  return Text('No data');
                                } else if (snapshot.hasError) {
                                  return Text('Something went wrong');
                                } else if (snapshot.hasData) {
                                  final trips = snapshot.data!;
                                  return SizedBox(
                                      height: 100,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: trips.length,
                                          itemBuilder: ((context, index) {
                                            add_links(trips[index].photo_url);
                                            return Row(children: [
                                              Center(
                                                  child: Container(
                                                      margin: EdgeInsets.only(
                                                          left: 10),
                                                      width: 196,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                links[index]),
                                                            fit: BoxFit.cover),
                                                      ),
                                                      child: Column(children: [
                                                        SizedBox(height: 50),
                                                        Container(
                                                            margin: EdgeInsets
                                                                .fromLTRB(3, 75,
                                                                    50, 0),
                                                            padding:
                                                                EdgeInsets.all(
                                                                    3),
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                                color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            201,
                                                                            201,
                                                                            201)
                                                                    .withOpacity(
                                                                        0.9)),
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Icon(
                                                                        Icons
                                                                            .location_city,
                                                                        color: Colors
                                                                            .blue,
                                                                        size:
                                                                            14),
                                                                    Expanded(
                                                                      child: Text(
                                                                          trips[index]
                                                                              .name,
                                                                          maxLines:
                                                                              2,
                                                                          overflow: TextOverflow
                                                                              .ellipsis,
                                                                          style:
                                                                              TextStyle(fontSize: 16)),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Icon(
                                                                        Icons
                                                                            .pin_drop_outlined,
                                                                        color: Colors
                                                                            .blue,
                                                                        size:
                                                                            14),
                                                                    Text(
                                                                        trips[index]
                                                                            .country,
                                                                        maxLines:
                                                                            2,
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                16)),
                                                                    SizedBox(
                                                                        width:
                                                                            40),
                                                                    Icon(
                                                                        Icons
                                                                            .date_range,
                                                                        color: Colors
                                                                            .blue,
                                                                        size:
                                                                            14),
                                                                    Text(
                                                                        '12 jun',
                                                                        maxLines:
                                                                            2,
                                                                        overflow:
                                                                            TextOverflow
                                                                                .clip,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                16)),
                                                                  ],
                                                                ),
                                                              ],
                                                            )),
                                                      ]))),
                                              SizedBox(width: 12)
                                            ]);
                                          })));
                                } else {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                              })),
                      Container(
                          //Your next activity
                          margin: const EdgeInsets.only(left: 30),
                          child: Row(children: [
                            Text(
                              'Your Current Trip',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 19,
                              ),
                            ),
                            SizedBox(width: 130),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ManageTrips()));
                              },
                              child: Text('See all',
                                  style: TextStyle(fontSize: 15)),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.blue,
                              size: 20,
                            )
                          ])),
                      SizedBox(
                          height: 95,
                          child: FutureBuilder<List<displayTripsInfo>?>(
                              future:
                                  displayTripsInfo.displayNearestTrip(user.uid),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Text('Something went wrong');
                                } else if (snapshot.data == null) {
                                  return Text('No data');
                                } else if (snapshot.hasData &&
                                    links.isNotEmpty) {
                                  final trip = snapshot.data![0];
                                  return Container(
                                      margin: EdgeInsets.only(
                                          left: 20, right: 20, top: 20),
                                      padding:
                                          EdgeInsets.fromLTRB(20, 2, 20, 2),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color:
                                              Color.fromARGB(255, 120, 192, 250)
                                                  .withOpacity(0.3)),
                                      child: Row(children: <Widget>[
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(5, 5, 5, 5),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.network(links[0],
                                                  height: 50,
                                                  width: 70,
                                                  fit: BoxFit.cover)),
                                        ),
                                        Expanded(
                                          child: Column(children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  10, 10, 5, 3),
                                              child: Text(
                                                  trip.tripsInfo.trip_name,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style:
                                                      TextStyle(fontSize: 17)),
                                            ),
                                            Wrap(
                                              children: [
                                                Icon(Icons.date_range,
                                                    color: Colors.blue,
                                                    size: 14),
                                                Text(
                                                    '${DateFormat("MMM").format(trip.tripsInfo.from)}${trip.tripsInfo.from.day} - ${DateFormat("MMM").format(trip.tripsInfo.to)}${trip.tripsInfo.to.day}'
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 16)),
                                              ],
                                            )
                                          ]),
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(left: 25),
                                            padding: EdgeInsets.fromLTRB(
                                                20, 5, 20, 5),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                color: trip.tripsInfo.active ==
                                                        'true'
                                                    ? Colors.blue
                                                    : Colors.red
                                                        .withOpacity(0.3)
                                                        .withOpacity(0.3)),
                                            child: Text(
                                                trip.tripsInfo.active
                                                            .toString() ==
                                                        'true'
                                                    ? 'joined'
                                                    : 'Not Active',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white))),
                                      ]));
                                } else {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                              })),
                      Container(
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
                                  'images/NavigationBar/DashboardActive.jpg'),
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
                                  'images/NavigationBar/Schedule.jpg'),
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
                    ],
                  ),
                ));
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

  void add_links(String link) {
    List<String> templink = link.split(',');
    links.addAll(templink);
  }
}
