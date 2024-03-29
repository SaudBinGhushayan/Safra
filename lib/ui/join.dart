import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:safra/backend/snackBar.dart';
import 'package:safra/backend/storage.dart';
import 'package:safra/backend/supabase.dart';
import 'package:safra/objects/TripsInfo.dart';
import 'package:safra/objects/participate.dart';
import 'package:safra/objects/user.dart';
import 'package:safra/ui/ContactUs.dart';
import 'package:safra/ui/FAQ.dart';
import 'package:safra/ui/accountInformation.dart';
import 'package:safra/ui/dashboardn.dart';
import 'package:safra/ui/homePage.dart';
import 'package:safra/ui/schedule1.dart';
import 'package:safra/ui/mention.dart';
import 'package:safra/ui/search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:safra/ui/stngs.dart';

class join extends StatefulWidget {
  const join({Key? key}) : super(key: key);

  @override
  State<join> createState() => _joinState();
}

class _joinState extends State<join> {
  final user = FirebaseAuth.instance.currentUser!;
  OverlayEntry? entry;
  // DateTime date = DateTime(2022, 12, 24);
  final tripId = TextEditingController();
  final participate_id = '${Random().nextDouble() * 256}';
  String username = '';
  String active = '';
  final usernameCont = TextEditingController();
  String tusername = '';
  bool humanActive = false;
  bool MachineActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: FutureBuilder<Users?>(
            future: Users.readUser(user.uid),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              } else if (snapshot.hasData) {
                final users = snapshot.data!;
                username = users.username;
                return Scaffold(
                    resizeToAvoidBottomInset: false,
                    body: Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                        image:
                            AssetImage('images/BackgroundPics/background.png'),
                        fit: BoxFit.cover,
                      )),
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //menu icon
                          children: [
                            Container(
                                width: 33,
                                height: 33,
                                padding:
                                    const EdgeInsets.only(top: 0.1, right: 9),
                                margin: const EdgeInsets.fromLTRB(5, 30, 1, 1),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: IconButton(
                                    icon: const Icon(Icons.menu),
                                    iconSize: 20,
                                    onPressed: menu)),
                            Container(
                              //profile icon
                              height: 50,
                              width: 140,
                              margin: const EdgeInsets.only(top: 30),
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
                                        builder:
                                            (BuildContext context, snapshot) {
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
                                                final color = colors[
                                                    index % colors.length];
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
                          ], //end1st row
                        ),

                        Center(
                          //Jointrip,tripid,..
                          child: Column(
                            children: [
                              Theme(
                                data: Theme.of(context).copyWith(
                                    unselectedWidgetColor:
                                        Colors.blue.withOpacity(0.1)),
                                child: CheckboxListTile(
                                  value: MachineActive,
                                  onChanged: (newVal) {
                                    setState(() {
                                      MachineActive = newVal!;
                                    });
                                  },
                                  tileColor: Colors.white,
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                ),
                              ),
                              Container(
                                  margin: const EdgeInsets.only(top: 143),
                                  child: const Text(
                                    'Join trip',
                                    style: TextStyle(
                                        fontSize: 21,
                                        fontFamily: "verdana",
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                  )),
                              Container(
                                margin: const EdgeInsets.only(top: 30),
                                child: const Text(
                                  'Please enter your trip id',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: "verdana",
                                      color: Colors.black),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(40),
                                    ),
                                    color: Colors.white),
                                child: TextFormField(
                                  controller: tripId,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(),
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(40),
                                      ),
                                    ),
                                    hintText: 'Trip id',
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              CheckboxListTile(
                                title: Text(
                                  "Check Here",
                                  style: TextStyle(color: Colors.blue),
                                ),
                                value: humanActive,
                                onChanged: (newVal) {
                                  setState(() {
                                    humanActive = newVal!;
                                  });
                                },
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                              ),
                              ElevatedButton(
                                  onPressed: () async {
                                    if (humanActive && !MachineActive) {
                                      final response = await SupaBase_Manager()
                                          .client
                                          .from('trips_info')
                                          .select()
                                          .eq('trip_id', tripId.text)
                                          .execute();
                                      if (response.data.length != 0) {
                                        var data = response.data[0]
                                            as Map<String, dynamic>;
                                        setState(() {
                                          active = data['active'];
                                        });
                                      }

                                      final validTripId =
                                          await Participate.validTripId(
                                              tripId.text);
                                      final validUser =
                                          await Participate.validUserForTrip(
                                              user.uid, tripId.text);

                                      if (!validTripId) {
                                        return snackBar.showSnackBarRed(
                                            'Sorry, Trip does not exist try to enter a valid trip id');
                                      } else if (validUser) {
                                        return snackBar.showSnackBarRed(
                                            'You are already registered at this trip');
                                      } else {
                                        await SupaBase_Manager()
                                            .client
                                            .from('participate')
                                            .update({'active': 'false'}).match({
                                          'active': 'true'
                                        }).match({'uid': user.uid}).execute();
                                        await SupaBase_Manager()
                                            .client
                                            .from('trips_info')
                                            .update({'active': 'false'}).match({
                                          'active': 'true'
                                        }).match({'uid': user.uid}).execute();

                                        addMember(
                                            uid: user.uid,
                                            username: username,
                                            active: active,
                                            participate_id: participate_id,
                                            trip_id: tripId.text);
                                        snackBar.showSnackBarGreen(
                                            'Succeefully joined trip No.${tripId.text}');
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const dashboardn()));
                                      }
                                    } else {
                                      snackBar.showSnackBarRed(
                                          'Please Refresh the Page and Try Again');
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary:
                                          const Color.fromARGB(255, 2, 95, 172),
                                      textStyle: const TextStyle(fontSize: 20),
                                      padding: const EdgeInsets.fromLTRB(
                                          160, 10, 160, 10)),
                                  child: const Text("Join")),
                              Container(
                                margin: const EdgeInsets.only(top: 100),
                                height: 200,
                                width: 500,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "images/NavigationBar/Navigator.jpg"))),
                                child: Row(
                                  children: [
                                    IconButton(
                                      alignment: Alignment.topCenter,
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const dashboardn()));
                                      },
                                      icon: Image.asset(
                                          'images/NavigationBar/Dashboard.jpg'),
                                      iconSize: 55,
                                      padding: const EdgeInsets.only(
                                          left: 29, bottom: 29),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const mention()));
                                      },
                                      icon: Image.asset(
                                          'images/NavigationBar/Mention.jpg'),
                                      iconSize: 55,
                                      padding: const EdgeInsets.only(
                                          left: 14, bottom: 29),
                                    ),
                                    Container(
                                        child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                27.5, 0.2, 30, 70),
                                            child: CircleAvatar(
                                                radius: 24,
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        255, 250, 101, 2),
                                                child: IconButton(
                                                  icon: const Icon(Icons.search,
                                                      color: Colors.white),
                                                  iconSize: 31,
                                                  padding:
                                                      const EdgeInsets.all(0.2),
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const search()));
                                                  },
                                                )))),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const schedule1()));
                                      },
                                      icon: Image.asset(
                                          'images/NavigationBar/ScheduleActive.jpg'),
                                      iconSize: 55,
                                      padding: const EdgeInsets.only(
                                          left: 1, bottom: 29),
                                      highlightColor: Colors.white,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const accountInformation()));
                                      },
                                      icon: Image.asset(
                                          'images/NavigationBar/Profile.jpg'),
                                      iconSize: 55,
                                      padding: const EdgeInsets.only(
                                          left: 10, bottom: 26),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        //      SizedBox(height: 39.5),
                      ]),
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

  void menu() {
    entry = OverlayEntry(
        builder: (context) => Card(
              margin: const EdgeInsets.all(0),
              color: Colors.black54.withOpacity(0.8),
              child: Column(children: [
                const SizedBox(height: 200),
                Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(left: 30),
                    child: const Text('Menu',
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 21))),
                const SizedBox(height: 40),
                Container(
                    color: Colors.black12.withOpacity(0.5),
                    child: Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(top: 10, left: 30),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const stngs())),
                                  hideMenu()
                                },
                                child: const Text(
                                  'Settings',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 21,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 25),
                              TextButton(
                                onPressed: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const FAQ())),
                                  hideMenu()
                                },
                                child: const Text(
                                  'FAQ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 21,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 25),
                              TextButton(
                                onPressed: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const contactUs())),
                                  hideMenu()
                                },
                                child: const Text(
                                  'Contact Us',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 21,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 25),
                              TextButton(
                                onPressed: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const homePage())),
                                  FirebaseAuth.instance.signOut(),
                                  hideMenu()
                                },
                                child: const Text(
                                  'Sign out',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 21,
                                  ),
                                ),
                              )
                            ]))),
                const SizedBox(height: 40),
                ElevatedButton.icon(
                  onPressed: hideMenu,
                  icon: const Icon(Icons.visibility_off),
                  label: const Text('back'),
                )
              ]),
            ));

    final overlay = Overlay.of(context);
    overlay?.insert(entry!);
  }

  void hideMenu() {
    entry?.remove();
    entry = null;
  }
}
