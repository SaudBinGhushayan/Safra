import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:safra/backend/snackBar.dart';
import 'package:safra/objects/ActiveTrips.dart';
import 'package:safra/objects/Activities.dart';
import 'package:safra/objects/Places.dart';
import 'package:safra/objects/Trips.dart';
import 'package:safra/ui/accountInformation.dart';

import 'package:safra/ui/schedule1.dart';

import 'package:safra/ui/dashboardn.dart';

class search extends StatefulWidget {
  const search({Key? key}) : super(key: key);

  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {
  String city = '';
  OverlayEntry? entry;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: 900,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('images/BackgroundPics/background.jpg'),
          fit: BoxFit.cover,
        )),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                    width: 33,
                    height: 33,
                    margin: const EdgeInsets.fromLTRB(5, 4, 1, 1),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.menu),
                      iconSize: 20,
                      onPressed: () {},
                    )),
                Container(
                  //profile icon
                  height: 50,
                  width: 140,
                  margin: const EdgeInsets.fromLTRB(228, 5, 1, 1),
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
                      ),
                      const Expanded(child: Text('from database'))
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 34,
            ),
            Container(
              margin: const EdgeInsets.only(top: 14.7),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(40),
                  ),
                  color: Colors.white),
              child: TextField(
                style: const TextStyle(),
                decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(40),
                      ),
                    ),
                    hintText: 'Explore new destination',
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: IconButton(
                        icon: const Icon(Icons.search,
                            color: Color.fromARGB(255, 102, 101, 101)),
                        onPressed: () {})),
                onChanged: (value) => setState(() {
                  city = value;
                }),
              ),
            ),
            SizedBox(height: 55),
            Container(
              margin: EdgeInsets.only(right: 210),
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(232, 147, 160, 172),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 0, bottom: 0),
                    textStyle: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  child: const Text(
                    "Activities",
                    style: TextStyle(color: Colors.white, fontSize: 21),
                  )),
            ),
            SizedBox(
                height: 150,
                child: StreamBuilder<List<Activities>>(
                    stream: readActivities(city),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final activity = snapshot.data!;
                        return SingleChildScrollView(
                            child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 32, top: 3),
                                child: Center(
                                    child: Column(children: [
                                  ListView(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      children: activity
                                          .map(buildActivities)
                                          .toList()),
                                ]))));
                      } else if (!snapshot.hasData) {
                        return const Text('no search data');
                      } else {
                        return snackBar.showSnackBarRed('Something Went Wrong');
                      }
                    })),
            Container(
              margin: EdgeInsets.only(right: 210, top: 20),
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(232, 147, 160, 172),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 0, bottom: 0),
                    textStyle: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  child: const Text(
                    "Places",
                    style: TextStyle(color: Colors.white, fontSize: 21),
                  )),
            ),
            SizedBox(
                height: 130,
                child: StreamBuilder<List<Places>>(
                    stream: readPlaces(city),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final places = snapshot.data!;
                        return SingleChildScrollView(
                            child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 32, top: 3),
                                child: Center(
                                    child: Column(children: [
                                  ListView(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      children:
                                          places.map(buildPlaces).toList()),
                                ]))));
                      } else if (!snapshot.hasData) {
                        return const Text('No Search Data');
                      } else {
                        return snackBar.showSnackBarRed('Something Went Wrong');
                      }
                    })),
            Container(
              //start of navigation bar
              margin: const EdgeInsets.only(top: 0),
              height: 210,
              width: 500,
              decoration: const BoxDecoration(
                  image: DecorationImage(
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
                    icon: Image.asset('images/NavigationBar/Mention.jpg'),
                    iconSize: 55,
                    padding: const EdgeInsets.only(left: 14, bottom: 29),
                  ),
                  Container(
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(27.5, 0.2, 30, 70),
                          child: CircleAvatar(
                              radius: 24,
                              backgroundColor:
                                  const Color.fromARGB(255, 39, 97, 213),
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
                              builder: (context) =>
                                  const accountInformation()));
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
    ));
  }

  Stream<List<Activities>> readActivities(String city) => FirebaseFirestore
      .instance
      .collection('activities')
      .where('city', isEqualTo: city.toLowerCase())
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => Activities.readFromJson(doc.data()))
          .toList());

  Widget buildActivities(Activities activity) => Row(children: [
        TextButton(
            onPressed: () {},
            child: Text(activity.city, style: const TextStyle(fontSize: 21))),
        TextButton(
            onPressed: () {
              entry = OverlayEntry(
                  builder: (context) => Scaffold(
                      resizeToAvoidBottomInset: false,
                      body: Card(
                        margin: const EdgeInsets.all(0),
                        child: Column(children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.only(left: 30),
                          ),
                          Container(
                              padding: const EdgeInsets.only(left: 10, top: 20),
                              color: Color.fromARGB(31, 255, 255, 255)
                                  .withOpacity(0.8),
                              child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ElevatedButton.icon(
                                          onPressed: hideMenu,
                                          icon:
                                              const Icon(Icons.arrow_back_ios),
                                          label: const Text('back'),
                                        ),
                                        const SizedBox(height: 200),
                                        Padding(
                                            padding: EdgeInsets.only(left: 30)),
                                        Text('City: ${activity.city}',
                                            style:
                                                const TextStyle(fontSize: 21)),
                                        const SizedBox(height: 20),
                                        Text(
                                            'Activity Name: ${activity.activity}',
                                            style:
                                                const TextStyle(fontSize: 21)),
                                        const SizedBox(height: 20),
                                        Text('Activity Date: ${activity.date}',
                                            style:
                                                const TextStyle(fontSize: 21)),
                                      ]))),
                          const SizedBox(height: 40),
                          ElevatedButton.icon(
                            onPressed: () async {
                              final valid =
                                  await Trips.availableTrip(activity.activity);
                              if (!valid) {
                                snackBar.showSnackBarRed(
                                    'Activity already registered');
                              } else {
                                final user = FirebaseAuth.instance.currentUser!;
                                createTrip(
                                  tripId: activity.city +
                                      Random().nextInt(1000).toString(),
                                  uid: user.uid,
                                  city: activity.city,
                                  go: activity.activity,
                                  date: activity.date,
                                );
                                createActiveTrip(
                                    uid: user.uid, city: activity.city);
                                snackBar.showSnackBarGreen(
                                    'Activity Added Successfully');
                                hideMenu();
                              }
                            },
                            icon: const Icon(Icons.check_box),
                            label: const Text('book activity'),
                          ),
                        ]),
                      )));

              final overlay = Overlay.of(context);
              overlay?.insert(entry!);
            },
            child:
                Text(activity.activity, style: const TextStyle(fontSize: 21))),
      ]);

  Stream<List<Places>> readPlaces(String city) => FirebaseFirestore.instance
      .collection('places')
      .where('city', isEqualTo: city.toLowerCase())
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Places.readFromJson(doc.data())).toList());

  Widget buildPlaces(Places places) => Row(children: [
        TextButton(
            onPressed: () {},
            child: Text(places.city, style: const TextStyle(fontSize: 21))),
        TextButton(
            onPressed: () {
              entry = OverlayEntry(
                  builder: (context) => Scaffold(
                      resizeToAvoidBottomInset: false,
                      body: Card(
                        margin: const EdgeInsets.all(0),
                        child: Column(children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.only(left: 30),
                          ),
                          Container(
                              padding: const EdgeInsets.only(left: 10, top: 20),
                              color: Color.fromARGB(31, 255, 255, 255)
                                  .withOpacity(0.8),
                              child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ElevatedButton.icon(
                                          onPressed: hideMenu,
                                          icon:
                                              const Icon(Icons.arrow_back_ios),
                                          label: const Text('back'),
                                        ),
                                        const SizedBox(height: 200),
                                        Padding(
                                            padding: EdgeInsets.only(left: 30)),
                                        Text('City: ${places.city}',
                                            style:
                                                const TextStyle(fontSize: 21)),
                                        const SizedBox(height: 20),
                                        Text('Activity Name: ${places.place}',
                                            style:
                                                const TextStyle(fontSize: 21)),
                                        const SizedBox(height: 20),
                                      ]))),
                          const SizedBox(height: 40),
                          ElevatedButton.icon(
                            onPressed: () async {
                              final valid =
                                  await Trips.availableTrip(places.place);
                              if (!valid) {
                                snackBar.showSnackBarRed(
                                    'Place already registered');
                              } else {
                                final user = FirebaseAuth.instance.currentUser!;
                                createTrip(
                                  tripId: places.city +
                                      Random().nextInt(1000).toString(),
                                  uid: user.uid,
                                  city: places.city,
                                  go: places.place,
                                  date: '',
                                );
                                snackBar.showSnackBarGreen(
                                    'Place Added Successfully');
                                hideMenu();
                              }
                            },
                            icon: const Icon(Icons.check_box),
                            label: const Text('book activity'),
                          ),
                        ]),
                      )));

              final overlay = Overlay.of(context);
              overlay?.insert(entry!);
            },
            child: Text(places.place, style: const TextStyle(fontSize: 21))),
      ]);

  void hideMenu() {
    entry?.remove();
    entry = null;
  }
}
