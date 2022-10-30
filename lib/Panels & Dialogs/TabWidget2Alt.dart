import 'dart:math';

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
import 'package:safra/ui/ManageActivities.dart';
import 'package:safra/ui/dashboardn.dart';

class TabWidget2Alt extends StatefulWidget {
  TabWidget2Alt(
      {Key? key, required this.scrollController, required this.trip_id})
      : super(key: key);
  final ScrollController scrollController;
  final String trip_id;

  @override
  State<TabWidget2Alt> createState() => _TabWidget2AltState();
}

class _TabWidget2AltState extends State<TabWidget2Alt> {
  final user = FirebaseAuth.instance.currentUser!;
  final usernameCont = TextEditingController();
  String username = '';
  String active = '';

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
        height: 230,
        child: FutureBuilder<List<Participate>?>(
            future: Participate.readParticipants(widget.trip_id),
            builder: (context, snapshot) {
              if (snapshot.data?.length == 0) {
                return const Text('No data');
              } else if (snapshot.hasError) {
                return const Text('Something went wrong');
              } else if (snapshot.hasData) {
                final participate = snapshot.data!;
                active = participate[0].active;
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
                                  icon: Icons.delete,
                                  callBack: () async {
                                    final vaild =
                                        await TripsInfo.validateLeader(user.uid,
                                            participate[index].tripId);

                                    if (vaild) {
                                      final leader =
                                          await TripsInfo.validateLeader(
                                              participate[index].uid,
                                              participate[index].tripId);

                                      if (leader) {
                                        snackBar.showSnackBarRed(
                                            'You cannot delete the leader of this trip');
                                      } else if (!leader) {
                                        await SupaBase_Manager()
                                            .client
                                            .from('activities')
                                            .delete()
                                            .match({
                                          'trip_id': participate[index].tripId
                                        }).match({
                                          'uid': participate[index].uid
                                        }).execute();

                                        await SupaBase_Manager()
                                            .client
                                            .from('participate')
                                            .delete()
                                            .match({
                                          'trip_id': participate[index].tripId
                                        }).match({
                                          'uid': participate[index].uid
                                        }).execute();
                                        return snackBar.showSnackBarGreen(
                                            'Member deleted successfully');
                                      }
                                    } else {
                                      snackBar.showSnackBarRed(
                                          'Only leader can delete members');
                                    }
                                  }),
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
      Container(
          margin: const EdgeInsets.fromLTRB(20, 15, 20, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: ElevatedButton(
              onPressed: () async {
                final valid =
                    await TripsInfo.validateLeader(user.uid, widget.trip_id);
                if (valid) {
                  var route = new MaterialPageRoute(
                      builder: (context) => new AddMembers(
                          trip_id: widget.trip_id, active: active));
                  Navigator.of(context).push(route);
                } else {
                  return snackBar.showSnackBarRed(
                      'Only leader can add members to this trip');
                }
              },
              style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(232, 0, 165, 41),
                  textStyle: const TextStyle(fontSize: 20),
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 5)),
              child: Row(
                children: const [
                  SizedBox(width: 100),
                  Icon(Icons.add,
                      color: Color.fromARGB(255, 255, 245, 245), size: 20),
                  SizedBox(width: 5),
                  Text("Add Member"),
                ],
              ))),
    ]);
  }

  Widget buildButton(
          {required IconData icon, required VoidCallback callBack}) =>
      IconButton(
        onPressed: callBack,
        icon: const Icon(
          Icons.delete,
          size: 25,
          color: Color.fromARGB(255, 50, 160, 233),
        ),
      );
}

class AddMembers extends StatefulWidget {
  const AddMembers({Key? key, required this.trip_id, required this.active})
      : super(key: key);
  final trip_id;
  final active;

  @override
  State<AddMembers> createState() => _AddMembersState();
}

class _AddMembersState extends State<AddMembers> {
  String username = '';
  String participate_id = '${Random().nextDouble() * 256}';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Card(
          child: TextFormField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Enter your friend's username"),
            onChanged: ((value) {
              setState(() {
                username = value;
              });
            }),
          ),
        )),
        body: Container(
          width: double.infinity,
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('Users').snapshots(),
                builder: (context, snapshots) {
                  return (snapshots.connectionState == ConnectionState.waiting)
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          itemCount: snapshots.data!.docs.length,
                          itemBuilder: (context, index) {
                            var users = snapshots.data!.docs[index].data()
                                as Map<String, dynamic>;
                            if (username.isEmpty) {
                              return ListTile(
                                title: Text(
                                  users['username'],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 19,
                                      color: Color.fromARGB(255, 79, 101, 116)),
                                ),
                                subtitle: Text(
                                  users['email'],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 19,
                                      color: Color.fromARGB(255, 79, 101, 116)),
                                ),
                                leading: const Icon(Icons.person,
                                    size: 40,
                                    color: Color.fromARGB(255, 79, 101, 116)),
                                trailing: IconButton(
                                    icon: Icon(Icons.add,
                                        size: 30, color: Colors.green),
                                    onPressed: () async {
                                      final inUser = await Participate.inMember(
                                          widget.trip_id, users['username']);
                                      if (!inUser) {
                                        addMember(
                                            uid: users['uid'],
                                            username: users['username'],
                                            active: widget.active,
                                            participate_id: participate_id,
                                            trip_id: widget.trip_id);
                                        snackBar.showSnackBarGreen(
                                            'member added successfully');
                                      } else {
                                        return snackBar.showSnackBarRed(
                                            'Member already registered at this trip');
                                      }
                                    }),
                              );
                            }
                            if (users['username']
                                .toString()
                                .toLowerCase()
                                .startsWith(username.toLowerCase())) {
                              return ListTile(
                                title: Text(
                                  users['username'],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 19,
                                      color: Color.fromARGB(255, 79, 101, 116)),
                                ),
                                subtitle: Text(
                                  users['email'],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 19,
                                      color: Color.fromARGB(255, 79, 101, 116)),
                                ),
                                leading: const Icon(Icons.person,
                                    size: 40,
                                    color: Color.fromARGB(255, 79, 101, 116)),
                                trailing: IconButton(
                                    icon: Icon(Icons.add,
                                        size: 30, color: Colors.green),
                                    onPressed: () async {
                                      final inUser = await Participate.inMember(
                                          widget.trip_id, users['username']);
                                      if (!inUser) {
                                        await SupaBase_Manager()
                                            .client
                                            .from('participate')
                                            .update({'active': 'false'}).match(
                                                {'active': 'true'}).match({
                                          'uid': users['uid']
                                        }).execute();
                                        await SupaBase_Manager()
                                            .client
                                            .from('trips_info')
                                            .update({'active': 'false'}).match(
                                                {'active': 'true'}).match({
                                          'uid': users['uid']
                                        }).execute();
                                        addMember(
                                            uid: users['uid'],
                                            username: users['username'],
                                            active: widget.active,
                                            participate_id: participate_id,
                                            trip_id: widget.trip_id);
                                        snackBar.showSnackBarGreen(
                                            'member added successfully');
                                      } else {
                                        return snackBar.showSnackBarRed(
                                            'Member already registered at this trip');
                                      }
                                    }),
                              );
                            }
                            return Container();
                          });
                }),
          ),
        ));
  }
}
