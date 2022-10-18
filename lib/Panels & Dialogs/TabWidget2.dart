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
            future: Participate.readParticipants("3.5265567174120793"),
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
                                      print(participate[index].uid);

                                      if (leader) {
                                        snackBar.showSnackBarRed(
                                            'You cannot delete the leader of this trip');
                                      } else if (!leader) {
                                        print('fkffffffffffffffffff');
                                        final res1 = await SupaBase_Manager()
                                            .client
                                            .from('activities')
                                            .delete()
                                            .match({
                                          'trip_id': participate[index].tripId
                                        }).match({
                                          'uid': participate[index].uid
                                        }).execute();
                                        print(res1.error);

                                        final res2 = await SupaBase_Manager()
                                            .client
                                            .from('participate')
                                            .delete()
                                            .match({
                                          'trip_id': participate[index].tripId
                                        }).match({
                                          'uid': participate[index].uid
                                        }).execute();
                                        print(res2);
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
