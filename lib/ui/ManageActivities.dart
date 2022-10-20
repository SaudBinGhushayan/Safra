import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:safra/Panels%20&%20Dialogs/TabWidget.dart';
import 'package:safra/Panels%20&%20Dialogs/TabWidget2.dart';
import 'package:safra/objects/Trips.dart';
import 'package:safra/objects/displayTripsInfo.dart';
import 'package:safra/objects/participate.dart';
import 'package:safra/objects/user.dart';
import 'package:safra/ui/dashboardn.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:timelines/timelines.dart';

class ManageActivities extends StatefulWidget {
  const ManageActivities({Key? key}) : super(key: key);

  @override
  State<ManageActivities> createState() => _ManageActivitiesState();
}

class _ManageActivitiesState extends State<ManageActivities> {
  final user = FirebaseAuth.instance.currentUser!;
  String trip_id = '';
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
            decoration: const BoxDecoration(),
            child: Column(children: [
              SizedBox(height: 20),
              Row(
                children: [
                  Container(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const dashboardn()));
                          })),
                  SizedBox(width: 300),
                  buildButton(icon: Icons.edit, callBack: () {})
                ],
              ),
              SizedBox(
                  height: 500,
                  child: FutureBuilder<List<Trips>?>(
                      future: Trips.displayNearestTripActivities(user.uid),
                      builder: (context, snapshot) {
                        if (snapshot.data?.length == 0) {
                          return const Center(child: Text('No data'));
                        } else if (snapshot.hasError) {
                          return const Text('Something went wrong');
                        } else if (snapshot.hasData) {
                          final trips = snapshot.data!;
                          trip_id = trips[0].trip_name;
                          return Scaffold(
                              body: Container(
                                  margin: const EdgeInsets.all(20),
                                  child: SizedBox(
                                      height: 500,
                                      child: Timeline.tileBuilder(
                                        scrollDirection: Axis.vertical,
                                        builder: TimelineTileBuilder.fromStyle(
                                          contentsAlign:
                                              ContentsAlign.alternating,
                                          contentsBuilder: (context, index) =>
                                              Padding(
                                            padding: const EdgeInsets.all(24.0),
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
              TabWidget(scrollController: scrollController),
              TabWidget2(scrollController: scrollController, trip_id: trip_id)
            ])));
  }

  Widget buildButton(
          {required IconData icon, required VoidCallback callBack}) =>
      IconButton(
        onPressed: callBack,
        icon: const Icon(
          Icons.edit,
          size: 25,
          color: Color.fromARGB(255, 50, 160, 233),
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
