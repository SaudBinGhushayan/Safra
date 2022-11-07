import 'dart:math';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:safra/backend/snackBar.dart';
import 'package:safra/backend/supabase.dart';
import 'package:safra/objects/Trips.dart';
import 'package:safra/objects/TripsInfo.dart';
import 'package:safra/objects/comment_for_trips.dart';
import 'package:safra/objects/comments.dart';
import 'package:safra/objects/participate.dart';
import 'package:safra/objects/user.dart';
import 'package:safra/ui/searchtrip.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class cloneTrip extends StatefulWidget {
  cloneTrip({Key? key, required this.trips}) : super(key: key);
  Map<String, dynamic> trips;

  @override
  State<cloneTrip> createState() => _cloneTripState();
}

class _cloneTripState extends State<cloneTrip> {
  final user = FirebaseAuth.instance.currentUser!;
  final comment = TextEditingController();
  String username = '';
  String gen_trip_id = (Random().nextDouble() * 256).toStringAsFixed(4);
  List<String> links = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('images/BackgroundPics/AltBackground.jpg'),
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
                    return Text('');
                  } else {
                    return Text('');
                  }
                }),
            Row(
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 25, bottom: 10),
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const searchtrip()));
                        })),
                SizedBox(width: 120),
                IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => super.widget));
                    },
                    icon: Icon(Icons.replay_outlined, color: Colors.black)),
                SizedBox(width: 35),
                ElevatedButton(
                    onPressed: () async {
                      add_links(widget.trips['photo_url']);

                      final valid = await Participate.validUserForTrip(
                          user.uid, widget.trips['trip_id']);
                      if (!valid) {
                        final trips_Info = TripsInfo(
                            photo_url: links[0],
                            tripId: gen_trip_id,
                            active: 'false',
                            country: widget.trips['country'],
                            uid: user.uid,
                            from: DateTime.tryParse(widget.trips['from'])!,
                            to: DateTime.tryParse(widget.trips['to'])!,
                            trip_name:
                                '${widget.trips['trip_name']} Cloned by ${username}');

                        final participate = Participate(
                          participate_id:
                              (Random().nextDouble() * 256).toStringAsFixed(4),
                          username: username,
                          tripId: gen_trip_id,
                          active: 'false',
                          uid: user.uid,
                        );
                        await SupaBase_Manager()
                            .client
                            .from('trips_info')
                            .insert([trips_Info.toJson()]).execute();
                        await SupaBase_Manager()
                            .client
                            .from('participate')
                            .insert([participate.toJson()]).execute();

                        return snackBar
                            .showSnackBarGreen('Trip added successfully');
                      } else {
                        return snackBar.showSnackBarRed(
                            'this trip is registered in your account');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        textStyle: const TextStyle(fontSize: 20),
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5)),
                    child: Row(
                      children: const [
                        Icon(Icons.add,
                            color: Color.fromARGB(255, 255, 245, 245),
                            size: 20),
                        SizedBox(width: 5),
                        Text("Clone Trip"),
                      ],
                    ))
              ],
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 250, 5),
              child: Text(widget.trips['trip_name'],
                  style: const TextStyle(fontSize: 30)),
            ),
            Row(children: [
              FutureBuilder<List<Participate>?>(
                  future: Participate.readParticipants(widget.trips['trip_id']),
                  builder: (context, snapshot) {
                    if (snapshot.data?.length == 0) {
                      return const Text('No data');
                    } else if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    } else if (snapshot.hasData) {
                      final participate = snapshot.data!;
                      return Container(
                        padding: const EdgeInsets.fromLTRB(10, 3, 20, 5),
                        child: Row(
                          children: [
                            const Icon(Icons.person,
                                color: Color.fromARGB(255, 79, 101, 116),
                                size: 30),
                            Text(participate.length.toString(),
                                style: const TextStyle(fontSize: 19)),
                          ],
                        ),
                      );
                    } else {
                      return const Center(
                          child: const CircularProgressIndicator());
                    }
                  }),
              const SizedBox(width: 3),
              StreamBuilder<List<Map<String, dynamic>>>(
                  stream: SupaBase_Manager()
                      .client
                      .from('trips_likes:trip_id=eq.${widget.trips['trip_id']}')
                      .stream(['like_id']).execute(),
                  builder: (context, snapshot) {
                    if (snapshot.data?.length == 0) {
                      final likes = snapshot.data!;
                      return Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.favorite,
                                color: Colors.redAccent, size: 30),
                            onPressed: () async {
                              await SupaBase_Manager()
                                  .client
                                  .from('trips_likes')
                                  .insert({
                                'like_id': (Random().nextDouble() * 265)
                                    .toStringAsFixed(4)
                                    .toString(),
                                'trip_id': widget.trips['trip_id'],
                                'like': 1,
                                'uid': user.uid
                              }).execute();
                            },
                          ),
                          Text('0', style: TextStyle(fontSize: 19)),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    } else if (snapshot.hasData) {
                      final likes = snapshot.data![0];
                      return Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.favorite,
                                color: Colors.redAccent, size: 30),
                            onPressed: () async {
                              await SupaBase_Manager()
                                  .client
                                  .from('trips_likes')
                                  .insert({
                                'like_id': (Random().nextDouble() * 256)
                                    .toStringAsFixed(4)
                                    .toString(),
                                'trip_id': widget.trips['trip_id'],
                                'like': 1,
                                'uid': user.uid
                              }).execute();
                            },
                          ),
                          Text(snapshot.data!.length.toString(),
                              style: TextStyle(fontSize: 19)),
                          SizedBox(width: 5),
                          Text(
                              likes['uid'] == user.uid &&
                                      likes['trip_id'] ==
                                          widget.trips['trip_id']
                                  ? 'You Liked This Trip!'
                                  : '',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 245, 100, 90))),
                        ],
                      );
                    } else {
                      return const Center(
                          child: const CircularProgressIndicator());
                    }
                  }),
            ]),
            SizedBox(
              height: 430,
              child: FutureBuilder<List<Trips>?>(
                future: Trips.readCloneTrips(widget.trips['trip_id']),
                builder: (context, snapshot) {
                  if (snapshot.data?.length == 0) {
                    return const Center(child: Text('No data'));
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Something went wrong'));
                  } else if (snapshot.hasData) {
                    final activities = snapshot.data!;
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: activities.length,
                        itemBuilder: ((context, index) {
                          return GestureDetector(
                            onTap: () {
                              var route = new MaterialPageRoute(
                                  builder: (context) => new onTabActivityClone(
                                        activity: activities[index],
                                      ));
                              Navigator.of(context).push(route);
                            },
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(
                                              (Random().nextDouble() * 0xFFFFFF)
                                                  .toInt())
                                          .withOpacity(.3),
                                      spreadRadius: 5,
                                      blurRadius: 1,
                                      offset: const Offset(0, 3)),
                                ],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ListTile(
                                title: Text(
                                  activities[index].name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 19,
                                      color: Color.fromARGB(255, 79, 101, 116)),
                                ),
                                subtitle: Text(
                                  activities[index].country,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 19,
                                      color: Color.fromARGB(255, 79, 101, 116)),
                                ),
                                leading: const Icon(Icons.store_mall_directory,
                                    size: 40,
                                    color: Color.fromARGB(255, 79, 101, 116)),
                                trailing: IconButton(
                                  onPressed: () async {
                                    final valid = await Trips.canAddTrip(
                                        user.uid, activities[index].name);
                                    if (valid) {
                                      final trips = Trips(
                                          activity_date:
                                              DateTime.parse('2020-01-12'),
                                          uid: user.uid,
                                          fsq_id: (Random().nextDouble() * 256)
                                              .toStringAsFixed(4),
                                          photo_url:
                                              activities[index].photo_url,
                                          categories:
                                              activities[index].categories,
                                          translated_description:
                                              activities[index]
                                                  .translated_description,
                                          name: activities[index].name,
                                          rating: activities[index].rating,
                                          tel: activities[index].tel,
                                          country: activities[index].country,
                                          region: activities[index].region,
                                          price: activities[index].price,
                                          description:
                                              activities[index].description,
                                          trip_name:
                                              activities[index].trip_name,
                                          trip_id: gen_trip_id);
                                      await SupaBase_Manager()
                                          .client
                                          .from('activities')
                                          .insert([trips.toJson()]).execute();
                                      return snackBar.showSnackBarGreen(
                                          'Activity added successfully added successfully');
                                    } else {
                                      return snackBar.showSnackBarRed(
                                          'this activity is registered on this trip');
                                    }
                                  },
                                  icon: Icon(
                                    Icons.add,
                                    color: Colors.green,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }));
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            SizedBox(
              height: 170,
              child: FutureBuilder<List<CommentForTrips>?>(
                future: CommentForTrips.readComments(widget.trips['trip_id']),
                builder: (context, snapshot) {
                  if (snapshot.data?.length == 0) {
                    return const Center(child: Text('No data'));
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Something went wrong'));
                  } else if (snapshot.hasData) {
                    final comments = snapshot.data!;
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: comments.length,
                        itemBuilder: ((context, index) {
                          return Container(
                            margin: const EdgeInsets.fromLTRB(3, 0, 0, 3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              title: Text(
                                comments[index].username,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 19,
                                    color: Color.fromARGB(255, 79, 101, 116)),
                              ),
                              subtitle: Text(
                                comments[index].comment,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 19,
                                    color: Color.fromARGB(255, 79, 101, 116)),
                              ),
                              leading: const Icon(Icons.person,
                                  size: 40,
                                  color: Color.fromARGB(255, 79, 101, 116)),
                              trailing: TextButton.icon(
                                  onPressed: () async {
                                    final interaction =
                                        await CommentForTrips.increment_likes(
                                            comments[index].trip_comment_id,
                                            comments[index].likes);
                                    if (interaction) {
                                      snackBar.showSnackBarGreen(
                                          'liked successfully');
                                    } else {
                                      snackBar.showSnackBarRed(
                                          'Something went wrong');
                                    }
                                  },
                                  icon:
                                      Icon(Icons.thumb_up, color: Colors.blue),
                                  label:
                                      Text(comments[index].likes.toString())),
                            ),
                          );
                        }));
                  } else {
                    return Text('');
                  }
                },
              ),
            ),
            TextFormField(
                controller: comment,
                decoration: InputDecoration(
                    icon: Icon(Icons.comment, size: 20),
                    suffixIcon: IconButton(
                        icon: const Icon(Icons.check,
                            size: 30, color: Colors.green),
                        onPressed: () async {
                          final added = await CommentForTrips.addCommentInTrips(
                              trip_comment_id: (Random().nextDouble() * 256)
                                  .toStringAsFixed(4),
                              trip_id: widget.trips['trip_id'],
                              username: username,
                              comment: comment.text,
                              likes: 0,
                              dislikes: 0);
                          if (added) {
                            snackBar.showSnackBarGreen(
                                "Comment added successfully");
                          } else {
                            snackBar.showSnackBarRed(
                                "you already commented on this trip");
                          }
                        }),
                    hintText: 'Say Something...',
                    hintStyle: const TextStyle(color: Colors.grey),
                    labelText: "Say Something...",
                    labelStyle: const TextStyle(color: Colors.grey))),
          ],
        ),
      ),
    ));
  }

  void add_links(String link) {
    List<String> templink = link.split(',');
    links.addAll(templink);
  }
}

class onTabActivityClone extends StatefulWidget {
  const onTabActivityClone({Key? key, required this.activity})
      : super(key: key);
  final activity;
  @override
  State<onTabActivityClone> createState() => _onTabActivityCloneState();
}

class _onTabActivityCloneState extends State<onTabActivityClone> {
  List<String> links = [];
  String td = '';

  @override
  Widget build(BuildContext context) {
    add_links(widget.activity.photo_url);
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
                                    width: 400,
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
                                    colors: const [
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
                                      '${widget.activity.name}',
                                      colors: const [
                                        Colors.black,
                                        Colors.black,
                                        Colors.black
                                      ],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize:
                                              widget.activity.name.length > 10
                                                  ? 15
                                                  : 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Text(
                                      '${widget.activity.region},  ${widget.activity.country} ',
                                      style: TextStyle(
                                          fontSize:
                                              widget.activity.region.length > 12
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
                                    colors: const [
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
                                        '${widget.activity.rating}' == 'Not Available'
                                            ? ' '
                                            : '${widget.activity.rating}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: widget.activity.rating ==
                                                    'Not Available'
                                                ? Colors.white
                                                : double.parse(widget.activity.rating) >
                                                        8
                                                    ? Colors.green
                                                    : double.parse(widget
                                                                    .activity
                                                                    .rating) <
                                                                8 &&
                                                            double.parse(widget
                                                                    .activity
                                                                    .rating) >
                                                                6
                                                        ? Color.fromARGB(
                                                            255, 164, 160, 24)
                                                        : double.parse(widget
                                                                    .activity
                                                                    .rating) <
                                                                6
                                                            ? Colors.red
                                                            : Colors.red)),
                                    SizedBox(height: 25),
                                    Text(
                                      '${widget.activity.price == '1.0' ? '\$' : widget.activity.price == '2.0' ? '\$\$' : widget.activity.price == '3.0' ? '\$\$\$' : widget.activity.price == '4.0' ? '\$\$\$\$' : widget.activity.price == 'Not Available' ? ' ' : ''}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: widget.activity.price == '1.0'
                                              ? Color.fromARGB(255, 67, 164, 70)
                                              : widget.activity.price == '2.0'
                                                  ? Color.fromARGB(
                                                      255, 91, 117, 29)
                                                  : widget.activity.price ==
                                                          '3.0'
                                                      ? Colors.orange
                                                      : widget.activity.price ==
                                                              '4.0'
                                                          ? Colors.red
                                                          : widget.activity
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
                                widget.activity.description,
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
                                    widget.activity.categories
                                        .replaceAll(RegExp(','), ',\t'),
                                    textAlign: TextAlign.center,
                                    colors: const [
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
                              Text('Telephone: ${widget.activity.tel}',
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
                    ]))),

        //// comment code =========================================================
        SizedBox(
          height: 200,
          child: FutureBuilder<List<Comments>?>(
            future: Comments.readComments(widget.activity.fsq_id),
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
      ]),
    ));
  }

  void kill_links() {
    links = [];
  }

  void add_links(String link) {
    List<String> templink = link.split(',');
    links.addAll(templink);
  }
}
