import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:safra/backend/snackBar.dart';
import 'package:safra/objects/user.dart';
import 'package:safra/ui/accountInformation.dart';
import 'package:safra/ui/dashboardn.dart';
import 'package:safra/ui/homePage.dart';
import 'package:safra/ui/stngs.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({Key? key}) : super(key: key);

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  final user = FirebaseAuth.instance.currentUser!;
  final name = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  final validatorKey = GlobalKey<FormState>();

  OverlayEntry? entry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            //////1st column
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('images/BackgroundPics/AltBackground.jpg'),
              fit: BoxFit.fill,
            )),
            child: Column(
              children: [
                const SizedBox(height: 50),
                Container(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const stngs()));
                        })),
                const SizedBox(height: 20),
                const Text('Account Settings',
                    style: TextStyle(
                        fontSize: 33, color: Color.fromARGB(255, 75, 74, 74))),
                const SizedBox(height: 80),
                Row(
                  children: [
                    const Padding(padding: EdgeInsets.only(left: 10)),
                    IconButton(
                      onPressed: changeName,
                      icon: const Icon(Icons.supervised_user_circle),
                      iconSize: 33,
                      color: const Color.fromARGB(255, 75, 74, 74),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 10)),
                    TextButton(
                        onPressed: changeName,
                        child: const Text('Change Name',
                            style: TextStyle(
                                color: Color.fromARGB(255, 75, 74, 74),
                                fontSize: 21,
                                fontWeight: FontWeight.normal))),
                    const Padding(padding: EdgeInsets.only(left: 135)),
                    IconButton(
                      onPressed: changeName,
                      icon: const Icon(Icons.arrow_forward_ios),
                      color: const Color.fromARGB(255, 75, 74, 74),
                      iconSize: 22,
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Color.fromARGB(255, 75, 74, 74)))),
                ),
                Row(
                  children: [
                    const Padding(padding: EdgeInsets.only(left: 10)),
                    IconButton(
                      onPressed: changeUserName,
                      icon: new Icon(Icons.change_circle),
                      iconSize: 33,
                      color: const Color.fromARGB(255, 75, 74, 74),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 10)),
                    TextButton(
                        onPressed: changeUserName,
                        child: const Text('Change Username',
                            style: TextStyle(
                                color: Color.fromARGB(255, 75, 74, 74),
                                fontSize: 21,
                                fontWeight: FontWeight.normal))),
                    const Padding(padding: EdgeInsets.only(left: 95)),
                    IconButton(
                      onPressed: changeUserName,
                      icon: const Icon(Icons.arrow_forward_ios),
                      color: const Color.fromARGB(255, 75, 74, 74),
                      iconSize: 22,
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: const Color.fromARGB(255, 75, 74, 74)))),
                ),
                Row(
                  children: [
                    const Padding(padding: EdgeInsets.only(left: 10)),
                    IconButton(
                      onPressed: changePassword,
                      icon: const Icon(Icons.key),
                      iconSize: 33,
                      color: const Color.fromARGB(255, 75, 74, 74),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 10)),
                    TextButton(
                        onPressed: changePassword,
                        child: const Text('Change Password',
                            style: TextStyle(
                                color: Color.fromARGB(255, 75, 74, 74),
                                fontSize: 21,
                                fontWeight: FontWeight.normal))),
                    const Padding(padding: EdgeInsets.only(left: 100)),
                    IconButton(
                      onPressed: changePassword,
                      icon: const Icon(Icons.arrow_forward_ios),
                      color: const Color.fromARGB(255, 75, 74, 74),
                      iconSize: 22,
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: const BorderSide(
                              color: Color.fromARGB(255, 75, 74, 74)))),
                ),
                Row(
                  children: [
                    const Padding(padding: EdgeInsets.only(left: 10)),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => accountInformation()));
                      },
                      icon: const Icon(Icons.info),
                      iconSize: 33,
                      color: const Color.fromARGB(255, 75, 74, 74),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 10)),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => accountInformation()));
                        },
                        child: const Text('Account Info',
                            style: TextStyle(
                                color: Color.fromARGB(255, 75, 74, 74),
                                fontSize: 21,
                                fontWeight: FontWeight.normal))),
                    const Padding(padding: EdgeInsets.only(left: 150)),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => accountInformation()));
                      },
                      icon: const Icon(Icons.arrow_forward_ios),
                      color: const Color.fromARGB(255, 75, 74, 74),
                      iconSize: 22,
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Color.fromARGB(255, 75, 74, 74)))),
                ),
                Row(
                  children: [
                    const Padding(padding: EdgeInsets.only(left: 10)),
                    IconButton(
                      onPressed: deleteAccount,
                      icon: const Icon(Icons.delete),
                      iconSize: 33,
                      color: const Color.fromARGB(255, 75, 74, 74),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 10)),
                    TextButton(
                        onPressed: deleteAccount,
                        child: const Text('Delete Account',
                            style: TextStyle(
                                color: Color.fromARGB(255, 75, 74, 74),
                                fontSize: 21,
                                fontWeight: FontWeight.normal))),
                    const Padding(padding: EdgeInsets.only(left: 125)),
                    IconButton(
                      onPressed: deleteAccount,
                      icon: const Icon(Icons.arrow_forward_ios),
                      color: const Color.fromARGB(255, 75, 74, 74),
                      iconSize: 22,
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Color.fromARGB(255, 75, 74, 74)))),
                ),
              ],
            )));
  }

  void changeName() {
    entry = OverlayEntry(
        builder: (context) => Scaffold(
            resizeToAvoidBottomInset: false,
            body: Card(
              margin: const EdgeInsets.all(0),
              color: Colors.black54.withOpacity(0.1),
              child: Column(children: [
                const SizedBox(height: 200),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 30),
                ),
                Container(
                    padding: const EdgeInsets.all(10),
                    color:
                        const Color.fromARGB(31, 95, 95, 95).withOpacity(0.8),
                    child: Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(top: 10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FutureBuilder<Users?>(
                                  future: Users.readUser(user.uid),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      final users = snapshot.data!;
                                      return SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Text(
                                                'Your Current Name is ' +
                                                    users.name,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 21)),
                                            const SizedBox(height: 50),
                                            TextFormField(
                                              controller: name,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              validator: (name) => name !=
                                                          null &&
                                                      name.length < 3
                                                  ? 'Enter 3 characters atleast'
                                                  : null,
                                              decoration: InputDecoration(
                                                hintText: 'Enter your new name',
                                                fillColor: Colors.white,
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Colors
                                                                    .blue)),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                        borderSide:
                                                            const BorderSide(
                                                                color:
                                                                    Colors.red,
                                                                width: 2)),
                                                hintStyle: const TextStyle(
                                                    color: Colors.grey,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ),
                                            const SizedBox(height: 60),
                                            ElevatedButton(
                                                onPressed: () {
                                                  final docUser =
                                                      FirebaseFirestore.instance
                                                          .collection('Users')
                                                          .doc(user.uid);
                                                  if (name.text.length < 3) {
                                                    snackBar.showSnackBarRed(
                                                        'Invalid Input');
                                                  } else {
                                                    docUser.update(
                                                        {'name': name.text});
                                                    hideMenu();
                                                    snackBar.showSnackBarGreen(
                                                        'Name Updated Successfully');
                                                  }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  primary: const Color.fromARGB(
                                                      232, 147, 160, 172),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 150,
                                                          right: 150),
                                                  textStyle: const TextStyle(
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                child: const Text(
                                                  "ok",
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 0, 94, 170),
                                                      fontSize: 21),
                                                )),
                                          ],
                                        ),
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
                                              decoration:
                                                  BoxDecoration(color: color));
                                        },
                                      ));
                                    }
                                  })
                            ]))),
                const SizedBox(height: 40),
                ElevatedButton.icon(
                  onPressed: hideMenu,
                  icon: const Icon(Icons.visibility_off),
                  label: const Text('back'),
                )
              ]),
            )));

    final overlay = Overlay.of(context);
    overlay?.insert(entry!);
  }

  void changeUserName() {
    entry = OverlayEntry(
        builder: (context) => Scaffold(
            resizeToAvoidBottomInset: false,
            body: Card(
              margin: const EdgeInsets.all(0),
              color: Colors.black54.withOpacity(0.1),
              child: Column(children: [
                const SizedBox(height: 200),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 30),
                ),
                Container(
                    padding: const EdgeInsets.all(10),
                    color:
                        const Color.fromARGB(31, 95, 95, 95).withOpacity(0.8),
                    child: Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(top: 10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FutureBuilder<Users?>(
                                  future: Users.readUser(user.uid),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      final users = snapshot.data!;
                                      return SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Text(
                                                'Your Current Username is ' +
                                                    users.username,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 21)),
                                            const SizedBox(height: 50),
                                            TextFormField(
                                              controller: username,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              decoration: InputDecoration(
                                                hintText:
                                                    'Enter your new username',
                                                fillColor: Colors.white,
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Colors
                                                                    .blue)),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                        borderSide:
                                                            const BorderSide(
                                                                color:
                                                                    Colors.red,
                                                                width: 2)),
                                                hintStyle: const TextStyle(
                                                    color: Colors.grey,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ),
                                            const SizedBox(height: 60),
                                            ElevatedButton(
                                                onPressed: () async {
                                                  final valid = await Users
                                                      .availableUsername(
                                                          username.text);
                                                  if (!valid) {
                                                    snackBar.showSnackBarRed(
                                                        'User already registered');
                                                  } else {
                                                    final docUser =
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection('Users')
                                                            .doc(user.uid);
                                                    docUser.update({
                                                      'username': username.text
                                                    });
                                                    hideMenu();
                                                    snackBar.showSnackBarGreen(
                                                        'Username Updated Successfully');
                                                  }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  primary: const Color.fromARGB(
                                                      232, 147, 160, 172),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 150,
                                                          right: 150),
                                                  textStyle: const TextStyle(
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                child: const Text(
                                                  "ok",
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 0, 94, 170),
                                                      fontSize: 21),
                                                )),
                                          ],
                                        ),
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
                                              decoration:
                                                  BoxDecoration(color: color));
                                        },
                                      ));
                                    }
                                  })
                            ]))),
                const SizedBox(height: 40),
                ElevatedButton.icon(
                  onPressed: hideMenu,
                  icon: const Icon(Icons.visibility_off),
                  label: const Text('back'),
                )
              ]),
            )));

    final overlay = Overlay.of(context);
    overlay?.insert(entry!);
  }

  void changePassword() {
    entry = OverlayEntry(
        builder: (context) => Scaffold(
            resizeToAvoidBottomInset: false,
            body: Card(
              margin: const EdgeInsets.all(0),
              color: Colors.black54.withOpacity(0.1),
              child: Column(children: [
                const SizedBox(height: 200),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 30),
                ),
                Container(
                    padding: const EdgeInsets.all(10),
                    color:
                        const Color.fromARGB(31, 95, 95, 95).withOpacity(0.8),
                    child: Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(top: 10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FutureBuilder<Users?>(
                                  future: Users.readUser(user.uid),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      final users = snapshot.data!;
                                      return SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            const Text('Change Password',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 21)),
                                            const SizedBox(height: 50),
                                            TextFormField(
                                              controller: password,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              obscureText: true,
                                              validator: (password) => password !=
                                                          null &&
                                                      password.length < 6
                                                  ? 'Enter 6 characters atleast'
                                                  : null,
                                              decoration: InputDecoration(
                                                hintText:
                                                    'Enter your new password',
                                                fillColor: Colors.white,
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Colors
                                                                    .blue)),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                        borderSide:
                                                            const BorderSide(
                                                                color:
                                                                    Colors.red,
                                                                width: 2)),
                                                hintStyle: const TextStyle(
                                                    color: Colors.grey,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ),
                                            TextFormField(
                                              controller: confirmPassword,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              obscureText: true,
                                              validator: (conPass) =>
                                                  conPass != password.text
                                                      ? 'Password unmatched'
                                                      : null,
                                              decoration: InputDecoration(
                                                hintText: 'Confirm password',
                                                fillColor: Colors.white,
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Colors
                                                                    .blue)),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                        borderSide:
                                                            const BorderSide(
                                                                color:
                                                                    Colors.red,
                                                                width: 2)),
                                                hintStyle: const TextStyle(
                                                    color: Colors.grey,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ),
                                            const SizedBox(height: 60),
                                            ElevatedButton(
                                                onPressed: () {
                                                  if (password.text.length >=
                                                          6 &&
                                                      confirmPassword.text ==
                                                          password.text) {
                                                    hideMenu();
                                                    user.updatePassword(
                                                        password.text);

                                                    snackBar.showSnackBarGreen(
                                                        'Password Updated');
                                                  } else {
                                                    snackBar.showSnackBarRed(
                                                        'Invalid Input');
                                                  }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  primary: const Color.fromARGB(
                                                      232, 147, 160, 172),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 150,
                                                          right: 150),
                                                  textStyle: const TextStyle(
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                child: const Text(
                                                  "ok",
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 0, 94, 170),
                                                      fontSize: 21),
                                                )),
                                          ],
                                        ),
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
                                              decoration:
                                                  BoxDecoration(color: color));
                                        },
                                      ));
                                    }
                                  })
                            ]))),
                const SizedBox(height: 40),
                ElevatedButton.icon(
                  onPressed: hideMenu,
                  icon: const Icon(Icons.visibility_off),
                  label: const Text('back'),
                )
              ]),
            )));

    final overlay = Overlay.of(context);
    overlay?.insert(entry!);
  }

  void deleteAccount() {
    entry = OverlayEntry(
        builder: (context) => Scaffold(
            resizeToAvoidBottomInset: false,
            body: Card(
              margin: const EdgeInsets.all(0),
              color: Colors.black54.withOpacity(0.1),
              child: Column(children: [
                const SizedBox(height: 200),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 30),
                ),
                Container(
                    padding: const EdgeInsets.all(10),
                    color:
                        const Color.fromARGB(31, 95, 95, 95).withOpacity(0.8),
                    child: Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(top: 10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FutureBuilder<Users?>(
                                  future: Users.readUser(user.uid),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      final users = snapshot.data!;
                                      return SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Text(
                                                ''' Are you sure you want to delete your account ?

  if yes please enter your username "${users.username}"''',
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 21)),
                                            const SizedBox(height: 50),
                                            TextFormField(
                                              controller: username,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              decoration: InputDecoration(
                                                hintText:
                                                    'Enter your new username',
                                                fillColor: Colors.white,
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Colors
                                                                    .blue)),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                        borderSide:
                                                            const BorderSide(
                                                                color:
                                                                    Colors.red,
                                                                width: 2)),
                                                hintStyle: const TextStyle(
                                                    color: Colors.grey,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ),
                                            const SizedBox(height: 60),
                                            ElevatedButton(
                                                onPressed: () {
                                                  final docUser =
                                                      FirebaseFirestore.instance
                                                          .collection('Users')
                                                          .doc(user.uid);
                                                  if (username.text ==
                                                      users.username) {
                                                    user.delete();
                                                    docUser.delete();
                                                    hideMenu();
                                                    snackBar.showSnackBarGreen(
                                                        'Account Deleted');
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                homePage()));
                                                  } else {
                                                    hideMenu();
                                                    snackBar.showSnackBarRed(
                                                        'Invalid Input');
                                                  }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  primary: const Color.fromARGB(
                                                      232, 147, 160, 172),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 150,
                                                          right: 150),
                                                  textStyle: const TextStyle(
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                child: const Text(
                                                  "ok",
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 0, 94, 170),
                                                      fontSize: 21),
                                                )),
                                          ],
                                        ),
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
                                              decoration:
                                                  BoxDecoration(color: color));
                                        },
                                      ));
                                    }
                                  })
                            ]))),
                const SizedBox(height: 40),
                ElevatedButton.icon(
                  onPressed: hideMenu,
                  icon: const Icon(Icons.visibility_off),
                  label: const Text('back'),
                )
              ]),
            )));

    final overlay = Overlay.of(context);
    overlay?.insert(entry!);
  }

  void hideMenu() {
    entry?.remove();
    entry = null;
  }
}
