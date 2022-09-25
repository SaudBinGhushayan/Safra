import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:safra/backend/httpHandler.dart';
import 'package:safra/backend/snackBar.dart';
import 'package:safra/objects/ActiveTrips.dart';
import 'package:safra/objects/Activities.dart';
import 'package:safra/objects/Places.dart';
import 'package:safra/objects/Places.dart';
import 'package:safra/objects/Trips.dart';
import 'package:safra/ui/ContactUs.dart';
import 'package:safra/ui/FAQ.dart';
import 'package:safra/ui/accountInformation.dart';
import 'package:http/http.dart' as http;
import 'package:safra/ui/homePage.dart';
import 'package:safra/ui/mention.dart';
import 'package:safra/ui/schedule1.dart';

import 'package:safra/ui/dashboardn.dart';
import 'package:safra/ui/stngs.dart';
import 'package:safra/ui/test.dart';

class search extends StatefulWidget {
  const search({Key? key}) : super(key: key);

  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {
  String city = '';
  OverlayEntry? entry;
  List<Places>? places;
  var isloaded = false;

  @override
  // void initState() {
  //   super.initState();
  //   getData();
  // }

  // getData() async {
  //   places = await httpHandler().getPlaces();
  //   if (places != null) {
  //     setState(() {
  //       isloaded = true;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: 1400,
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
                      onPressed: menu,
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
              margin: const EdgeInsets.only(top: 16),
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
            const SizedBox(height: 55),
            Container(
              margin: const EdgeInsets.only(
                right: 230,
              ),
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
            // SizedBox(
            //   height: 350,
            //   child: Visibility(
            //     visible: isloaded,
            //     child: ListView.builder(
            //         itemCount: places?.length,
            //         itemBuilder: ((context, index) {
            //           return Container(
            //               child: Text('${places![index].name.toString()}'));
            //         })),
            //     replacement: const Center(
            //       child: Text('no data'),
            //     ),
            //   ),
            // ),
            SizedBox(
                height: 350,
                child: FutureBuilder<List<Places>?>(
                  future: httpHandler().getPlaces(city),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      places = snapshot.data!;
                      return SizedBox(
                        height: 350,
                        child: ListView.builder(
                            itemCount: places?.length,
                            itemBuilder: ((context, index) {
                              return Row(children: [
                                Expanded(
                                    child: TextButton(
                                  onPressed: () {
                                    entry = OverlayEntry(
                                        builder: (context) => Scaffold(
                                            resizeToAvoidBottomInset: false,
                                            body: Card(
                                              margin: const EdgeInsets.all(0),
                                              child: Column(children: [
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  margin: const EdgeInsets.only(
                                                      left: 30),
                                                ),
                                                Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10, top: 20),
                                                    color: const Color.fromARGB(
                                                            31, 255, 255, 255)
                                                        .withOpacity(0.8),
                                                    child: Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              //=============================================start here==========================================================
                                                              ElevatedButton
                                                                  .icon(
                                                                onPressed:
                                                                    hideMenu,
                                                                icon: const Icon(
                                                                    Icons
                                                                        .arrow_back_ios),
                                                                label:
                                                                    const Text(
                                                                        'back'),
                                                              ),
                                                              const SizedBox(
                                                                  height: 200),
                                                              const Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              30)),
                                                              Text(
                                                                  'Country: ${places![index].country}',
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          21)),
                                                              Text(
                                                                  'Region: ${places![index].region}',
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          21)),
                                                              const SizedBox(
                                                                  height: 20),
                                                              Text(
                                                                  'Name: ${places![index].name}',
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          21)),
                                                              const SizedBox(
                                                                  height: 20),
                                                              Text(
                                                                  'Rating: ${places![index].rating}',
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          21)),
                                                              Text(
                                                                  'Telephone: ${places![index].tel}',
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          21)),
                                                              Text(
                                                                  'Price: ${places![index].price}',
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          21)),
                                                              Text(
                                                                  'Description: ${places![index].description}',
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          21)),
                                                            ]))),
                                                const SizedBox(height: 40),
                                                ElevatedButton.icon(
                                                  onPressed: () {
                                                    // final valid =
                                                    //     await Trips.availableTrip(activity.activity);
                                                    // if (!valid) {
                                                    //   snackBar.showSnackBarRed(
                                                    //       'Activity already registered');
                                                    // } else {
                                                    //   final user = FirebaseAuth.instance.currentUser!;
                                                    //   createTrip(
                                                    //     tripId: activity.city +
                                                    //         Random().nextInt(1000).toString(),
                                                    //     uid: user.uid,
                                                    //     city: activity.city,
                                                    //     go: activity.activity,
                                                    //     date: activity.date,
                                                    //   );
                                                    //   createActiveTrip(
                                                    //       uid: user.uid, city: activity.city);
                                                    //   snackBar.showSnackBarGreen(
                                                    //       'Activity Added Successfully');
                                                    //   hideMenu();
                                                  },
                                                  icon: const Icon(
                                                      Icons.check_box),
                                                  label: const Text(
                                                      'book activity'),
                                                ),
                                              ]),
                                            )));

                                    final overlay = Overlay.of(context);
                                    overlay?.insert(entry!);
                                  },
                                  child: Container(
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(places![index].name,
                                          style:
                                              const TextStyle(fontSize: 20))),
                                )),
                              ]);
                            })),
                      );
                      //===========================================================end here==============================================================
                    } else {
                      return Center(
                          child: Text('No Search Data',
                              style: TextStyle(fontSize: 21)));
                    }
                  },
                )),
            Container(
              //start of navigation bar
              padding: EdgeInsets.only(top: 65),
              height: 210,
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
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const mention()));
                    },
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
