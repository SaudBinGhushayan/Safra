// ignore_for_file: unnecessary_new

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:safra/backend/snackBar.dart';
import 'package:safra/backend/supabase.dart';
import 'package:safra/objects/TripsInfo.dart';
import 'package:safra/objects/displayTripsInfo.dart';
import 'package:safra/objects/participate.dart';
import 'package:safra/objects/user.dart';
import 'package:safra/ui/ManageActivities.dart';
import 'package:safra/ui/ManageTrips.dart';
import 'package:safra/ui/dashboardn.dart';

class TabWidgetAlt extends StatefulWidget {
  TabWidgetAlt(
      {Key? key, required this.scrollController, required this.trip_id})
      : super(key: key);
  final ScrollController scrollController;
  final String trip_id;

  @override
  State<TabWidgetAlt> createState() => _TabWidgetAltState();
}

class _TabWidgetAltState extends State<TabWidgetAlt> {
  final user = FirebaseAuth.instance.currentUser!;

  String tripId = '';

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
          height: 496,
          child: FutureBuilder<List<TripsInfo>?>(
              future: TripsInfo.onTapReadTripInfo(widget.trip_id),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                } else if (snapshot.data?.length == null) {
                  return const Text('No data');
                } else if (snapshot.hasData) {
                  final trip = snapshot.data![0];
                  tripId = trip.tripId;
                  return Container(
                    child: Column(children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(trip.photo_url,
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover)),
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 0, 3, 0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(trip.trip_name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 35,
                                      fontWeight: FontWeight.w300)),
                            ),
                            buildButton(
                                icon: Icons.edit,
                                callBack: () async {
                                  final valid = await TripsInfo.validateLeader(
                                      user.uid, trip.tripId);
                                  if (valid) {
                                    var route = new MaterialPageRoute(
                                        builder: (context) =>
                                            new onTapeditTripInfo(
                                              trip_name: trip.trip_name,
                                              active: trip.active,
                                              trip_id: trip.tripId,
                                              country: trip.country,
                                              from: trip.from,
                                              to: trip.to,
                                            ));
                                    // ignore: use_build_context_synchronously
                                    Navigator.of(context).push(route);
                                  } else {
                                    return snackBar.showSnackBarRed(
                                        'Only leader can edit this trip');
                                  }
                                }),
                          ],
                        ),
                      ),
                      const SizedBox(height: 13),
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 0, 3, 0),
                        child: Row(children: [
                          Icon(Icons.date_range,
                              size: 20,
                              color: const Color.fromARGB(255, 50, 160, 233)
                                  .withOpacity(0.9)),
                          const SizedBox(width: 3),
                          Text(
                              '${DateFormat("MMM").format(trip.from)}${trip.from.day} - ${DateFormat("MMM").format(trip.to)}${trip.to.day}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              )),
                        ]),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 0, 3, 0),
                        child: Row(children: [
                          Icon(Icons.pin_drop_outlined,
                              size: 20,
                              color: const Color.fromARGB(255, 50, 160, 233)
                                  .withOpacity(0.9)),
                          const SizedBox(width: 3),
                          Text(trip.country,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              )),
                        ]),
                      ),
                      const SizedBox(height: 10),
                      FutureBuilder<Users?>(
                          future: Users.readUser(trip.uid),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final users = snapshot.data!;
                              return Container(
                                margin: const EdgeInsets.fromLTRB(20, 0, 3, 0),
                                child: Row(children: [
                                  Icon(Icons.star_border,
                                      size: 20,
                                      color: const Color.fromARGB(
                                              255, 50, 160, 233)
                                          .withOpacity(0.9)),
                                  const SizedBox(width: 3),
                                  Text('Trip Leader: ${users.username}',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      )),
                                ]),
                              );
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          }),
                      const SizedBox(height: 10),
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 0, 3, 0),
                        child: Row(children: [
                          Icon(Icons.check_box_outline_blank,
                              size: 20,
                              color: const Color.fromARGB(255, 50, 160, 233)
                                  .withOpacity(0.9)),
                          const SizedBox(width: 3),
                          Text(
                              trip.active == 'true'
                                  ? 'Status: Active'
                                  : 'Status Not Active',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              )),
                        ]),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 0, 3, 0),
                        child: Row(children: [
                          Icon(Icons.key_outlined,
                              size: 20,
                              color: const Color.fromARGB(255, 50, 160, 233)
                                  .withOpacity(0.9)),
                          const SizedBox(width: 3),
                          Text("Trip id ${trip.tripId}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              )),
                        ]),
                      ),
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

class onTapeditTripInfo extends StatefulWidget {
  final String trip_name;
  final String active;
  final String country;
  final String trip_id;
  final DateTime from;
  final DateTime to;
  onTapeditTripInfo({
    Key? key,
    required this.trip_name,
    required this.active,
    required this.country,
    required this.trip_id,
    required this.from,
    required this.to,
  }) : super(key: key);

  @override
  State<onTapeditTripInfo> createState() => _onTapeditTripInfoState();
}

class _onTapeditTripInfoState extends State<onTapeditTripInfo> {
  final user = FirebaseAuth.instance.currentUser!;

  String trip_id = '';
  String Status = '';

  @override
  Widget build(BuildContext context) {
    final trip_nameCont = TextEditingController();
    final activeCont = TextEditingController();
    final countryCont = TextEditingController();
    final typeFrom = TextEditingController();
    final typeTo = TextEditingController();
    DateTime? fromCont = DateTime(
        int.parse(widget.from.year.toString()),
        int.parse(widget.from.month.toString()),
        int.parse(widget.from.day.toString()));

    DateTime? toCont = DateTime(
        int.parse(widget.to.year.toString()),
        int.parse(widget.to.month.toString()),
        int.parse(widget.to.day.toString()));

    final validatorKey = GlobalKey<FormState>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        // width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.height,
        child: Form(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 15),
              Container(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => onTapActivity(
                                      trip_id: widget.trip_id,
                                      trip_name: widget.trip_name,
                                    )));
                      })),
              SizedBox(height: MediaQuery.of(context).size.height / 200),
              const Text(
                'Edit Trip Info',
                style: TextStyle(
                    fontSize: 30,
                    color: Color.fromARGB(255, 50, 160, 233),
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Verdana'),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 150),
              Container(
                  margin: const EdgeInsets.fromLTRB(0, 20, 20, 20),
                  child: Column(children: [
                    TextFormField(
                      controller: trip_nameCont,
                      decoration: InputDecoration(
                          icon: IconButton(
                              icon: Icon(Icons.change_circle,
                                  size: 20,
                                  color: const Color.fromARGB(255, 50, 160, 233)
                                      .withOpacity(0.9)),
                              onPressed: () {}),
                          suffixIcon: IconButton(
                              icon: const Icon(Icons.check,
                                  size: 30, color: Colors.green),
                              onPressed: () async {
                                await SupaBase_Manager()
                                    .client
                                    .from('activities')
                                    .update({
                                  'trip_name': trip_nameCont.text
                                }).match({'trip_id': widget.trip_id}).execute();
                                await SupaBase_Manager()
                                    .client
                                    .from('trips_info')
                                    .update({
                                  'trip_name': trip_nameCont.text
                                }).match({'trip_id': widget.trip_id}).execute();
                                snackBar.showSnackBarGreen(
                                    'Trip name updated successfully');
                              }),
                          hintText: widget.trip_name,
                          hintStyle: const TextStyle(color: Colors.grey),
                          labelText: "Trip Name",
                          labelStyle: const TextStyle(color: Colors.grey)),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(12, 3, 0, 3),
                      child: Row(children: [
                        Icon(Icons.check_box,
                            size: 20,
                            color: const Color.fromARGB(255, 50, 160, 233)
                                .withOpacity(0.9)),
                        SizedBox(width: 35),
                        Text('Trip Status',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.withOpacity(0.9))),
                        DropdownButton<String>(
                            dropdownColor: Color.fromARGB(255, 130, 200, 247)
                                .withOpacity(0.9),
                            items: <String>['true', 'false'].map((String v) {
                              return DropdownMenuItem<String>(
                                  value: v, child: Text(v));
                            }).toList(),
                            onChanged: (newVal) {
                              Status = newVal!;
                            }),
                        SizedBox(width: 135),
                        IconButton(
                            icon: const Icon(Icons.check,
                                size: 30, color: Colors.green),
                            onPressed: () async {
                              await SupaBase_Manager()
                                  .client
                                  .from('participate')
                                  .update({'active': 'false'}).match(
                                      {'active': 'true'}).execute();
                              await SupaBase_Manager()
                                  .client
                                  .from('trips_info')
                                  .update({'active': 'false'}).match(
                                      {'active': 'true'}).execute();
                              await SupaBase_Manager()
                                  .client
                                  .from('participate')
                                  .update({'active': Status}).match(
                                      {'trip_id': widget.trip_id}).execute();
                              await SupaBase_Manager()
                                  .client
                                  .from('trips_info')
                                  .update({'active': Status}).match(
                                      {'trip_id': widget.trip_id}).execute();
                              snackBar.showSnackBarGreen(
                                  'Trip status updated successfully');
                            })
                      ]),
                    ),
                    Container(
                        margin: const EdgeInsets.fromLTRB(65, 8, 4, 0),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Color.fromARGB(255, 75, 74, 74)
                                        .withOpacity(0.5))))),
                    TextFormField(
                        controller: countryCont,
                        decoration: InputDecoration(
                            icon: IconButton(
                                icon: Icon(Icons.pin_drop,
                                    size: 20,
                                    color:
                                        const Color.fromARGB(255, 50, 160, 233)
                                            .withOpacity(0.9)),
                                onPressed: () {}),
                            suffixIcon: IconButton(
                                icon: const Icon(Icons.check,
                                    size: 30, color: Colors.green),
                                onPressed: () async {
                                  await SupaBase_Manager()
                                      .client
                                      .from('trips_info')
                                      .update(
                                          {'country': countryCont.text}).match({
                                    'trip_id': widget.trip_id
                                  }).execute();
                                  snackBar.showSnackBarGreen(
                                      'Trip countries updated successfully');
                                }),
                            hintText: widget.country,
                            hintStyle: const TextStyle(color: Colors.grey),
                            labelText: "Countries",
                            labelStyle: const TextStyle(color: Colors.grey))),
                    TextFormField(
                        controller: typeFrom,
                        decoration: InputDecoration(
                            icon: IconButton(
                                icon: Icon(Icons.arrow_drop_down,
                                    size: 50,
                                    color:
                                        const Color.fromARGB(255, 50, 160, 233)
                                            .withOpacity(0.9)),
                                onPressed: () async {
                                  fromCont = await showDatePicker(
                                      context: context,
                                      initialDate: fromCont!,
                                      firstDate: DateTime(2022),
                                      lastDate: DateTime(2050));
                                  if (fromCont == null) {
                                    return;
                                  }

                                  await SupaBase_Manager()
                                      .client
                                      .from('trips_info')
                                      .update({
                                    'from':
                                        "${fromCont!.year.toString().padLeft(4, '0')}-${fromCont!.month.toString().padLeft(2, '0')}-${fromCont!.day.toString().padLeft(2, '0')}",
                                  }).match({
                                    'trip_id': widget.trip_id
                                  }).execute();
                                  snackBar.showSnackBarGreen(
                                      'Trip start day updated successfully');
                                }),
                            suffixIcon: IconButton(
                                icon: const Icon(Icons.check,
                                    size: 30, color: Colors.green),
                                onPressed: () async {
                                  setState(() {
                                    fromCont = DateTime.tryParse(typeFrom.text);
                                  });
                                  await SupaBase_Manager()
                                      .client
                                      .from('trips_info')
                                      .update({
                                    'from':
                                        "${fromCont!.year.toString().padLeft(4, '0')}-${fromCont!.month.toString().padLeft(2, '0')}-${fromCont!.day.toString().padLeft(2, '0')}",
                                  }).match({
                                    'trip_id': widget.trip_id
                                  }).execute();
                                  snackBar.showSnackBarGreen(
                                      'Trip start day updated successfully');
                                }),
                            hintText:
                                DateFormat('yyyy-MM-DD').format(fromCont!),
                            hintStyle: const TextStyle(color: Colors.grey),
                            labelText: "Start Date",
                            labelStyle: const TextStyle(color: Colors.grey))),
                    TextFormField(
                        controller: typeTo,
                        decoration: InputDecoration(
                            icon: IconButton(
                                icon: Icon(Icons.arrow_drop_down,
                                    size: 50,
                                    color:
                                        const Color.fromARGB(255, 50, 160, 233)
                                            .withOpacity(0.9)),
                                onPressed: () async {
                                  toCont = await showDatePicker(
                                      context: context,
                                      initialDate: toCont!,
                                      firstDate: DateTime(2022),
                                      lastDate: DateTime(2050));
                                  if (toCont == null) {
                                    return;
                                  }

                                  await SupaBase_Manager()
                                      .client
                                      .from('trips_info')
                                      .update({
                                    'from':
                                        "${toCont!.year.toString().padLeft(4, '0')}-${toCont!.month.toString().padLeft(2, '0')}-${toCont!.day.toString().padLeft(2, '0')}",
                                  }).match({
                                    'trip_id': widget.trip_id
                                  }).execute();
                                  snackBar.showSnackBarGreen(
                                      'Trip start day updated successfully');
                                }),
                            suffixIcon: IconButton(
                                icon: const Icon(Icons.check,
                                    size: 30, color: Colors.green),
                                onPressed: () async {
                                  setState(() {
                                    toCont = DateTime.tryParse(typeTo.text);
                                  });
                                  await SupaBase_Manager()
                                      .client
                                      .from('trips_info')
                                      .update({
                                    'to':
                                        "${toCont!.year.toString().padLeft(4, '0')}-${toCont!.month.toString().padLeft(2, '0')}-${toCont!.day.toString().padLeft(2, '0')}",
                                  }).match({
                                    'trip_id': widget.trip_id
                                  }).execute();
                                  snackBar.showSnackBarGreen(
                                      'Trip start day updated successfully');
                                }),
                            hintText: DateFormat('yyyy/MM/DD').format(toCont!),
                            hintStyle: const TextStyle(color: Colors.grey),
                            labelText: "End date",
                            labelStyle: const TextStyle(color: Colors.grey)))
                  ])),
              const SizedBox(height: 270),
              Container(
                  margin: EdgeInsets.all(20),
                  child: ElevatedButton(
                      onPressed: () async {
                        await SupaBase_Manager()
                            .client
                            .from('activities')
                            .delete()
                            .match({'trip_id': widget.trip_id}).execute();
                        await SupaBase_Manager()
                            .client
                            .from('participate')
                            .delete()
                            .match({'trip_id': widget.trip_id}).execute();
                        await SupaBase_Manager()
                            .client
                            .from('trip_comments')
                            .delete()
                            .match({'trip_id': widget.trip_id}).execute();
                        await SupaBase_Manager()
                            .client
                            .from('trips_likes')
                            .delete()
                            .match({'trip_id': widget.trip_id}).execute();
                        await SupaBase_Manager()
                            .client
                            .from('trips_info')
                            .delete()
                            .match({'trip_id': widget.trip_id}).execute();
                        snackBar.showSnackBarGreen('Trip deleted successfully');
                      },
                      style: ElevatedButton.styleFrom(
                          primary:
                              Color.fromARGB(232, 180, 0, 0).withOpacity(0.8),
                          textStyle: const TextStyle(fontSize: 20),
                          padding: EdgeInsets.all(20)),
                      child: Row(
                        children: const [
                          SizedBox(width: 100),
                          Icon(Icons.delete,
                              color: Color.fromARGB(255, 255, 245, 245),
                              size: 20),
                          SizedBox(width: 5),
                          Text("Delete Trip"),
                        ],
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
