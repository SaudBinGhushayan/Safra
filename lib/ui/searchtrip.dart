// ignore_for_file: unnecessary_new

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:safra/backend/storage.dart';
import 'package:safra/backend/supabase.dart';
import 'package:safra/objects/user.dart';
import 'package:safra/ui/ContactUs.dart';
import 'package:safra/ui/FAQ.dart';
import 'package:safra/ui/accountInformation.dart';
import 'package:safra/ui/cloneTrip.dart';
import 'package:safra/ui/dashboardn.dart';
import 'package:safra/ui/homePage.dart';
import 'package:safra/ui/schedule1.dart';
import 'package:safra/ui/search.dart';
import 'package:safra/ui/stngs.dart';
import 'package:safra/ui/mention.dart';

class searchtrip extends StatefulWidget {
  const searchtrip({Key? key}) : super(key: key);

  @override
  State<searchtrip> createState() => _searchtripState();
}

class _searchtripState extends State<searchtrip> {
  @override
  final user = FirebaseAuth.instance.currentUser!;
  OverlayEntry? entry;
  String trip_search = '';
  String username = '';

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: 900,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('images/BackgroundPics/background.png'),
          fit: BoxFit.cover,
        )),
        child: Column(
          children: [
            FutureBuilder<Users?>(
                future: Users.readUser(user.uid),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final users = snapshot.data!;
                    username = users.username;
                    return Row(
                      //menu icon
                      children: [
                        Container(
                            width: 33,
                            height: 33,
                            padding: EdgeInsets.only(top: 0.1, right: 9),
                            margin: const EdgeInsets.fromLTRB(5, 0, 1, 1),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.menu),
                              iconSize: 20,
                              onPressed: menu,
                            )),
                        const SizedBox(
                          height: 90,
                        ),
                        Container(
                          //profile icon
                          height: 50,
                          width: 140,
                          margin: const EdgeInsets.fromLTRB(228, 7, 1, 1),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Row(
                            children: [
                              Container(
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
                      ], //end1st row
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
            const SizedBox(
              height: 16,
            ),
            const SizedBox(
              height: 34,
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(40),
                  ),
                  color: Colors.white),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    trip_search = value;
                  });
                },
                style: const TextStyle(),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(40),
                      ),
                    ),
                    hintText: 'Explore new trip',
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(Icons.search,
                        color: Color.fromARGB(255, 102, 101, 101))),
              ),
            ),
            SizedBox(height: 53),
            SizedBox(
              height: 446,
              child: StreamBuilder<List<Map<String, dynamic>>>(
                  stream: SupaBase_Manager()
                      .client
                      .from('trips_info')
                      .stream(['trip_id']).execute(),
                  builder: (context, snapshots) {
                    return (snapshots.connectionState ==
                            ConnectionState.waiting)
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            itemCount: snapshots.data!.length,
                            itemBuilder: (context, index) {
                              var trips = snapshots.data![index];
                              if (trips.isEmpty) {
                                return GestureDetector(
                                  onTap: () {
                                    var route = new MaterialPageRoute(
                                        builder: (context) => new cloneTrip(
                                              trips: trips,
                                            ));
                                    Navigator.of(context).push(route);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color.fromARGB(
                                                    255, 94, 158, 190)
                                                .withOpacity(0.3),
                                            spreadRadius: 5,
                                            blurRadius: 1,
                                            offset: Offset(0, 3)),
                                      ],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: ListTile(
                                      title: Text(
                                        trips['trip_name'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 19,
                                            color: Color.fromARGB(
                                                255, 79, 101, 116)),
                                      ),
                                      subtitle: Text(
                                        trips['country'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 19,
                                            color: Color.fromARGB(
                                                255, 79, 101, 116)),
                                      ),
                                      leading: const Icon(Icons.pin_drop,
                                          size: 40,
                                          color: Color.fromARGB(
                                              255, 79, 101, 116)),
                                    ),
                                  ),
                                );
                              }
                              if (trips['trip_name']
                                  .toString()
                                  .toLowerCase()
                                  .startsWith(trip_search.toLowerCase())) {
                                return GestureDetector(
                                  onTap: () {
                                    var route = new MaterialPageRoute(
                                        builder: (context) => new cloneTrip(
                                              trips: trips,
                                            ));
                                    Navigator.of(context).push(route);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color.fromARGB(
                                                    255, 94, 158, 190)
                                                .withOpacity(0.3),
                                            spreadRadius: 5,
                                            blurRadius: 1,
                                            offset: Offset(0, 3)),
                                      ],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: ListTile(
                                      title: Text(
                                        trips['trip_name'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 19,
                                            color: Color.fromARGB(
                                                255, 79, 101, 116)),
                                      ),
                                      subtitle: Text(
                                        trips['country'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 19,
                                            color: Color.fromARGB(
                                                255, 79, 101, 116)),
                                      ),
                                      leading: const Icon(Icons.pin_drop,
                                          size: 40,
                                          color: Color.fromARGB(
                                              255, 79, 101, 116)),
                                    ),
                                  ),
                                );
                              }
                              return Container();
                            });
                  }),
            ),
            Container(
              //start of navigation bar
              height: 149,
              width: 500,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/NavigationBar/Navigator.jpg"))),
              child: Row(
                children: [
                  IconButton(
                    alignment: Alignment.topCenter,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const dashboardn()));
                    },
                    icon: Image.asset('images/NavigationBar/Dashboard.jpg'),
                    iconSize: 55,
                    padding: const EdgeInsets.only(left: 29, bottom: 29),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const mention()));
                    },
                    icon: Image.asset('images/NavigationBar/Mention.jpg'),
                    iconSize: 55,
                    padding: const EdgeInsets.only(left: 14, bottom: 29),
                  ),
                  Container(
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(27.5, 0.2, 30, 70),
                          child: CircleAvatar(
                              radius: 24,
                              backgroundColor:
                                  const Color.fromARGB(255, 39, 97, 213),
                              child: IconButton(
                                icon: const Icon(Icons.search,
                                    color: Colors.white),
                                iconSize: 31,
                                padding: const EdgeInsets.all(0.2),
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
                              builder: (context) => const schedule1()));
                    },
                    icon: Image.asset('images/NavigationBar/Schedule.jpg'),
                    iconSize: 55,
                    padding: const EdgeInsets.only(left: 1, bottom: 29),
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
                    icon: Image.asset('images/NavigationBar/Profile.jpg'),
                    iconSize: 55,
                    padding: const EdgeInsets.only(left: 10, bottom: 26),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
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
                        style: TextStyle(color: Colors.grey, fontSize: 21))),
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
