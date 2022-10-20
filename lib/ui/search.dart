import 'dart:convert';
import 'dart:ffi';
import 'dart:math';
import 'package:safra/objects/comments.dart';
import 'package:safra/objects/user.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
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
import 'package:translator/translator.dart';
import 'package:google_mlkit_language_id/google_mlkit_language_id.dart';

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
  // added
  final comment = TextEditingController();
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
  String participate = '${Random().nextDouble() * 256}';
  String translated_description = '';
  String categories = '';
  String photo_url = '';
  String active = 'true';
  String photoUrl = '';
  String username = '';

  String td = '';

  List<String> links = [];

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
            FutureBuilder<Users?>(
                future: Users.readUser(user.uid),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final users = snapshot.data!;
                    username = users.username;
                    return Row(
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
                              Expanded(child: Text('from database'))
                            ],
                          ),
                        )
                      ],
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
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
                          //===============================================================
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
                  // ==================================================== to edit sort by ====================================
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
                                  onPressed: () async {
                                    // here photo function called ----------------------------------------------------------------
                                    td = await returen_translate(
                                        places![index].description);

                                    entry = OverlayEntry(builder: (context) {
                                      kill_links();
                                      add_links(places![index].photo_url);

                                      return Scaffold(
                                          body: SingleChildScrollView(
                                        child: Column(children: [
                                          //========================================================= start here =======================================================================
                                          Container(
                                              alignment: Alignment.centerLeft,
                                              margin: const EdgeInsets.only(
                                                  left: 30)),
                                          Container(
                                              padding: const EdgeInsets.only(
                                                  top: 20),
                                              color: Color.fromARGB(
                                                      31, 254, 254, 255)
                                                  .withOpacity(0.8),
                                              child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        IconButton(
                                                          onPressed: () {
                                                            kill_links();
                                                            hideMenu();
                                                            setState(() {
                                                              ValueNotifier<
                                                                          bool>(
                                                                      false)
                                                                  .value = false;
                                                            });
                                                            
                                                          },
                                                          icon: const Icon(Icons
                                                              .arrow_back_ios_new),
                                                        ),
                                                        // abdullah changed this
                                                        // const SizedBox(
                                                        //     height: 10),
                                                        const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 30)),

                                                        // this line was added by abdullah
                                                        SizedBox(
                                                          height: 5,
                                                        ),

                                                        SizedBox(
                                                            height: 150,
                                                            child: ListView
                                                                .builder(
                                                                    scrollDirection:
                                                                        Axis
                                                                            .horizontal,
                                                                    itemCount: links
                                                                        .length,
                                                                    itemBuilder:
                                                                        ((context,
                                                                            index) {
                                                                      return Row(
                                                                          children: [
                                                                            Center(
                                                                                child: Container(
                                                                              width: 196,
                                                                              decoration: BoxDecoration(
                                                                                image: DecorationImage(image: NetworkImage(links[index]), fit: BoxFit.cover),
                                                                                borderRadius: BorderRadius.circular(12),
                                                                                // gradient: LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: const [
                                                                                // Color.fromARGB(255, 129, 196, 228),
                                                                                // Colors.cyanAccent
                                                                                // ]),
                                                                              ),
                                                                            )),
                                                                            SizedBox(width: 3)
                                                                          ]);
                                                                    }))),

                                                        // image 'https://fastly.4sqi.net/img/general/original/1049719_PiLE0Meoa27AkuLvSaNwcvswnmYRa0vxLQkOrpgMlwk.jpg'
                                                        // Image.network(
                                                        //     links[0],
                                                        //     fit: BoxFit
                                                        //         .fill),
                                                        SizedBox(
                                                          height: 5,
                                                        ),

                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                style:
                                                                    BorderStyle
                                                                        .solid,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        214,
                                                                        214,
                                                                        224)),
                                                            // borderRadius:
                                                            //     BorderRadius
                                                            //         .all(
                                                            //   Radius.circular(
                                                            //       20),
                                                            // ),
                                                            // image: DecorationImage(
                                                            //     fit: BoxFit
                                                            //         .fill,
                                                            //     image: AssetImage(
                                                            //         'images/BackgroundPics/lightBackground.jpg'))
                                                          ),
                                                          width: 500,
                                                          height: 151,

                                                          // this row is for the top to containers for name , location, ratings and money
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    gradient:
                                                                        RadialGradient(
                                                                      colors: const [
                                                                        Colors
                                                                            .white,
                                                                        Colors
                                                                            .white12,
                                                                      ],
                                                                      radius:
                                                                          0.75,
                                                                      focal: Alignment(
                                                                          0.7,
                                                                          -0.7),
                                                                      tileMode:
                                                                          TileMode
                                                                              .clamp,
                                                                    ),
                                                                    border: Border.all(
                                                                        style: BorderStyle
                                                                            .solid,
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            255)),
                                                                    borderRadius: BorderRadius.only(
                                                                        bottomLeft:
                                                                            Radius.circular(
                                                                                20),
                                                                        topLeft:
                                                                            Radius.circular(20)),
                                                                    // image: DecorationImage(fit: BoxFit.fill, image: AssetImage('images/BackgroundPics/WhiteBackground.jpg'), colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.9), BlendMode.modulate))
                                                                  ),
                                                                  width: 200,
                                                                  height: 150,
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      SizedBox(
                                                                          height:
                                                                              25),
                                                                      GradientText(
                                                                        '${places[index].name}',
                                                                        colors: const [
                                                                          Colors
                                                                              .black,
                                                                          Colors
                                                                              .black,
                                                                          Colors
                                                                              .black
                                                                        ],
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: TextStyle(
                                                                            fontSize: places[index].name.length > 10
                                                                                ? 15
                                                                                : 25,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            25,
                                                                      ),
                                                                      Text(
                                                                        '${places[index].region},  ${places[index].country} ',
                                                                        style: TextStyle(
                                                                            fontSize: places[index].region.length > 12
                                                                                ? 15
                                                                                : 25,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                      )
                                                                    ],
                                                                  )),
                                                              Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    gradient:
                                                                        LinearGradient(
                                                                      begin: Alignment
                                                                          .centerLeft,
                                                                      end: Alignment
                                                                          .centerRight,
                                                                      colors: const [
                                                                        Colors
                                                                            .white12,
                                                                        Colors
                                                                            .white,
                                                                      ],
                                                                    ),
                                                                    border: Border.all(
                                                                        style: BorderStyle
                                                                            .solid,
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            255)),
                                                                    borderRadius: BorderRadius.only(
                                                                        topRight:
                                                                            Radius.circular(
                                                                                20),
                                                                        bottomRight:
                                                                            Radius.circular(20)),
                                                                    // image: DecorationImage(fit: BoxFit.fill, image: AssetImage('images/BackgroundPics/WhiteBackground.jpg'), colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.9), BlendMode.modulate))
                                                                  ),
                                                                  width: 209,
                                                                  height: 150,
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      SizedBox(
                                                                          height:
                                                                              25),
                                                                      Text(
                                                                        'Rating:',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            3,
                                                                      ),
                                                                      Text(
                                                                          '${places[index].rating}' == 'Not Available'
                                                                              ? ' '
                                                                              : '${places[index].rating}',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: TextStyle(
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.bold,
                                                                              color: places[index].rating == 'Not Available'
                                                                                  ? Colors.white
                                                                                  : double.parse(places[index].rating) >= 8
                                                                                      ? Colors.green
                                                                                      : double.parse(places[index].rating) < 8 && double.parse(places[index].rating) > 6
                                                                                          ? Color.fromARGB(255, 164, 160, 24)
                                                                                          : double.parse(places[index].rating) < 6
                                                                                              ? Colors.red
                                                                                              : Colors.black)),
                                                                      SizedBox(
                                                                          height:
                                                                              25),
                                                                      Text(
                                                                        '${places[index].price == '1.0' ? '\$' : places[index].price == '2.0' ? '\$\$' : places[index].price == '3.0' ? '\$\$\$' : places[index].price == '4.0' ? '\$\$\$\$' : places[index].price == 'Not Available' ? ' ' : ''}',
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: TextStyle(
                                                                            decoration: TextDecoration.underline,
                                                                            fontSize: 18,
                                                                            fontWeight: FontWeight.bold,
                                                                            color: places[index].price == '1.0'
                                                                                ? Color.fromARGB(255, 67, 164, 70)
                                                                                : places[index].price == '2.0'
                                                                                    ? Color.fromARGB(255, 91, 117, 29)
                                                                                    : places[index].price == '3.0'
                                                                                        ? Colors.orange
                                                                                        : places[index].price == '4.0'
                                                                                            ? Colors.red
                                                                                            : places[index].price == 'Not Available'
                                                                                                ? Colors.white
                                                                                                : Colors.white),
                                                                      )
                                                                    ],
                                                                  ))
                                                            ],
                                                          ),
                                                        ),
                                                        // SizedBox(
                                                        //   height: 10,
                                                        // ),
                                                        Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                              left: 3,
                                                            ),
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border.all(
                                                                  style:
                                                                      BorderStyle
                                                                          .solid,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          214,
                                                                          214,
                                                                          224)),
                                                              // borderRadius:
                                                              //     BorderRadius
                                                              //         .all(
                                                              //   Radius.circular(
                                                              //       20),
                                                              // ),
                                                              // image: DecorationImage(
                                                              //     fit: BoxFit
                                                              //         .fill,
                                                              //     image: AssetImage(
                                                              //         'images/BackgroundPics/lightBackground.jpg'))
                                                            ),
                                                            width: 500,
                                                            height: 500,

                                                            // this row is for the top to containers for name , location, ratings and money
                                                            child: Column(
                                                              // mainAxisAlignment:
                                                              //     MainAxisAlignment
                                                              //         .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  'About:',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Text(
                                                                  places[index]
                                                                      .description,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          16),
                                                                ),

                                                                // TextButton(onPressed: translate(places[index].description) , child: Text(
                                                                //   'translation:',
                                                                //   style: TextStyle(
                                                                //       fontSize:
                                                                //           10,
                                                                //       fontStyle:
                                                                //           FontStyle.italic,
                                                                //       decoration: TextDecoration.underline,
                                                                //       color: Colors.black),
                                                                // ),),

                                                                Text(
                                                                  td == 'Not Available'
                                                                      ? ''
                                                                      : ''
                                                                          'translation:',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          10,
                                                                      fontStyle:
                                                                          FontStyle
                                                                              .italic,
                                                                      decoration:
                                                                          TextDecoration
                                                                              .underline,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                Text(
                                                                  td == 'Not Available'
                                                                      ? ''
                                                                      : td,
                                                                  // places[index]
                                                                  //     .translated_description,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          16),
                                                                ),

                                                                SizedBox(
                                                                  height: 25,
                                                                ),

                                                                Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  width: 350,
                                                                  height: 100,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          border: Border.all(
                                                                              style: BorderStyle
                                                                                  .solid),
                                                                          borderRadius: BorderRadius
                                                                              .all(
                                                                            Radius.elliptical(200,
                                                                                300),
                                                                          ),
                                                                          color:
                                                                              Colors.white38),
                                                                  child: GradientText(
                                                                      places[index].categories.replaceAll(
                                                                          RegExp(
                                                                              ','),
                                                                          ',\t'),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      colors: const [
                                                                        Colors
                                                                            .black87,
                                                                        Colors
                                                                            .purple,
                                                                        Colors
                                                                            .blue
                                                                      ],
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.bold)),
                                                                ),
                                                                SizedBox(
                                                                  height: 20,
                                                                ),
                                                                Text(
                                                                  'More info:',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Text(
                                                                    'Telephone: ${places[index].tel}',
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            16)),

                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Text(
                                                                    'Open Hours: 7:00 to 20:00',
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            16)),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Text(
                                                                    'Full address: ---- , -- ,-------',
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            16)),
                                                                // Row(
                                                                //   mainAxisAlignment:
                                                                //       MainAxisAlignment.start,
                                                                //   crossAxisAlignment:
                                                                //       CrossAxisAlignment.start,
                                                                //   children: [
                                                                //     Text(places[index]
                                                                //         .categories)
                                                                //   ],
                                                                // )
                                                              ],
                                                            )
                                                            // name
                                                            ),
                                                        const SizedBox(
                                                            height: 15),

                                                        // HERE WILL BE LOCATION OF PLACE .. MUST MODIFY API FEATURES
                                                        // Text(
                                                        //   ''
                                                        // ),

                                                        const SizedBox(
                                                            height: 20),
                                                      ]))),

                                          const SizedBox(height: 40),
                                          SizedBox(
                                            height: 200,
                                            child:
                                                FutureBuilder<List<TripsInfo>?>(
                                              future: TripsInfo.readTrips_Info(
                                                  user.uid),
                                              builder: (context, snapshot) {
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
                                                } else if (snapshot.hasData) {
                                                  List<TripsInfo> data =
                                                      snapshot.data!;
                                                  return SizedBox(
                                                      height: 200,
                                                      child: ListView.builder(
                                                        itemCount: data.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Container(
                                                              margin: EdgeInsets
                                                                  .fromLTRB(20,
                                                                      0, 20, 4),
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Row(
                                                                  children: [
                                                                    Expanded(
                                                                        child: Text(
                                                                            data[index]
                                                                                .trip_name,
                                                                            style:
                                                                                TextStyle(fontSize: 21))),
                                                                    SizedBox(
                                                                        width:
                                                                            20),
                                                                    Expanded(
                                                                        child: Text(
                                                                            '${data[index].from.year}/${data[index].from.month}/${data[index].from.day}'
                                                                                .toString(),
                                                                            style:
                                                                                TextStyle(fontSize: 18))),
                                                                    SizedBox(
                                                                        width:
                                                                            10),
                                                                    Expanded(
                                                                        child: Text(
                                                                            '${data[index].to.year}/${data[index].to.month}/${data[index].to.day}',
                                                                            style:
                                                                                TextStyle(fontSize: 18))),
                                                                    ValueListenableBuilder<
                                                                            bool>(
                                                                        valueListenable:
                                                                            ValueNotifier<bool>(
                                                                                false),
                                                                        builder: (context,
                                                                            value,
                                                                            child) {
                                                                          return Checkbox(
                                                                            onChanged:
                                                                                (value) {
                                                                              setState(() {
                                                                                _value = value!;
                                                                                trip_name = data[index].trip_name;
                                                                                tripid = data[index].tripId;
                                                                              });
                                                                            },
                                                                            value:
                                                                                value,
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
                                          //// comment code =========================================================
                                          SizedBox(
                                            height: 200,
                                            child:
                                                FutureBuilder<List<Comments>?>(
                                              future: Comments.readComments(
                                                  places[index].fsq_id),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasError) {
                                                  return Text(
                                                      'something went wrong');
                                                } else if (snapshot
                                                        .data?.length ==
                                                    0) {
                                                  noTrips = true;
                                                  return Text('no comments');
                                                } else if (snapshot.hasData) {
                                                  List<Comments> comments =
                                                      snapshot.data!;
                                                  return SizedBox(
                                                      height: 200,
                                                      child: ListView.builder(
                                                        itemCount:
                                                            comments.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Container(
                                                              margin: EdgeInsets
                                                                  .fromLTRB(20,
                                                                      0, 20, 4),
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Row(
                                                                  children: [
                                                                    Expanded(
                                                                        child: Text(
                                                                            comments[index]
                                                                                .comment,
                                                                            style:
                                                                                TextStyle(fontSize: 21))),
                                                                    SizedBox(
                                                                        width:
                                                                            20),
                                                                    Text(
                                                                        comments[index]
                                                                            .likes
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                18)),
                                                                    IconButton(
                                                                        onPressed:
                                                                            () async {
                                                                          final interaction = await Comments.increment_likes(
                                                                              comments[index].comment_id,
                                                                              comments[index].likes);
                                                                          if (interaction) {
                                                                            snackBar.showSnackBarGreen('Comment added successfully');
                                                                          } else {
                                                                            snackBar.showSnackBarRed('Something went wrong');
                                                                          }
                                                                        },
                                                                        icon: Icon(
                                                                            Icons.thumb_up)),
                                                                    SizedBox(
                                                                        width:
                                                                            10),
                                                                    Text(
                                                                        comments[index]
                                                                            .dislikes
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                18)),
                                                                    IconButton(
                                                                        onPressed:
                                                                            () async {
                                                                          final interaction = await Comments.increment_dislikes(
                                                                              comments[index].comment_id,
                                                                              comments[index].dislikes);
                                                                          if (interaction) {
                                                                            snackBar.showSnackBarGreen('disliked successfully');
                                                                          } else {
                                                                            snackBar.showSnackBarRed('Something went wrong');
                                                                          }
                                                                        },
                                                                        icon: Icon(
                                                                            Icons.thumb_down)),
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

                                          // / comment button
                                          TextField(
                                              controller: comment,
                                              style: const TextStyle(),
                                              decoration: InputDecoration(
                                                  border:
                                                      const OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(40),
                                                    ),
                                                  ),
                                                  hintText: 'add a comment',
                                                  hintStyle: const TextStyle(
                                                      color: Colors.grey))),
                                          ElevatedButton.icon(
                                            onPressed: () async {
                                              if (comment.text.isEmpty) {
                                                snackBar.showSnackBarRed(
                                                    'No entered comment, please enter a comment');
                                              } else {
                                                addComment(
                                                    uid: user.uid,
                                                    comment_id:
                                                        (Random().nextDouble() *
                                                                265)
                                                            .toString(),
                                                    fsq_id:
                                                        places![index].fsq_id,
                                                    comment: comment.text,
                                                    likes: 0,
                                                    dislikes: 0);
                                                snackBar.showSnackBarGreen(
                                                    "Comment added successfully");
                                              }
                                            },
                                            icon: const Icon(Icons.check_box),
                                            label: const Text('add comment'),
                                          ),
                                          ElevatedButton.icon(
                                            onPressed: () async {
                                              final userHasTrips =
                                                  await TripsInfo.userHasTrip(
                                                      user.uid);
                                              if (userHasTrips) {
                                                active = "false";
                                              }
                                              setState(() {
                                                fsq_id = places![index].fsq_id;

                                                name = places[index].name;

                                                rating = places[index].rating;

                                                tel = places[index].tel;

                                                country = places[index].country;

                                                region = places[index].region;

                                                price = places[index].price;

                                                description =
                                                    places[index].description;
                                                translated_description = td;
                                                categories =
                                                    places[index].categories;
                                                photoUrl =
                                                    places[index].photo_url;
                                              });
                                              final tripExist =
                                                  await Trips.availableTrip(
                                                      user.uid);
                                              if (tripExist && _value == true) {
                                                appendTrip(
                                                    photo_url: photoUrl,
                                                    categories: categories,
                                                    translated_description: td,
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
                                                    trip_id: tripid,
                                                    trip_name: trip_name);

                                                snackBar.showSnackBarGreen(
                                                    'Activity Added to trip ${trip_name} Successfully');

                                                hideMenu();
                                                setState(() {
                                                  _value = false;
                                                });
                                              } else if (noTrips) {
                                                return snackBar.showSnackBarRed(
                                                    'You dont have a registered trips yet please create a trip in schedule page');
                                              } else if (_value == false) {
                                                return snackBar.showSnackBarRed(
                                                    'please select which trip to add your activity');
                                              }
                                            },
                                            icon: const Icon(Icons.check_box),
                                            label: const Text('book activity'),
                                          ),
                                          ElevatedButton.icon(
                                            onPressed: () async {
                                              setState(() {
                                                fsq_id = places![index].fsq_id;

                                                name = places[index].name;

                                                rating = places[index].rating;

                                                tel = places[index].tel;

                                                country = places[index].country;

                                                region = places[index].region;

                                                price = places[index].price;

                                                description =
                                                    places[index].description;
                                                translated_description = td;
                                                categories =
                                                    places[index].categories;
                                                photoUrl =
                                                    places[index].photo_url;
                                              });
                                              if (!pressed_create && !noTrips) {
                                                pressed_create = true;
                                                snackBar.showSnackBarYellow(
                                                    'You have registered trips if you want to create a new trip press create again');
                                              } else {
                                                datePicker();
                                              }
                                            },
                                            icon: const Icon(Icons.check_box),
                                            label: const Text('create trip'),
                                          ),
                                        ]),
                                      ));
                                    });
//=================================================================================================================
                                    final overlay = Overlay.of(context);
                                    overlay?.insert(entry!);
                                  },
                                  child: Container(
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.only(left: 10),
                                      child: ListTile(
                                        title: Text(places![index].name,
                                            style:
                                                const TextStyle(fontSize: 20)),
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
                                onPressed: () async {
                                  //==================================================================
                                  final userHasTrips =
                                      await TripsInfo.userHasTrip(user.uid);
                                  if (userHasTrips) {
                                    active = "false";
                                  }
                                  setState(() {
                                    trip_name = enterTripName.text;
                                    from = DateTime.tryParse(from_cont.text)!;
                                    to = DateTime.tryParse(to_cont.text)!;
                                  });
                                  createTrip(
                                      username: username,
                                      photo_url: photoUrl,
                                      categories: categories,
                                      translated_description: td,
                                      uid: user.uid,
                                      fsq_id: fsq_id,
                                      participate_id: participate,
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

  void kill_links() {
    links = [];
  }
}
