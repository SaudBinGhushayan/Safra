import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safra/objects/user.dart';

class dashboard extends StatefulWidget {
  const dashboard({super.key});

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
        body: StreamBuilder<List<Users>>(
            stream: readUsers(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              } else if (snapshot.hasData) {
                final users = snapshot.data!;
                return Scaffold(
                    body: Container(
                        child: Padding(
                            padding: const EdgeInsets.all(32),
                            child: Center(
                              child: Column(
                                children: [
                                  ListView(
                                      shrinkWrap: true,
                                      children: users.map(buildUser).toList()),
                                  SizedBox(height: 8),
                                  const Text(
                                    'Signed In as',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    user.email!,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 8),
                                  ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: const Size.fromHeight(50),
                                    ),
                                    icon:
                                        const Icon(Icons.arrow_back, size: 32),
                                    label: const Text(
                                      'signOut',
                                      style: TextStyle(fontSize: 24),
                                    ),
                                    onPressed: () =>
                                        FirebaseAuth.instance.signOut(),
                                  )
                                ],
                              ),
                            ))));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }

  Widget buildUser(Users user) => ListTile(
        title: Text(user.email),
        subtitle: Text(user.name),
        leading: Text(user.phoneNumber),
      );

  Stream<List<Users>> readUsers() => FirebaseFirestore.instance
      .collection('Users')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Users.readFromJson(doc.data())).toList());

  // Future<Stream<Users?>> readUser() async {
  //   final docUser = FirebaseFirestore.instance.collection('Users').doc("user's_Doc37");
  //   final snapshot = await docUser.get("user's_Doc37");

  //   if (snapshot.exists) {
  //     return User.fromJson(snapshot.data()!);
  //   }
  // }
}
