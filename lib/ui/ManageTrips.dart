import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:safra/Panels%20&%20Dialogs/TabWidget2Alt.dart';
import 'package:safra/Panels%20&%20Dialogs/TabWidgetAlt.dart';
import 'package:safra/backend/snackBar.dart';
import 'package:safra/backend/storage.dart';
import 'package:safra/backend/supabase.dart';
import 'package:safra/objects/Trips.dart';
import 'package:safra/objects/TripsInfo.dart';
import 'package:safra/objects/displayAllTrips.dart';
import 'package:safra/objects/participate.dart';
import 'package:safra/objects/user.dart';
import 'package:safra/ui/ContactUs.dart';
import 'package:safra/ui/FAQ.dart';
import 'package:safra/ui/ManageActivities.dart';
import 'package:safra/ui/ManageTrips.dart';
import 'package:safra/ui/accountInformation.dart';
import 'package:safra/ui/dashboardn.dart';
import 'package:safra/ui/search.dart';
import 'package:safra/ui/stngs.dart';
import 'package:safra/ui/homePage.dart';
import 'package:safra/ui/schedule1.dart';
import 'package:safra/ui/stngs.dart';
import 'package:safra/ui/mention.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:timelines/timelines.dart';

class ManageTrips extends StatefulWidget {
  const ManageTrips({Key? key}) : super(key: key);

  @override
  State<ManageTrips> createState() => _ManageTripsState();
}

class _ManageTripsState extends State<ManageTrips> {
  final user = FirebaseAuth.instance.currentUser!;
  List<String> trip_ids = [];
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
                      SizedBox(height: 10),
                      Row(children: [
                        Container(
                            alignment: Alignment.topLeft,
                            child: IconButton(
                                icon: const Icon(Icons.arrow_back_ios,
                                    color: Colors.white),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const dashboardn()));
                                })),
                        SizedBox(width: 120),
                        IconButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          super.widget));
                            },
                            icon: Icon(Icons.replay_outlined,
                                color: Colors.white)),
                        Container(
                          //profile icon
                          height: 50,
                          width: 140,
                          margin: const EdgeInsets.fromLTRB(50, 19, 1, 1),
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
                      ]),
                      SizedBox(height: 30),
                      Row(
                        //2ndrow
                        children: [
                          Container(
                              //Your next activity
                              margin: const EdgeInsets.only(left: 30, top: 170),
                              child: Row(children: const [
                                Text(
                                  'Your Registered Trips',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 19,
                                  ),
                                ),
                                SizedBox(width: 100),
                              ])),
                        ],
                      ),
                      SizedBox(height: 5),
                      SizedBox(
                          height: 250,
                          child: FutureBuilder<List<TripsInfo>?>(
                              future: TripsInfo.readTrips_Info_InManageTrips(
                                  user.uid),
                              builder: (context, snapshot) {
                                if (snapshot.data?.length == 0) {
                                  return Center(child: Text('No data'));
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
                                            trip_ids.add(trips[index].tripId);
                                            return Row(children: [
                                              GestureDetector(
                                                onTap: () {
                                                  var route =
                                                      new MaterialPageRoute(
                                                          builder: (context) =>
                                                              new onTapActivity(
                                                                trip_id:
                                                                    trips[index]
                                                                        .tripId,
                                                                trip_name: trips[
                                                                        index]
                                                                    .trip_name,
                                                              ));
                                                  Navigator.of(context)
                                                      .push(route);
                                                },
                                                child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: 10, right: 10),
                                                    width: 250,
                                                    decoration: BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.3),
                                                            spreadRadius: 5,
                                                            blurRadius: 5,
                                                            offset:
                                                                Offset(0, 3)),
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                    child: Column(children: [
                                                      SizedBox(
                                                        height: 150,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                          child: Image.network(
                                                            trips[index]
                                                                .photo_url,
                                                            fit: BoxFit.cover,
                                                            width: 300,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 5),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: Container(
                                                                margin: EdgeInsets.only(
                                                                    left: 10,
                                                                    right: 20),
                                                                padding: EdgeInsets.fromLTRB(
                                                                    3, 3, 0, 3),
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8),
                                                                    color: Colors
                                                                        .blue
                                                                        .withOpacity(
                                                                            0.3)),
                                                                child: Text(
                                                                    trips[index]
                                                                        .trip_name,
                                                                    overflow:
                                                                        TextOverflow.ellipsis,
                                                                    maxLines: 2,
                                                                    style: TextStyle(fontSize: 19))),
                                                          ),
                                                          Container(
                                                              padding: EdgeInsets
                                                                  .fromLTRB(
                                                                      3,
                                                                      12,
                                                                      3,
                                                                      12),
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                  color: Colors
                                                                      .blue
                                                                      .withOpacity(
                                                                          0.3)),
                                                              child: Text(
                                                                  '${DateFormat("MMM").format(trips[index].from)}${trips[index].from.day} - ${DateFormat("MMM").format(trips[index].to)}${trips[index].to.day}',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          19))),
                                                        ],
                                                      ),
                                                      Row(children: [
                                                        FutureBuilder<
                                                                List<
                                                                    Participate>?>(
                                                            future: Participate
                                                                .readParticipants(
                                                                    trips[index]
                                                                        .tripId),
                                                            builder: (context,
                                                                snapshot) {
                                                              if (snapshot.data
                                                                      ?.length ==
                                                                  0) {
                                                                return const Text(
                                                                    'No data');
                                                              } else if (snapshot
                                                                  .hasError) {
                                                                return const Text(
                                                                    'Something went wrong');
                                                              } else if (snapshot
                                                                  .hasData) {
                                                                final participate =
                                                                    snapshot
                                                                        .data!;
                                                                return Row(
                                                                  children: [
                                                                    Icon(
                                                                        Icons
                                                                            .person,
                                                                        color: Colors
                                                                            .blue
                                                                            .withOpacity(
                                                                                0.3),
                                                                        size:
                                                                            30),
                                                                    Text(
                                                                        participate
                                                                            .length
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                19)),
                                                                  ],
                                                                );
                                                              } else {
                                                                return const Center(
                                                                    child:
                                                                        const CircularProgressIndicator());
                                                              }
                                                            }),
                                                        Expanded(
                                                          child: Container(
                                                              margin: EdgeInsets.fromLTRB(
                                                                  100, 0, 0, 0),
                                                              padding:
                                                                  EdgeInsets.all(
                                                                      3),
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          8),
                                                                  color: trips[index].active == 'true'
                                                                      ? Colors.green
                                                                          .withOpacity(
                                                                              0.3)
                                                                      : Colors.red.withOpacity(0.3).withOpacity(
                                                                          0.3)),
                                                              child: Text(
                                                                  trips[index].active.toString() == 'true' ? 'Active' : 'Not Active',
                                                                  maxLines: 2,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: TextStyle(fontSize: 19))),
                                                        )
                                                      ]),
                                                    ])),
                                              ),
                                            ]);
                                          })));
                                } else {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                              })),
                      SizedBox(height: 10),
                      Container(
                          //Your next activity
                          margin: const EdgeInsets.only(left: 30),
                          child: Row(children: const [
                            Text(
                              'Trips Participated in',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 19,
                              ),
                            ),
                            SizedBox(width: 100),
                          ])),
                      SizedBox(
                          height: 250,
                          child: FutureBuilder<List<DisplayTripsInfo>?>(
                              future:
                                  DisplayTripsInfo.registeredTripsforMembers(
                                      user.uid),
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
                                            if (!trip_ids.contains(trips[index]
                                                .tripsInfo[0]
                                                .tripId)) {
                                              return Row(children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    var route = new MaterialPageRoute(
                                                        builder: (context) =>
                                                            new onTapActivity(
                                                                trip_id: trips[
                                                                        index]
                                                                    .tripsInfo[
                                                                        0]
                                                                    .tripId,
                                                                trip_name: trips[
                                                                        index]
                                                                    .tripsInfo[
                                                                        0]
                                                                    .trip_name));
                                                    Navigator.of(context)
                                                        .push(route);
                                                  },
                                                  child: Container(
                                                      margin: EdgeInsets.only(
                                                          left: 10, right: 10),
                                                      width: 250,
                                                      decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.3),
                                                              spreadRadius: 5,
                                                              blurRadius: 5,
                                                              offset:
                                                                  Offset(0, 3)),
                                                        ],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                      ),
                                                      child: Column(children: [
                                                        SizedBox(
                                                          height: 150,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                            child:
                                                                Image.network(
                                                              trips[index]
                                                                  .tripsInfo[0]
                                                                  .photo_url,
                                                              fit: BoxFit.cover,
                                                              width: 300,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(height: 5),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: Container(
                                                                  margin: EdgeInsets.only(
                                                                      left: 10,
                                                                      right:
                                                                          20),
                                                                  padding:
                                                                      EdgeInsets.fromLTRB(
                                                                          3, 3, 0, 3),
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                      color: Colors
                                                                          .blue
                                                                          .withOpacity(
                                                                              0.3)),
                                                                  child: Text(
                                                                      trips[index]
                                                                          .tripsInfo[0]
                                                                          .trip_name,
                                                                      overflow: TextOverflow.ellipsis,
                                                                      maxLines: 2,
                                                                      style: TextStyle(fontSize: 19))),
                                                            ),
                                                            Container(
                                                                padding:
                                                                    EdgeInsets.all(
                                                                        3),
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                8),
                                                                    color: Colors
                                                                        .blue
                                                                        .withOpacity(
                                                                            0.3)),
                                                                child: Text(
                                                                    '${DateFormat("MMM").format(trips[index].tripsInfo[0].from)}${trips[index].tripsInfo[0].from.day} - ${DateFormat("MMM").format(trips[index].tripsInfo[0].to)}${trips[index].tripsInfo[0].to.day}',
                                                                    maxLines: 2,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            19))),
                                                          ],
                                                        ),
                                                        Row(children: [
                                                          FutureBuilder<
                                                                  List<
                                                                      Participate>?>(
                                                              future: Participate
                                                                  .readParticipants(trips[
                                                                          index]
                                                                      .tripsInfo[
                                                                          0]
                                                                      .tripId),
                                                              builder: (context,
                                                                  snapshot) {
                                                                if (snapshot
                                                                        .data
                                                                        ?.length ==
                                                                    0) {
                                                                  return const Text(
                                                                      'No data');
                                                                } else if (snapshot
                                                                    .hasError) {
                                                                  return const Text(
                                                                      'Something went wrong');
                                                                } else if (snapshot
                                                                    .hasData) {
                                                                  final participate =
                                                                      snapshot
                                                                          .data!;
                                                                  return Row(
                                                                    children: [
                                                                      Icon(Icons.person,
                                                                          color: Colors
                                                                              .blue
                                                                              .withOpacity(0.3),
                                                                          size: 30),
                                                                      Text(
                                                                          participate
                                                                              .length
                                                                              .toString(),
                                                                          style:
                                                                              TextStyle(fontSize: 19)),
                                                                    ],
                                                                  );
                                                                } else {
                                                                  return const Center(
                                                                      child:
                                                                          const CircularProgressIndicator());
                                                                }
                                                              }),
                                                          Expanded(
                                                            child: Container(
                                                                margin: EdgeInsets.fromLTRB(
                                                                    100, 0, 0, 0),
                                                                padding:
                                                                    EdgeInsets.all(
                                                                        3),
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8),
                                                                    color: trips[index].tripsInfo[0].active == 'true'
                                                                        ? Colors.green.withOpacity(
                                                                            0.3)
                                                                        : Colors.red.withOpacity(0.3).withOpacity(
                                                                            0.3)),
                                                                child: Text(
                                                                    trips[index].tripsInfo[0].active.toString() == 'true' ? 'Active' : 'Not Active',
                                                                    style: TextStyle(fontSize: 19))),
                                                          )
                                                        ]),
                                                      ])),
                                                ),
                                              ]);
                                            } else {
                                              return Container();
                                            }
                                          })));
                                } else {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                              })),
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
}

class onTapActivity extends StatefulWidget {
  const onTapActivity(
      {Key? key, required this.trip_id, required this.trip_name})
      : super(key: key);
  final String trip_id;
  final String trip_name;

  @override
  State<onTapActivity> createState() => _onTapActivityState();
}

class _onTapActivityState extends State<onTapActivity> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry radius = const BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: const Radius.circular(24.0),
    );

    return Scaffold(
      body: SlidingUpPanel(
        maxHeight: 600,
        panelBuilder: (scrollController) =>
            buildSlidingPanel(scrollController: scrollController),
        collapsed: Container(
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 0, 85, 155),
              borderRadius: radius),
          child: const Center(
            child: Text(
              "View your trip info",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        body: Container(
            //////1st column
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('images/BackgroundPics/background.png'),
              fit: BoxFit.cover,
            )),
            child: Column(children: [
              SizedBox(height: 20),
              Row(
                children: [
                  Container(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ManageTrips()));
                          })),
                  SizedBox(width: 50),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12)),
                      margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: ElevatedButton(
                          onPressed: () async {
                            await SupaBase_Manager()
                                .client
                                .from('participate')
                                .delete()
                                .match({'trip_id': widget.trip_id}).match(
                                    {'uid': user.uid}).execute();

                            snackBar.showSnackBarGreen('You Left this trip');
                          },
                          style: ElevatedButton.styleFrom(
                            primary:
                                Color.fromARGB(232, 180, 0, 0).withOpacity(0.8),
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          child: Row(
                            children: const [
                              SizedBox(width: 10),
                              Icon(Icons.exit_to_app_outlined,
                                  color: Color.fromARGB(255, 255, 245, 245),
                                  size: 20),
                              SizedBox(width: 5),
                              Text("Leave Trip"),
                            ],
                          ))),
                  SizedBox(width: 50),
                  buildButton(icon: Icons.edit, callBack: () {}),
                ],
              ),
              SizedBox(height: 250),
              SizedBox(
                  height: 100,
                  child: FutureBuilder<List<Trips>?>(
                      future: Trips.readTrips(widget.trip_id),
                      builder: (context, snapshot) {
                        if (snapshot.data?.length == 0) {
                          return const Center(child: Text('No data'));
                        } else if (snapshot.hasError) {
                          return const Text('Something went wrong');
                        } else if (snapshot.hasData) {
                          final trips = snapshot.data!;
                          return Scaffold(
                              body: Container(
                                  margin: const EdgeInsets.all(20),
                                  child: SizedBox(
                                      height: 500,
                                      child: Timeline.tileBuilder(
                                        scrollDirection: Axis.horizontal,
                                        builder: TimelineTileBuilder.fromStyle(
                                          contentsAlign:
                                              ContentsAlign.alternating,
                                          contentsBuilder: (context, index) =>
                                              Padding(
                                            padding: const EdgeInsets.all(.0),
                                            child: Text(trips[index].name),
                                          ),
                                          itemCount: trips.length,
                                        ),
                                      ))));
                        } else {
                          return const Center(
                              child: const CircularProgressIndicator());
                        }
                      })),
            ])),
        borderRadius: radius,
      ),
    );
  }

  Widget buildSlidingPanel({required ScrollController scrollController}) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: buildTabBar(),
            body: TabBarView(children: [
              TabWidgetAlt(
                  scrollController: scrollController, trip_id: widget.trip_id),
              TabWidget2Alt(
                  scrollController: scrollController,
                  trip_id: widget.trip_id,
                  trip_name: widget.trip_name)
            ])));
  }

  Widget buildButton(
          {required IconData icon, required VoidCallback callBack}) =>
      IconButton(
        onPressed: callBack,
        icon: const Icon(
          Icons.edit,
          size: 25,
          color: Colors.white,
        ),
      );
  PreferredSizeWidget buildTabBar() => PreferredSize(
      preferredSize: Size.fromHeight(80),
      child: AppBar(
        automaticallyImplyLeading: false,
        title: const Icon(Icons.drag_handle),
        centerTitle: true,
        bottom: const TabBar(tabs: [
          Tab(child: Text('Trips Info')),
          const Tab(child: Text('Members'))
        ]),
      ));
}
