import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:safra/backend/snackBar.dart';
import 'package:safra/objects/Places.dart';
import 'package:safra/objects/Trips.dart';
import 'package:safra/objects/TripsInfo.dart';
import 'package:safra/objects/user.dart';
import 'package:safra/ui/search.dart';

class createTripUI extends StatefulWidget {
  const createTripUI(
      {Key? key, required this.places, required this.td, required this.links})
      : super(key: key);
  final Places? places;
  final String td;
  final String links;
  @override
  State<createTripUI> createState() => createTripUIState();
}

class createTripUIState extends State<createTripUI> {
  final enterTripName = TextEditingController();
  DateTime? from_cont = DateTime.tryParse('2023-01-01');
  DateTime? to_cont = DateTime.tryParse('2023-01-01');

  final user = FirebaseAuth.instance.currentUser!;
  String trip_name = '';
  String active = 'true';
  String username = '';
  String participate = '${(Random().nextDouble() * 256).toStringAsFixed(4)}';
  String trip_id = '${(Random().nextDouble() * 256).toStringAsFixed(4)}';
  String fsq_id = '${(Random().nextDouble() * 256).toStringAsFixed(4)}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        FutureBuilder<Users?>(
            future: Users.readUser(user.uid),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final users = snapshot.data!;
                username = users.username;
                return Container();
              } else {
                return Container();
              }
            }),
        const SizedBox(height: 200),
        Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 30),
            child: Text('Create trip',
                style: TextStyle(color: Colors.grey, fontSize: 21))),
        SizedBox(height: 40),
        Container(
            child: Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 10, left: 30),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextFormField(
                        controller: enterTripName,
                        decoration: InputDecoration(
                            icon: IconButton(
                                icon: Icon(Icons.change_circle,
                                    size: 20,
                                    color:
                                        const Color.fromARGB(255, 50, 160, 233)
                                            .withOpacity(0.9)),
                                onPressed: () {}),
                            hintText: 'Enter Trip Name',
                            hintStyle: const TextStyle(color: Colors.grey),
                            labelText: "Trip Name",
                            labelStyle: const TextStyle(color: Colors.grey)),
                      ),
                      TextButton.icon(
                          onPressed: () async {
                            from_cont = await showDatePicker(
                                context: context,
                                initialDate: from_cont!,
                                firstDate: DateTime(2022),
                                lastDate: DateTime(2050));
                            if (from_cont == null) {
                              return;
                            }
                          },
                          icon: Icon(Icons.date_range),
                          label: Text('Enter Trip Start Date')),
                      TextButton.icon(
                          onPressed: () async {
                            to_cont = await showDatePicker(
                                context: context,
                                initialDate: to_cont!,
                                firstDate: DateTime(2022),
                                lastDate: DateTime(2050));
                            if (to_cont == null) {
                              return;
                            }
                          },
                          icon: Icon(Icons.date_range),
                          label: Text('Enter Trip End Date')),
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
                          });
                          createTrip(
                              username: username,
                              photo_url: widget.places!.photo_url,
                              categories: widget.places!.categories,
                              translated_description: widget.td,
                              uid: user.uid,
                              fsq_id: fsq_id,
                              participate_id: participate,
                              name: widget.places!.name,
                              photourl: widget.links,
                              rating: widget.places!.rating,
                              tel: widget.places!.tel,
                              country: widget.places!.country,
                              region: widget.places!.region,
                              price: widget.places!.price,
                              description: widget.places!.description,
                              active: active,
                              trip_id: trip_id,
                              from: from_cont!,
                              to: to_cont!,
                              trip_name: '${trip_name} by ${username}');
                          snackBar.showSnackBarGreen(
                              'Activity Added to trip ${trip_name} Successfully');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const search()));
                          // setState(() {
                          //   ValueNotifier<bool>(false).value = false;
                          // });
                          // setState(() {
                          //   pressed_create = false;
                          // });
                        },
                      )
                    ]))),
      ]),
    );
  }
}
