import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:safra/Panels%20&%20Dialogs/TabWidget.dart';
import 'package:safra/Panels%20&%20Dialogs/TabWidget2.dart';
import 'package:safra/backend/supabase.dart';
import 'package:safra/objects/Trips.dart';
import 'package:safra/objects/displayTripsInfo.dart';
import 'package:safra/objects/participate.dart';
import 'package:safra/objects/user.dart';
import 'package:safra/ui/dashboardn.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:timelines/timelines.dart';

class ManageActivities extends StatefulWidget {
  const ManageActivities(
      {Key? key, required this.trip_id, required this.trip_name})
      : super(key: key);
  final String trip_id;
  final String trip_name;
  State<ManageActivities> createState() => _ManageActivitiesState();
}

class _ManageActivitiesState extends State<ManageActivities> {
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
                                    builder: (context) => const dashboardn()));
                          })),
                  SizedBox(width: 120),
                  IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => widget));
                      },
                      icon: Icon(Icons.replay_outlined, color: Colors.white)),
                  SizedBox(width: 140),
                  buildButton(icon: Icons.edit, callBack: () async {})
                ],
              ),
              SizedBox(height: 250),
              SizedBox(
                  height: 100,
                  child: FutureBuilder<List<Trips>?>(
                      future: Trips.displayNearestTripActivities(user.uid),
                      builder: (context, snapshot) {
                        if (snapshot.data?.length == 0) {
                          return const Center(child: Text('No data'));
                        } else if (snapshot.hasError) {
                          return const Text('Something went wrong');
                        } else if (snapshot.hasData) {
                          final trips = snapshot.data!;

                          return Scaffold(
                              body: Container(
                                  child: SizedBox(
                                      height: 500,
                                      child: Timeline.tileBuilder(
                                        scrollDirection: Axis.horizontal,
                                        builder: TimelineTileBuilder.fromStyle(
                                          contentsAlign:
                                              ContentsAlign.alternating,
                                          contentsBuilder: (context, index) =>
                                              Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Text(trips[index].name),
                                          ),
                                          oppositeContentsBuilder:
                                              (context, index) => Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Text(
                                                '${DateFormat("MMM").format(trips[index].activity_date)}${trips[index].activity_date.day}'),
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
              TabWidget(scrollController: scrollController),
              TabWidget2(
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
