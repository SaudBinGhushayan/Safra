import 'dart:math';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:safra/backend/snackBar.dart';
import 'package:safra/backend/supabase.dart';
import 'package:safra/objects/Trips.dart';
import 'package:safra/objects/TripsInfo.dart';
import 'package:safra/objects/comment_for_trips.dart';
import 'package:safra/objects/participate.dart';
import 'package:safra/objects/user.dart';
import 'package:safra/ui/searchtrip.dart';

class cloneTrip extends StatefulWidget {
  cloneTrip({Key? key, required this.trips}) : super(key: key);
  Map<String, dynamic> trips;
  @override
  State<cloneTrip> createState() => _cloneTripState();
}

class _cloneTripState extends State<cloneTrip> {
  final user = FirebaseAuth.instance.currentUser!;
  final comment = TextEditingController();
  String username = '';
  String gen_trip_id = (Random().nextDouble() * 256).toStringAsFixed(4);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('images/BackgroundPics/AltBackground.jpg'),
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
                    return Text('');
                  } else {
                    return Text('');
                  }
                }),
            Row(
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 25, bottom: 10),
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const searchtrip()));
                        })),
                SizedBox(width: 200),
                ElevatedButton(
                    onPressed: () async {
                      final valid = await Participate.validUserForTrip(
                          user.uid, widget.trips['trip_id']);
                      if (!valid) {
                        final trips_Info = TripsInfo(
                            tripId: gen_trip_id,
                            active: 'false',
                            country: widget.trips['country'],
                            uid: user.uid,
                            from: DateTime.tryParse(widget.trips['from'])!,
                            to: DateTime.tryParse(widget.trips['to'])!,
                            trip_name: widget.trips['trip_name']);

                        final participate = Participate(
                          participate_id:
                              (Random().nextDouble() * 256).toStringAsFixed(4),
                          username: username,
                          tripId: gen_trip_id,
                          active: 'false',
                          uid: user.uid,
                        );
                        await SupaBase_Manager()
                            .client
                            .from('trips_info')
                            .insert([trips_Info.toJson()]).execute();
                        await SupaBase_Manager()
                            .client
                            .from('participate')
                            .insert([participate.toJson()]).execute();

                        return snackBar
                            .showSnackBarGreen('Trip added successfully');
                      } else {
                        return snackBar.showSnackBarRed(
                            'this trip is registered in your account');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        textStyle: const TextStyle(fontSize: 20),
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5)),
                    child: Row(
                      children: const [
                        Icon(Icons.add,
                            color: Color.fromARGB(255, 255, 245, 245),
                            size: 20),
                        SizedBox(width: 5),
                        Text("Clone Trip"),
                      ],
                    ))
              ],
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 250, 5),
              child: Text(widget.trips['trip_name'],
                  style: const TextStyle(fontSize: 30)),
            ),
            Row(children: [
              FutureBuilder<List<Participate>?>(
                  future: Participate.readParticipants(widget.trips['trip_id']),
                  builder: (context, snapshot) {
                    if (snapshot.data?.length == 0) {
                      return const Text('No data');
                    } else if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    } else if (snapshot.hasData) {
                      final participate = snapshot.data!;
                      return Container(
                        padding: const EdgeInsets.fromLTRB(10, 3, 20, 5),
                        child: Row(
                          children: [
                            const Icon(Icons.person,
                                color: Color.fromARGB(255, 79, 101, 116),
                                size: 30),
                            Text(participate.length.toString(),
                                style: const TextStyle(fontSize: 19)),
                          ],
                        ),
                      );
                    } else {
                      return const Center(
                          child: const CircularProgressIndicator());
                    }
                  }),
              const SizedBox(width: 3),
              StreamBuilder<List<Map<String, dynamic>>>(
                  stream: SupaBase_Manager()
                      .client
                      .from('trips_likes')
                      .stream(['like_id']).execute(),
                  builder: (context, snapshot) {
                    if (snapshot.data?.length == 0) {
                      final likes = snapshot.data!;
                      return Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.favorite,
                                color: Colors.redAccent, size: 30),
                            onPressed: () async {
                              await SupaBase_Manager()
                                  .client
                                  .from('trips_likes')
                                  .insert({
                                'like_id': (Random().nextDouble() * 265)
                                    .toStringAsFixed(4)
                                    .toString(),
                                'trip_id': widget.trips['trip_id'],
                                'like': 1,
                                'uid': user.uid
                              }).execute();
                            },
                          ),
                          Text('0', style: TextStyle(fontSize: 19)),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    } else if (snapshot.hasData) {
                      final likes = snapshot.data![0];
                      return Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.favorite,
                                color: Colors.redAccent, size: 30),
                            onPressed: () async {
                              await SupaBase_Manager()
                                  .client
                                  .from('trips_likes')
                                  .insert({
                                'like_id': (Random().nextDouble() * 265)
                                    .toStringAsFixed(4)
                                    .toString(),
                                'trip_id': widget.trips['trip_id'],
                                'like': 1,
                                'uid': user.uid
                              }).execute();
                            },
                          ),
                          Text(likes['like'].toString(),
                              style: TextStyle(fontSize: 19)),
                          SizedBox(width: 5),
                          Text(
                              likes['uid'] == user.uid
                                  ? 'You Liked This Trip!'
                                  : '',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 245, 100, 90))),
                        ],
                      );
                    } else {
                      return const Center(
                          child: const CircularProgressIndicator());
                    }
                  }),
            ]),
            SizedBox(
              height: 430,
              child: FutureBuilder<List<Trips>?>(
                future: Trips.readCloneTrips(widget.trips['trip_id']),
                builder: (context, snapshot) {
                  if (snapshot.data?.length == 0) {
                    return const Center(child: Text('No data'));
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Something went wrong'));
                  } else if (snapshot.hasData) {
                    final activities = snapshot.data!;
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: activities.length,
                        itemBuilder: ((context, index) {
                          return Container(
                            margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Color(
                                            (Random().nextDouble() * 0xFFFFFF)
                                                .toInt())
                                        .withOpacity(.3),
                                    spreadRadius: 5,
                                    blurRadius: 1,
                                    offset: const Offset(0, 3)),
                              ],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              title: Text(
                                activities[index].name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 19,
                                    color: Color.fromARGB(255, 79, 101, 116)),
                              ),
                              subtitle: Text(
                                activities[index].country,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 19,
                                    color: Color.fromARGB(255, 79, 101, 116)),
                              ),
                              leading: const Icon(Icons.store_mall_directory,
                                  size: 40,
                                  color: Color.fromARGB(255, 79, 101, 116)),
                              trailing: IconButton(
                                onPressed: () async {
                                  final valid = await Trips.canAddTrip(
                                      user.uid, activities[index].name);
                                  if (valid) {
                                    final trips = Trips(
                                        uid: user.uid,
                                        fsq_id: (Random().nextDouble() * 256)
                                            .toStringAsFixed(4),
                                        photo_url: activities[index].photo_url,
                                        categories:
                                            activities[index].categories,
                                        translated_description:
                                            activities[index]
                                                .translated_description,
                                        name: activities[index].name,
                                        rating: activities[index].rating,
                                        tel: activities[index].tel,
                                        country: activities[index].country,
                                        region: activities[index].region,
                                        price: activities[index].price,
                                        description:
                                            activities[index].description,
                                        trip_name: activities[index].trip_name,
                                        trip_id: gen_trip_id);
                                    await SupaBase_Manager()
                                        .client
                                        .from('activities')
                                        .insert([trips.toJson()]).execute();
                                    return snackBar.showSnackBarGreen(
                                        'Activity added successfully added successfully');
                                  } else {
                                    return snackBar.showSnackBarRed(
                                        'this activity is registered on this trip');
                                  }
                                },
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.green,
                                  size: 30,
                                ),
                              ),
                            ),
                          );
                        }));
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            SizedBox(
              height: 175,
              child: FutureBuilder<List<CommentForTrips>?>(
                future: CommentForTrips.readComments(widget.trips['trip_id']),
                builder: (context, snapshot) {
                  if (snapshot.data?.length == 0) {
                    return const Center(child: Text('No data'));
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Something went wrong'));
                  } else if (snapshot.hasData) {
                    final comments = snapshot.data!;
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: comments.length,
                        itemBuilder: ((context, index) {
                          return Container(
                            margin: const EdgeInsets.fromLTRB(3, 0, 0, 3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              title: Text(
                                comments[index].username,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 19,
                                    color: Color.fromARGB(255, 79, 101, 116)),
                              ),
                              subtitle: Text(
                                comments[index].comment,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 19,
                                    color: Color.fromARGB(255, 79, 101, 116)),
                              ),
                              leading: const Icon(Icons.person,
                                  size: 40,
                                  color: Color.fromARGB(255, 79, 101, 116)),
                              trailing: TextButton.icon(
                                  onPressed: () async {
                                    final interaction =
                                        await CommentForTrips.increment_likes(
                                            comments[index].trip_comment_id,
                                            comments[index].likes);
                                    if (interaction) {
                                      snackBar.showSnackBarGreen(
                                          'liked successfully');
                                    } else {
                                      snackBar.showSnackBarRed(
                                          'Something went wrong');
                                    }
                                  },
                                  icon:
                                      Icon(Icons.thumb_up, color: Colors.blue),
                                  label:
                                      Text(comments[index].likes.toString())),
                            ),
                          );
                        }));
                  } else {
                    return Text('');
                  }
                },
              ),
            ),
            TextFormField(
                controller: comment,
                decoration: InputDecoration(
                    icon: Icon(Icons.comment, size: 20),
                    suffixIcon: IconButton(
                        icon: const Icon(Icons.check,
                            size: 30, color: Colors.green),
                        onPressed: () async {
                          final added = await CommentForTrips.addCommentInTrips(
                              trip_comment_id: (Random().nextDouble() * 256)
                                  .toStringAsFixed(4),
                              trip_id: widget.trips['trip_id'],
                              username: username,
                              comment: comment.text,
                              likes: 0,
                              dislikes: 0);
                          if (added) {
                            snackBar.showSnackBarGreen(
                                "Comment added successfully");
                          } else {
                            snackBar.showSnackBarRed(
                                "you already commented on this trip");
                          }
                        }),
                    hintText: 'Say Something...',
                    hintStyle: const TextStyle(color: Colors.grey),
                    labelText: "Say Something...",
                    labelStyle: const TextStyle(color: Colors.grey))),
          ],
        ),
      ),
    ));
  }
}
