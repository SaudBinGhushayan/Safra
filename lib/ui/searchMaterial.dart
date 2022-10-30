import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:safra/backend/snackBar.dart';
import 'package:safra/objects/Places.dart';
import 'package:safra/objects/Trips.dart';
import 'package:safra/objects/TripsInfo.dart';
import 'package:safra/objects/comments.dart';
import 'package:safra/ui/createTrip.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class searchMaterial extends StatefulWidget {
  const searchMaterial({Key? key, required this.places, required this.td})
      : super(key: key);
  final Places? places;
  final String td;

  @override
  State<searchMaterial> createState() => _searchMaterialState();
}

class _searchMaterialState extends State<searchMaterial> {
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
  String participate = '${(Random().nextDouble() * 256).toStringAsFixed(4)}';
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
  List<String> uids = [];
  var isloaded = false;
  String tripid = '';
  String trip_id = '${(Random().nextDouble() * 256).toStringAsFixed(4)}';
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
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: [
        //========================================================= start here =======================================================================
        Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(left: 30)),
        Container(
            padding: const EdgeInsets.only(top: 20),
            color: Color.fromARGB(31, 254, 254, 255).withOpacity(0.8),
            child: Container(
                alignment: Alignment.centerLeft,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // abdullah changed this
                      // const SizedBox(
                      //     height: 10),
                      const Padding(padding: EdgeInsets.only(left: 30)),

                      // this line was added by abdullah
                      SizedBox(
                        height: 5,
                      ),

                      SizedBox(
                          height: 300,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: links.length,
                              itemBuilder: ((context, index) {
                                return Row(children: [
                                  Center(
                                      child: Container(
                                    width: 300,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(links[index]),
                                          fit: BoxFit.cover),
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
                        decoration: BoxDecoration(
                          border: Border.all(
                              style: BorderStyle.solid,
                              color: Color.fromARGB(255, 214, 214, 224)),
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  gradient: RadialGradient(
                                    colors: [
                                      Colors.white,
                                      Colors.white12,
                                    ],
                                    radius: 0.75,
                                    focal: Alignment(0.7, -0.7),
                                    tileMode: TileMode.clamp,
                                  ),
                                  border: Border.all(
                                      style: BorderStyle.solid,
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      topLeft: Radius.circular(20)),
                                  // image: DecorationImage(fit: BoxFit.fill, image: AssetImage('images/BackgroundPics/WhiteBackground.jpg'), colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.9), BlendMode.modulate))
                                ),
                                width: 200,
                                height: 150,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 25),
                                    GradientText(
                                      '${widget.places!.name}',
                                      colors: [
                                        Colors.black,
                                        Colors.black,
                                        Colors.black
                                      ],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize:
                                              widget.places!.name.length > 10
                                                  ? 15
                                                  : 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Text(
                                      '${widget.places!.region},  ${widget.places!.country} ',
                                      style: TextStyle(
                                          fontSize:
                                              widget.places!.region.length > 12
                                                  ? 15
                                                  : 25,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                )),
                            Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Colors.white12,
                                      Colors.white,
                                    ],
                                  ),
                                  border: Border.all(
                                      style: BorderStyle.solid,
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      bottomRight: Radius.circular(20)),
                                  // image: DecorationImage(fit: BoxFit.fill, image: AssetImage('images/BackgroundPics/WhiteBackground.jpg'), colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.9), BlendMode.modulate))
                                ),
                                width: 209,
                                height: 150,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 25),
                                    Text(
                                      'Rating:',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                        '${widget.places!.rating}' == 'Not Available'
                                            ? ' '
                                            : '${widget.places!.rating}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: widget.places!.rating ==
                                                    'Not Available'
                                                ? Colors.white
                                                : double.parse(widget.places!.rating) >
                                                        8
                                                    ? Colors.green
                                                    : double.parse(widget
                                                                    .places!
                                                                    .rating) <
                                                                8 &&
                                                            double.parse(widget
                                                                    .places!
                                                                    .rating) >
                                                                6
                                                        ? Color.fromARGB(
                                                            255, 164, 160, 24)
                                                        : double.parse(widget
                                                                    .places!
                                                                    .rating) <
                                                                6
                                                            ? Colors.red
                                                            : Colors.red)),
                                    SizedBox(height: 25),
                                    Text(
                                      '${widget.places!.price == '1.0' ? '\$' : widget.places!.price == '2.0' ? '\$\$' : widget.places!.price == '3.0' ? '\$\$\$' : widget.places!.price == '4.0' ? '\$\$\$\$' : widget.places!.price == 'Not Available' ? ' ' : ''}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: widget.places!.price == '1.0'
                                              ? Color.fromARGB(255, 67, 164, 70)
                                              : widget.places!.price == '2.0'
                                                  ? Color.fromARGB(
                                                      255, 91, 117, 29)
                                                  : widget.places!.price ==
                                                          '3.0'
                                                      ? Colors.orange
                                                      : widget.places!.price ==
                                                              '4.0'
                                                          ? Colors.red
                                                          : widget.places!
                                                                      .price ==
                                                                  'Not Available'
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
                          padding: EdgeInsets.only(
                            left: 3,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                                style: BorderStyle.solid,
                                color: Color.fromARGB(255, 214, 214, 224)),
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
                          height: 700,

                          // this row is for the top to containers for name , location, ratings and money
                          child: Column(
                            // mainAxisAlignment:
                            //     MainAxisAlignment
                            //         .start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'About:',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                widget.places!.description,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
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
                                    fontSize: 10,
                                    fontStyle: FontStyle.italic,
                                    decoration: TextDecoration.underline,
                                    color: Colors.black),
                              ),
                              Text(
                                td == 'Not Available' ? '' : td,
                                // places[index]
                                //     .translated_description,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),

                              SizedBox(
                                height: 25,
                              ),

                              Container(
                                alignment: Alignment.center,
                                width: 350,
                                height: 100,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(style: BorderStyle.solid),
                                    borderRadius: BorderRadius.all(
                                      Radius.elliptical(200, 300),
                                    ),
                                    color: Colors.white38),
                                child: GradientText(
                                    widget.places!.categories
                                        .replaceAll(RegExp(','), ',\t'),
                                    textAlign: TextAlign.center,
                                    colors: [
                                      Colors.black87,
                                      Colors.purple,
                                      Colors.blue
                                    ],
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'More info:',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Telephone: ${widget.places!.tel}',
                                  style: const TextStyle(fontSize: 16)),

                              SizedBox(
                                height: 10,
                              ),
                              Text('Open Hours: 7:00 to 20:00',
                                  style: const TextStyle(fontSize: 16)),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Full address: ---- , -- ,-------',
                                  style: const TextStyle(fontSize: 16)),
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
                      const SizedBox(height: 15),

                      // HERE WILL BE LOCATION OF PLACE .. MUST MODIFY API FEATURES
                      // Text(
                      //   ''
                      // ),

                      const SizedBox(height: 20),
                    ]))),

        const SizedBox(height: 40),
        SizedBox(
          height: 200,
          child: FutureBuilder<List<TripsInfo>?>(
            future: TripsInfo.readTrips_Info(user.uid),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('something went wrong');
              } else if (snapshot.data?.length == 0) {
                noTrips = true;
                return Text('no trips registerd');
              } else if (snapshot.hasData) {
                List<TripsInfo> data = snapshot.data!;
                return SizedBox(
                    height: 200,
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Container(
                            margin: EdgeInsets.fromLTRB(20, 0, 20, 4),
                            alignment: Alignment.centerLeft,
                            child: Row(children: [
                              Expanded(
                                  child: Text(data[index].trip_name,
                                      style: TextStyle(fontSize: 21))),
                              SizedBox(width: 20),
                              Expanded(
                                  child: Text(
                                      '${data[index].from.year}/${data[index].from.month}/${data[index].from.day}'
                                          .toString(),
                                      style: TextStyle(fontSize: 18))),
                              SizedBox(width: 10),
                              Expanded(
                                  child: Text(
                                      '${data[index].to.year}/${data[index].to.month}/${data[index].to.day}',
                                      style: TextStyle(fontSize: 18))),
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
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
        //// comment code =========================================================
        SizedBox(
          height: 200,
          child: FutureBuilder<List<Comments>?>(
            future: Comments.readComments(widget.places!.fsq_id),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('something went wrong');
              } else if (snapshot.data?.length == 0) {
                return Text('no comments');
              } else if (snapshot.hasData) {
                List<Comments> comments = snapshot.data!;
                return SizedBox(
                    height: 200,
                    child: ListView.builder(
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        return Container(
                            margin: EdgeInsets.fromLTRB(20, 0, 20, 4),
                            alignment: Alignment.centerLeft,
                            child: Row(children: [
                              Expanded(
                                  child: Text(comments[index].comment,
                                      style: TextStyle(fontSize: 21))),
                              SizedBox(width: 20),
                              Text(comments[index].likes.toString(),
                                  style: TextStyle(fontSize: 18)),
                              IconButton(
                                  onPressed: () async {
                                    final interaction =
                                        await Comments.increment_likes(
                                            comments[index].comment_id,
                                            comments[index].likes);
                                    if (interaction) {
                                      snackBar.showSnackBarGreen(
                                          'Comment added successfully');
                                    } else {
                                      snackBar.showSnackBarRed(
                                          'Something went wrong');
                                    }
                                  },
                                  icon: Icon(Icons.thumb_up)),
                              SizedBox(width: 10),
                              Text(comments[index].dislikes.toString(),
                                  style: TextStyle(fontSize: 18)),
                              IconButton(
                                  onPressed: () async {
                                    final interaction =
                                        await Comments.increment_dislikes(
                                            comments[index].comment_id,
                                            comments[index].dislikes);
                                    if (interaction) {
                                      snackBar.showSnackBarGreen(
                                          'disliked successfully');
                                    } else {
                                      snackBar.showSnackBarRed(
                                          'Something went wrong');
                                    }
                                  },
                                  icon: Icon(Icons.thumb_down)),
                            ]));
                      },
                    ));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),

        // / comment button
        TextField(
            controller: comment,
            style: const TextStyle(),
            decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(40),
                  ),
                ),
                hintText: 'add a comment',
                hintStyle: const TextStyle(color: Colors.grey))),
        ElevatedButton.icon(
          onPressed: () async {
            if (comment.text.isEmpty) {
              snackBar.showSnackBarRed(
                  'No entered comment, please enter a comment');
            } else {
              addComment(
                  uid: user.uid,
                  comment_id: (Random().nextDouble() * 265).toString(),
                  fsq_id: widget.places!.fsq_id,
                  comment: comment.text,
                  likes: 0,
                  dislikes: 0);
              snackBar.showSnackBarGreen("Comment added successfully");
            }
          },
          icon: const Icon(Icons.check_box),
          label: const Text('add comment'),
        ),
        ElevatedButton.icon(
          onPressed: () async {
            final userHasTrips = await TripsInfo.userHasTrip(user.uid);
            if (userHasTrips) {
              active = "false";
            }

            setState(() {
              fsq_id = fsq_id;

              name = widget.places!.name;

              rating = widget.places!.rating;

              tel = widget.places!.tel;

              country = widget.places!.country;

              region = widget.places!.region;

              price = widget.places!.price;

              description = widget.places!.description;
              translated_description = td;
              categories = widget.places!.categories;
              photoUrl = widget.places!.photo_url;
            });

            final tripExist = await Trips.availableTrip(user.uid);
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
                  trip_id: tripid,
                  trip_name: trip_name);

              snackBar.showSnackBarGreen(
                  'Activity Added to trip ${trip_name} Successfully');

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
              name = widget.places!.name;

              rating = widget.places!.rating;

              tel = widget.places!.tel;

              country = widget.places!.country;

              region = widget.places!.region;

              price = widget.places!.price;

              description = widget.places!.description;
              translated_description = td;
              categories = widget.places!.categories;
              photoUrl = widget.places!.photo_url;
            });
            if (!pressed_create && !noTrips) {
              pressed_create = true;
              snackBar.showSnackBarYellow(
                  'You have registered trips if you want to create a new trip press create again');
            } else {
              var route = new MaterialPageRoute(
                  builder: (context) =>
                      new createTripUI(places: widget.places!, td: widget.td));
              Navigator.of(context).push(route);
            }
          },
          icon: const Icon(Icons.check_box),
          label: const Text('create trip'),
        ),
      ]),
    ));
  }

  void add_links(String link) {
    List<String> templink = link.split(',');
    links.addAll(templink);
  }

  void kill_links() {
    links = [];
  }

  void kill_prices() {
    min_price = '0';
    max_price = '5';
  }

  void kill_sortby() {
    sortType = 'Relevance';
  }
}
