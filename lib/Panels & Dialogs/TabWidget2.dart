import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:safra/objects/displayTripsInfo.dart';
import 'package:safra/objects/participate.dart';
import 'package:safra/ui/ManageActivities.dart';
import 'package:safra/ui/dashboardn.dart';

class TabWidget2 extends StatelessWidget {
  TabWidget2({Key? key, required this.scrollController}) : super(key: key);
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
      SizedBox(
        height: 250,
        child: FutureBuilder<List<Participate>?>(
            future: Participate.readParticipants(trip_id),
            builder: (context, snapshot) {
              if (snapshot.data?.length == 0) {
                return const Text('No data');
              } else if (snapshot.hasError) {
                return const Text('Something went wrong');
              } else if (snapshot.hasData) {
                final participate = snapshot.data!;
                return Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: ListView.builder(
                        itemCount: participate.length,
                        itemBuilder: ((context, index) {
                          return ListTile(
                              title: Text(participate[index].username,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                  )),
                              trailing: buildButton(
                                  icon: Icons.edit, callBack: () {}),
                              leading: const Icon(Icons.person,
                                  size: 40,
                                  color:
                                      const Color.fromARGB(255, 50, 160, 233)));
                        })));
              } else {
                return const Center(child: const CircularProgressIndicator());
              }
            }),
      ),
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
