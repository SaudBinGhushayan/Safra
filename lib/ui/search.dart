// ignore_for_file: prefer_const_constructors

import 'dart:math';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:safra/backend/storage.dart';
import 'package:safra/objects/comments.dart';
import 'package:safra/objects/user.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safra/backend/httpHandler.dart';
import 'package:safra/backend/snackBar.dart';
import 'package:safra/objects/Places.dart';
import 'package:safra/objects/Trips.dart';
import 'package:safra/objects/TripsInfo.dart';
import 'package:safra/ui/ContactUs.dart';
import 'package:safra/ui/FAQ.dart';
import 'package:safra/ui/accountInformation.dart';
import 'package:safra/ui/homePage.dart';
import 'package:safra/ui/mention.dart';
import 'package:safra/ui/schedule1.dart';

import 'package:safra/ui/dashboardn.dart';
import 'package:safra/ui/searchMaterial.dart';
import 'package:safra/ui/stngs.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:supabase/supabase.dart';
import 'package:translator/translator.dart';

class search extends StatefulWidget {
  const search({Key? key}) : super(key: key);
  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {
  _searchState() {
    selectedValue = dropdownlist[0];
  }

  // late Future<List<Places>?> searchData;
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();

  //   searchData =
  //       httpHandler().getPlaces(city, category, sortType, min_price, max_price);
  // }

  late String city = '';
  late String category = '';
  final filter_1 = TextEditingController();

// this is for min price
  final filter_2 = TextEditingController();
  final filter_3 = TextEditingController();
  // added
  final comment = TextEditingController();
  final url = TextEditingController();
  OverlayEntry? entry;
  OverlayEntry? entry_date;
  String fsq_id = '${(Random().nextDouble() * 256).toStringAsFixed(4)}';
  String name = '';
  String rating = '';
  String tel = '';
  String country = '';
  String region = '';
  String price = '';
  String description = '';
  String translated_description = '';
  String categories = '';
  String photo_url = '';
  String active = 'true';
  String photoUrl = '';
  String username = '';
  late String sortType = 'Relevance';
  String td = '';
  late String min_price = '0';
  late String max_price = '5';
  List<String> links = [];

  final user = FirebaseAuth.instance.currentUser!;
  var isloaded = false;
  String tripid = '';
  String trip_id = '${(Random().nextDouble() * 256).toStringAsFixed(4)}';
  String trip_name = '';
  var _value = false;
  bool noTrips = false;
  bool pressed_create = false;

  final dropdownlist = ['Relevance', 'Rating', 'Popularity'];
  String? selectedValue = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            const SizedBox(
              height: 34,
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
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
                          //===============================================================
                          setState(() {
                            city = url.text;

                            category = filter_1.text;

                            min_price = compare_min(filter_2.text);

                            max_price = compare_max(filter_3.text);
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
                                      child: Column(
                                    children: [
                                      TextField(
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
                                                  color: Colors.grey))),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Text('Sort by: '),
                                          DropdownButton(
                                              value: selectedValue,
                                              items: dropdownlist.map((e) {
                                                return DropdownMenuItem(
                                                  child: Text(e),
                                                  value: e,
                                                );
                                              }).toList(),
                                              onChanged: (val) {
                                                setState(() {
                                                  sortType = val as String;
                                                  selectedValue = val as String;
                                                });
                                              }),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Column(
                                        children: [
                                          Text('Minimum Price: '),
                                          TextField(
                                              controller: filter_2,
                                              style: const TextStyle(),
                                              decoration: InputDecoration(
                                                  border:
                                                      const OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(40),
                                                    ),
                                                  ),
                                                  hintText:
                                                      'Type range: \$ to \$\$\$\$',
                                                  hintStyle: const TextStyle(
                                                      color: Colors.grey)))
                                        ],
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Column(
                                        children: [
                                          Text('Maximum Price: '),
                                          TextField(
                                              controller: filter_3,
                                              style: const TextStyle(),
                                              decoration: InputDecoration(
                                                  border:
                                                      const OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(40),
                                                    ),
                                                  ),
                                                  hintText:
                                                      'Type range: \$ to \$\$\$\$',
                                                  hintStyle: const TextStyle(
                                                      color: Colors.grey)))
                                        ],
                                      )
                                    ],
                                  )),
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
                  onPressed: () async {},
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
                  // ==================================================== to edit sort by ====================================
                  future: httpHandler().getPlaces(
                      city, category, sortType, min_price, max_price),

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
                                  onPressed: () async {
                                    // here photo function called ----------------------------------------------------------------
                                    add_links(places![index].photo_url);

                                    td = await returen_translate(
                                        places[index].description);

                                    var route = new MaterialPageRoute(
                                        builder: (context) =>
                                            new searchMaterial(
                                                places: places![index],
                                                td: td,
                                                Links: links));
                                    Navigator.of(context).push(route);
                                  },
                                  child: Container(
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.only(left: 10),
                                      child: ListTile(
                                        title: Text(places![index].name,
                                            style:
                                                const TextStyle(fontSize: 20)),
                                        trailing: Text(places[index].rating),
                                        leading: Container(
                                            width: 50,
                                            height: 50,
                                            child: CircleAvatar(
                                              radius: 50,
                                              child: ClipOval(
                                                child: Image.network(
                                                  places[index]
                                                      .photo_url
                                                      .substring(
                                                          0,
                                                          places[index]
                                                              .photo_url
                                                              .indexOf(',')),
                                                  fit: BoxFit.fill,
                                                  width: 50,
                                                  height: 50,
                                                ),
                                              ),
                                            )),
                                      )),
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
            ) //=====================================================
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

  void add_links(String link) {
    List<String> templink = link.split(',');
    links.addAll(templink);
  }

  void split_categories() {}

  // Future<String> detect_language(String text) async {
  //   final languageIdentifier = LanguageIdentifier(confidenceThreshold: 0.5);

  //   final String response = await languageIdentifier.identifyLanguage(text);

  //   if (response == 'en')
  //     return '';
  //   else {
  //     return returen_translate(text);
  //   }
  // }
  String compare_min(String text) {
    if (text == '') {
      return '0';
    }
    if (text == '\$') {
      return '1';
    } else if (text == '\$\$') {
      return '2';
    } else if (text == '\$\$\$') {
      return '3';
    } else if (text == '\$\$\$\$') {
      return '4';
    } else
      return '0';
  }

  String compare_max(String text) {
    if (text == '') {
      return '5';
    }
    if (text == '\$') {
      return '1';
    } else if (text == '\$\$') {
      return '2';
    } else if (text == '\$\$\$') {
      return '3';
    } else if (text == '\$\$\$\$') {
      return '4';
    } else
      return '5';
  }

  Future<String> returen_translate(String text) async {
    final translator = GoogleTranslator();
    var translation = await translator.translate(text, to: 'en');

    int result = text.compareTo(translation.text);

    if (result == 0) {
      return 'Not Available';
    } else {
      return translation.text;
    }
  }
}
