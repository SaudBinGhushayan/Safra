import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:safra/objects/displayTripsInfo.dart';
import 'package:safra/objects/participate.dart';
import 'package:safra/objects/user.dart';
import 'package:safra/ui/ManageActivities.dart';
import 'package:safra/ui/dashboardn.dart';

class TabWidget extends StatelessWidget {
  TabWidget({Key? key, required this.scrollController}) : super(key: key);
  final ScrollController scrollController;
  final user = FirebaseAuth.instance.currentUser!;
  String trip_id = '';

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
          height: 200,
          child: Container(
              //////1st column
              decoration: const BoxDecoration(
                  image: DecorationImage(
            image: AssetImage('images/BackgroundPics/alt1.jpg'),
            fit: BoxFit.cover,
          )))),
      const SizedBox(height: 15),
      SizedBox(
          height: 250,
          child: FutureBuilder<List<displayTripsInfo>?>(
              future: displayTripsInfo.displayNearestTrip(user.uid),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                } else if (snapshot.data?.length == 0) {
                  return const Text('No data');
                } else if (snapshot.hasData) {
                  final trip = snapshot.data![0];
                  trip_id = trip.tripsInfo.tripId;
                  return Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 3, 0),
                    child: Column(children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(trip.tripsInfo.trip_name,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 35,
                                    fontWeight: FontWeight.w300)),
                          ),
                          buildButton(icon: Icons.edit, callBack: () {}),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(children: [
                        Icon(Icons.date_range,
                            size: 20,
                            color: const Color.fromARGB(255, 50, 160, 233)
                                .withOpacity(0.9)),
                        const SizedBox(width: 3),
                        Text(
                            '${DateFormat("MMM").format(trip.tripsInfo.from)}${trip.tripsInfo.from.day} - ${DateFormat("MMM").format(trip.tripsInfo.to)}${trip.tripsInfo.to.day}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            )),
                      ]),
                      const SizedBox(height: 10),
                      Row(children: [
                        Icon(Icons.pin_drop_outlined,
                            size: 20,
                            color: const Color.fromARGB(255, 50, 160, 233)
                                .withOpacity(0.9)),
                        const SizedBox(width: 3),
                        const Text('Location',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            )),
                      ]),
                      const SizedBox(height: 10),
                      FutureBuilder<Users?>(
                          future: Users.readUser(trip.tripsInfo.uid),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final users = snapshot.data!;
                              return Row(children: [
                                Icon(Icons.star_border,
                                    size: 20,
                                    color:
                                        const Color.fromARGB(255, 50, 160, 233)
                                            .withOpacity(0.9)),
                                const SizedBox(width: 3),
                                Text('Trip Leader: ${users.username}',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    )),
                              ]);
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          }),
                      const SizedBox(height: 10),
                      Row(children: [
                        Icon(Icons.check_box_outline_blank,
                            size: 20,
                            color: const Color.fromARGB(255, 50, 160, 233)
                                .withOpacity(0.9)),
                        const SizedBox(width: 3),
                        Text('Status ${trip.tripsInfo.active}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            )),
                      ]),
                      const SizedBox(height: 10),
                      Row(children: [
                        Icon(Icons.key_outlined,
                            size: 20,
                            color: const Color.fromARGB(255, 50, 160, 233)
                                .withOpacity(0.9)),
                        const SizedBox(width: 3),
                        Text("Trip id ${trip.tripsInfo.tripId}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            )),
                      ]),
                    ]),
                  );
                } else {
                  return const Center(child: const CircularProgressIndicator());
                }
              })),
    ]);
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
}
