// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:safra/backend/httpHandler.dart';
import 'package:safra/backend/snackBar.dart';
import 'package:safra/backend/supabase.dart';
import 'package:safra/objects/Places.dart';
import 'package:safra/objects/Places.dart';
import 'package:safra/objects/Trips.dart';
import 'package:safra/objects/TripsInfo.dart';
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
  String category = '';
  final filter_1 = TextEditingController();
  final url = TextEditingController();
  OverlayEntry? entry;
  OverlayEntry? entry_date;
  String fsq_id = '';
  String name = '';
  String rating = '';
  String tel = '';
  String country = '';
  String region = '';
  String price = '';
  String description = '';
  String active = 'true';
  final user = FirebaseAuth.instance.currentUser!;
  List<String> uids = [];
  var isloaded = false;
  String tripid = '';
  String trip_id = '${Random().nextDouble() * 265}';
  String trip_name = '';
  var _value = false;
  bool noTrips = false;
  bool pressed_create = false;
  var enterTripName = TextEditingController();
  var from_cont = TextEditingController();
  var to_cont = TextEditingController();
  DateTime from = DateTime.parse('2020-01-12');
  DateTime to = DateTime.parse('2020-01-12');
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
          image: AssetImage('images/BackgroundPics/background.png'),
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
                controller: url,
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
                        onPressed: () {
                          setState(() {
                            city = url.text;

                            category = filter_1.text;
                          });
                        }),
                    suffixIcon: IconButton(
                        icon: const Icon(Icons.filter_list,
                            color: Color.fromARGB(255, 102, 101, 101)),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(actions: [
                                  Container(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'Advanced Search',
                                      )),
                                  PopupMenuItem(
                                      child: TextField(
                                          controller: filter_1,
                                          style: const TextStyle(),
                                          decoration: InputDecoration(
                                              border: const OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(40),
                                                ),
                                              ),
                                              hintText: 'Enter Category',
                                              hintStyle: const TextStyle(
                                                  color: Colors.grey)))),
                                ]);
                              });
                        })),
              ),
            ),
            const SizedBox(height: 55),
            Container(
              margin: const EdgeInsets.only(
                right: 230,
              ),
              child: ElevatedButton(
                  onPressed: () async {
                    final response = await SupaBase_Manager()
                        .client
                        .from('trips_info')
                        .insert([
                      {"uids": List<dynamic>.from(uids.map((x) => 'gg'))}
                    ]).execute();
                    print(response.error);

                    // if (response.error == null) {
                    //   var data = response.data.toString();
                    //   data = data.replaceAll('{', '{"');
                    //   data = data.replaceAll(': ', '": "');
                    //   data = data.replaceAll(', ', '", "');
                    //   data = data.replaceAll('}', '"}');
                    //   data = data.replaceAll('}",', '},');
                    //   data = data.replaceAll('"{', '{');
                    //   print(data);
                    // }
                  },
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
                height: 350,
                child: FutureBuilder<List<Places>?>(
                  future: httpHandler().getPlaces(city, category),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Places>? places;
                      places = snapshot.data!;
                      return SizedBox(
                        height: 350,
                        child: ListView.builder(
                            itemCount: places.length,
                            itemBuilder: ((context, index) {
                              return Row(children: [
                                Expanded(
                                    child: TextButton(
                                  onPressed: () {
                                    entry = OverlayEntry(
                                        builder: (context) => Scaffold(
                                                body: SingleChildScrollView(
                                              child: Column(children: [
                                                //========================================================= start here =======================================================================
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
                                                              ElevatedButton
                                                                  .icon(
                                                                onPressed: () {
                                                                  hideMenu();
                                                                  setState(() {
                                                                    ValueNotifier<bool>(
                                                                            false)
                                                                        .value = false;
                                                                  });
                                                                  pressed_create =
                                                                      true;
                                                                },
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
                                                                  'Region: ${places[index].region}',
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          21)),
                                                              const SizedBox(
                                                                  height: 20),
                                                              Text(
                                                                  'Name: ${places[index].name}',
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          21)),
                                                              const SizedBox(
                                                                  height: 20),
                                                              Text(
                                                                  'Rating: ${places[index].rating}',
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          21)),
                                                              Text(
                                                                  'Telephone: ${places[index].tel}',
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          21)),
                                                              Text(
                                                                  'Price: ${places[index].price}',
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          21)),
                                                              Text(
                                                                  'Description: ${places[index].description}',
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          21)),
                                                            ]))),
                                                const SizedBox(height: 40),
                                                SizedBox(
                                                  height: 200,
                                                  child: FutureBuilder<
                                                      List<TripsInfo>?>(
                                                    future: TripsInfo
                                                        .readTrips_Info(
                                                            user.uid),
                                                    builder:
                                                        (context, snapshot) {
                                                      print(snapshot.error);
                                                      if (snapshot.hasError) {
                                                        return Text(
                                                            'something went wrong');
                                                      } else if (snapshot
                                                              .data?.length ==
                                                          0) {
                                                        noTrips = true;
                                                        return Text(
                                                            'no trips registerd');
                                                      } else if (snapshot
                                                          .hasData) {
                                                        List<TripsInfo> data =
                                                            snapshot.data!;
                                                        return SizedBox(
                                                            height: 200,
                                                            child: ListView
                                                                .builder(
                                                              itemCount:
                                                                  data.length,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                return Container(
                                                                    margin: EdgeInsets
                                                                        .fromLTRB(
                                                                            20,
                                                                            0,
                                                                            20,
                                                                            4),
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    child: Row(
                                                                        children: [
                                                                          Expanded(
                                                                              child: Text(data[index].trip_name, style: TextStyle(fontSize: 21))),
                                                                          SizedBox(
                                                                              width: 20),
                                                                          Expanded(
                                                                              child: Text('${data[index].from.year}/${data[index].from.month}/${data[index].from.day}'.toString(), style: TextStyle(fontSize: 18))),
                                                                          SizedBox(
                                                                              width: 10),
                                                                          Expanded(
                                                                              child: Text('${data[index].to.year}/${data[index].to.month}/${data[index].to.day}', style: TextStyle(fontSize: 18))),
                                                                          ValueListenableBuilder<bool>(
                                                                              valueListenable: ValueNotifier<bool>(false),
                                                                              builder: (context, value, child) {
                                                                                return Checkbox(
                                                                                  onChanged: (value) {
                                                                                    setState(() {
                                                                                      _value = value!;
                                                                                      trip_name = data[index].trip_name;
                                                                                      tripid = data[index].tripId;
                                                                                    });
                                                                                  },
                                                                                  value: value,
                                                                                );
                                                                              })
                                                                        ]));
                                                              },
                                                            ));
                                                      } else {
                                                        return Center(
                                                            child:
                                                                CircularProgressIndicator());
                                                      }
                                                    },
                                                  ),
                                                ),
                                                ElevatedButton.icon(
                                                  onPressed: () async {
                                                    setState(() {
                                                      fsq_id =
                                                          places![index].fsq_id;

                                                      name = places[index].name;

                                                      rating =
                                                          places[index].rating;

                                                      tel = places[index].tel;

                                                      country =
                                                          places[index].country;

                                                      region =
                                                          places[index].region;

                                                      price =
                                                          places[index].price;

                                                      description =
                                                          places[index]
                                                              .description;
                                                    });
                                                    final tripExist =
                                                        await Trips
                                                            .availableTrip(
                                                                user.uid);
                                                    if (tripExist &&
                                                        _value == true) {
                                                      appendTrip(
                                                          uid: user.uid,
                                                          fsq_id: fsq_id,
                                                          name: name,
                                                          rating: rating,
                                                          tel: tel,
                                                          country: country,
                                                          region: region,
                                                          price: price,
                                                          description:
                                                              description,
                                                          active: active,
                                                          trip_id: tripid,
                                                          trip_name: trip_name);

                                                      snackBar.showSnackBarGreen(
                                                          'Activity Added to trip ${trip_name} Successfully');

                                                      hideMenu();
                                                      setState(() {
                                                        _value = false;
                                                      });
                                                    } else if (noTrips) {
                                                      return snackBar
                                                          .showSnackBarRed(
                                                              'You dont have a registered trips yet please create a trip in schedule page');
                                                    } else if (_value ==
                                                        false) {
                                                      return snackBar
                                                          .showSnackBarRed(
                                                              'please select which trip to add your activity');
                                                    }
                                                  },
                                                  icon: const Icon(
                                                      Icons.check_box),
                                                  label: const Text(
                                                      'book activity'),
                                                ),
                                                ElevatedButton.icon(
                                                  onPressed: () async {
                                                    setState(() {
                                                      fsq_id =
                                                          places![index].fsq_id;

                                                      name = places[index].name;

                                                      rating =
                                                          places[index].rating;

                                                      tel = places[index].tel;

                                                      country =
                                                          places[index].country;

                                                      region =
                                                          places[index].region;

                                                      price =
                                                          places[index].price;

                                                      description =
                                                          places[index]
                                                              .description;
                                                    });
                                                    if (!pressed_create &&
                                                        !noTrips) {
                                                      pressed_create = true;
                                                      snackBar.showSnackBarYellow(
                                                          'You have registered trips if you want to create a new trip press create again');
                                                    } else {
                                                      datePicker();
                                                    }
                                                  },
                                                  icon: const Icon(
                                                      Icons.check_box),
                                                  label:
                                                      const Text('create trip'),
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
                                  //===================================== end here ================================================
                                )),
                              ]);
                            })),
                      );
                    } else if (!snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.done) {
                      return Center(
                          child: Text('No Search Data',
                              style: TextStyle(fontSize: 21)));
                    } else {
                      return Center(
                          child: Column(children: const [
                        CircularProgressIndicator(),
                        Text(
                          'Please wait until we fetch your data',
                          style: TextStyle(fontSize: 21),
                        )
                      ]));
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

  void datePicker() {
    entry_date = OverlayEntry(
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
                              Container(
                                margin: const EdgeInsets.only(top: 16),
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(40),
                                    ),
                                    color: Colors.white),
                                child: TextField(
                                  controller: enterTripName,
                                  style: const TextStyle(),
                                  decoration: InputDecoration(
                                      border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(40),
                                        ),
                                      ),
                                      hintText: 'Enter trip name',
                                      hintStyle:
                                          const TextStyle(color: Colors.grey),
                                      prefixIcon: IconButton(
                                          icon: const Icon(Icons.search,
                                              color: Color.fromARGB(
                                                  255, 102, 101, 101)),
                                          onPressed: () {})),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 16),
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(40),
                                    ),
                                    color: Colors.white),
                                child: TextField(
                                  controller: from_cont,
                                  style: const TextStyle(),
                                  decoration: InputDecoration(
                                      border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(40),
                                        ),
                                      ),
                                      hintText: 'from',
                                      hintStyle:
                                          const TextStyle(color: Colors.grey),
                                      prefixIcon: IconButton(
                                          icon: const Icon(Icons.search,
                                              color: Color.fromARGB(
                                                  255, 102, 101, 101)),
                                          onPressed: () {})),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 16),
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(40),
                                    ),
                                    color: Colors.white),
                                child: TextField(
                                  controller: to_cont,
                                  style: const TextStyle(),
                                  decoration: InputDecoration(
                                      border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(40),
                                        ),
                                      ),
                                      hintText: 'to',
                                      hintStyle:
                                          const TextStyle(color: Colors.grey),
                                      prefixIcon: IconButton(
                                          icon: const Icon(Icons.search,
                                              color: Color.fromARGB(
                                                  255, 102, 101, 101)),
                                          onPressed: () {})),
                                ),
                              ),
                              TextButton(
                                child: Text('Cancel'),
                                onPressed: () {
                                  hideDatePicker();
                                },
                              ),
                              TextButton(
                                child: Text('Ok'),
                                onPressed: () {
                                  setState(() {
                                    trip_name = enterTripName.text;
                                    from = DateTime.tryParse(from_cont.text)!;
                                    to = DateTime.tryParse(to_cont.text)!;
                                  });
                                  createTrip(
                                      uid: user.uid,
                                      fsq_id: fsq_id,
                                      name: name,
                                      rating: rating,
                                      tel: tel,
                                      country: country,
                                      region: region,
                                      price: price,
                                      description: description,
                                      active: active,
                                      trip_id: trip_id,
                                      from: from,
                                      to: to,
                                      trip_name: trip_name);
                                  hideDatePicker();
                                  snackBar.showSnackBarGreen(
                                      'Activity Added to trip ${trip_name} Successfully');
                                  hideMenu();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const search()));
                                  setState(() {
                                    ValueNotifier<bool>(false).value = false;
                                  });
                                  setState(() {
                                    pressed_create = false;
                                  });
                                },
                              )
                            ]))),
                SizedBox(height: 40),
                ElevatedButton.icon(
                  onPressed: hideDatePicker,
                  icon: Icon(Icons.visibility_off),
                  label: Text('back'),
                )
              ]),
            ));

    final overlay = Overlay.of(context);
    overlay?.insert(entry_date!);
  }

  void hideDatePicker() {
    entry_date?.remove();
    entry_date = null;
  }
}
