import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:safra/backend/snackBar.dart';
import 'package:safra/backend/storage.dart';
import 'package:safra/objects/user.dart';
import 'package:safra/ui/ContactUs.dart';
import 'package:safra/ui/FAQ.dart';
import 'package:safra/ui/dashboardn.dart';
import 'package:safra/ui/homePage.dart';
import 'package:safra/ui/mention.dart';
import 'package:safra/ui/schedule1.dart';
import 'package:safra/ui/search.dart';
import 'package:safra/ui/stngs.dart';
import 'package:safra/ui/travelHistory.dart';

class accountInformation extends StatefulWidget {
  const accountInformation({Key? key}) : super(key: key);

  @override
  State<accountInformation> createState() => _accountInformation();
}

class _accountInformation extends State<accountInformation> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  OverlayEntry? entry;

  Future pickImage() async {
    try {
      // final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      final image = await FilePicker.platform.pickFiles(
          allowMultiple: false,
          type: FileType.custom,
          allowedExtensions: ['png', 'jpg']);
      if (image == null) return;

      final imgPath = image.files.single.path!;
      final imgName = user.uid.toString();

      Storage.uploadFile(imgPath, imgName).then((value) => print('uploaded'));
      // setState(() {
      //   this.image = File(image.path);
      // });
    } on PlatformException catch (e) {
      snackBar.showSnackBarRed('Failed to pick image$e');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: FutureBuilder<Users?>(
            future: Users.readUser(user.uid),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final users = snapshot.data!;
                return Scaffold(
                    resizeToAvoidBottomInset: false,
                    body: SafeArea(
                        child: Container(
                            height: 1000,
                            //start conatiner for whole page
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage(
                                  'images/BackgroundPics/backgroundprofile (4).png'),
                              fit: BoxFit.cover,
                            )),
                            child: Column(children: [
                              //start column for whole page
                              Row(
                                children: [
                                  Container(
                                      width: 33,
                                      height: 33,
                                      margin:
                                          const EdgeInsets.fromLTRB(5, 1, 1, 1),
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      child: IconButton(
                                        icon: const Icon(Icons.menu),
                                        iconSize: 20,
                                        onPressed: menu,
                                      )),
                                ],
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              FutureBuilder(
                                  future: Storage.readImage(user.uid),
                                  builder: (BuildContext context, snapshot) {
                                    if (snapshot.connectionState ==
                                            ConnectionState.done &&
                                        snapshot.hasData) {
                                      return Container(
                                          child: Column(children: [
                                        Container(
                                          width: 150,
                                          height: 150,
                                          child: CircleAvatar(
                                              radius: 50,
                                              child: ClipOval(
                                                  child: Image.network(
                                                snapshot.data!.toString(),
                                                fit: BoxFit.fill,
                                                width: 150,
                                                height: 150,
                                              ))),
                                        ),
                                      ]));
                                    } else if (!snapshot.hasData) {
                                      return const Icon(
                                        Icons.person,
                                        size: 150,
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
                                  }),
                              const SizedBox(height: 10),
                              Container(
                                  padding: const EdgeInsets.only(left: 170),
                                  child: buildButton(
                                      icon: Icons.edit, callBack: pickImage)),

                              Container(
                                //start of username,acoount information ,travel history,save,navigation bar
                                height: 500,
                                width: 500,

                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      //start of username,acoount information ,travel history,save,navigation bar
                                      Text(users.name,
                                          style: const TextStyle(fontSize: 19)),
                                      (Text("@" + users.username,
                                          style:
                                              const TextStyle(fontSize: 19))),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          TextButton(
                                            //For Account information button
                                            style: TextButton.styleFrom(
                                              textStyle: const TextStyle(
                                                fontSize: 13,
                                                color: Colors.black,
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationColor: Color.fromARGB(
                                                    255, 10, 50, 130),
                                                decorationThickness: 2.9,
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const accountInformation()));
                                            },
                                            child: const Text(
                                              'Account Information',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0)),
                                            ),
                                          ),
                                          TextButton(
                                            //For Travel history  button
                                            style: TextButton.styleFrom(
                                              textStyle: const TextStyle(),
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const travelHistory()));
                                            },
                                            child: const Text(
                                              'Travel History',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0)),
                                            ),
                                          ),
                                        ],
                                      ),

                                      Row(
                                        // start for 2 container (name,email)
                                        children: [
                                          Container(
                                            //start for  container (name)
                                            margin:
                                                const EdgeInsets.only(left: 50),
                                            height: 115,

                                            width: 140,
                                            padding: const EdgeInsets.only(
                                                left: 19, top: 27),
                                            decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15)),
                                                color: Color.fromARGB(
                                                    255, 77, 189, 224)),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: const [
                                                    Expanded(
                                                        child: Text(
                                                      'Name',
                                                      style: TextStyle(
                                                          fontSize: 19),
                                                    )),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                        child: Text(
                                                      users.name,
                                                      style: const TextStyle(
                                                          fontSize: 15),
                                                    )),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ), //End for  container (name)
                                          Container(
                                            //start for  container (email)
                                            margin:
                                                const EdgeInsets.only(left: 55),
                                            height: 115,

                                            width: 140,
                                            padding: const EdgeInsets.only(
                                                left: 11, top: 27),
                                            decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15)),
                                                color: Color.fromARGB(
                                                    255, 77, 189, 224)),
                                            child: Column(
                                              //has contents of container email
                                              children: [
                                                Row(
                                                  children: const [
                                                    Expanded(
                                                        child: Text(
                                                      'Email',
                                                      style: TextStyle(
                                                          fontSize: 19),
                                                    )),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                        child: Text(
                                                      user.email.toString(),
                                                      style: const TextStyle(
                                                          fontSize: 15),
                                                    )),
                                                  ],
                                                )
                                              ],
                                            ), //end contents of container (email)
                                          ), //End for  container (email)
                                        ],
                                      ), // end for 2 container (name,email)
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      //space between row of name,email
                                      Row(
                                        //start for 2 containers (Joined date,username)
                                        children: [
                                          Container(
                                            //start for  container (Joined date)
                                            margin:
                                                const EdgeInsets.only(left: 49),
                                            height: 115,
                                            width: 140,
                                            padding: const EdgeInsets.only(
                                                top: 27, left: 19),
                                            decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15)),
                                                color: Color.fromARGB(
                                                    255, 77, 189, 224)),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: const [
                                                    Expanded(
                                                        child: Text(
                                                      'Joined date',
                                                      style: TextStyle(
                                                          fontSize: 19),
                                                    )),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                        child: Text(
                                                      user.metadata.creationTime
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 15),
                                                    )),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ), //End for  container (Joined date)

                                          Container(
                                            //start for  container (username)
                                            margin:
                                                const EdgeInsets.only(left: 58),

                                            height: 115,
                                            width: 140,
                                            padding: const EdgeInsets.only(
                                                top: 27, left: 14),
                                            decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15)),
                                                color: Color.fromARGB(
                                                    255, 77, 189, 224)),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: const [
                                                    Expanded(
                                                        child: Text(
                                                      'Username',
                                                      style: TextStyle(
                                                          fontSize: 19),
                                                    )),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                        child: Text(
                                                      '@${users.username}',
                                                      style: const TextStyle(
                                                          fontSize: 15),
                                                    )),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ), //End for  container (username)
                                        ],
                                      ),
                                      //End for 2 containers Joined date ,username)
                                      Container(
                                        margin: EdgeInsets.only(top: 22),
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
                                                  'images/NavigationBar/DashboardActive.jpg'),
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
                                                    padding: const EdgeInsets
                                                            .fromLTRB(
                                                        27.5, 0.2, 30, 70),
                                                    child: CircleAvatar(
                                                        radius: 24,
                                                        backgroundColor:
                                                            const Color
                                                                    .fromARGB(
                                                                255,
                                                                250,
                                                                101,
                                                                2),
                                                        child: IconButton(
                                                          icon: const Icon(
                                                              Icons.search,
                                                              color:
                                                                  Colors.white),
                                                          iconSize: 31,
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(0.2),
                                                          onPressed: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
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
                                                  'images/NavigationBar/Schedule.jpg'),
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
                                                            accountInformation()));
                                              },
                                              icon: Image.asset(
                                                  'images/NavigationBar/Profile.jpg'),
                                              iconSize: 55,
                                              padding: const EdgeInsets.only(
                                                  left: 10, bottom: 26),
                                            ),
                                          ],
                                        ),
                                      ) //end of navigation bar
                                    ]), //end column  of username,account information ,travel history,save,navigation bar
                              ), //end conatiner  of username,account information ,travel history,save,navigation bar
                            ]) //end column of whole page
                            ) //end container of whole page
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

  Widget buildButton(
          {required IconData icon, required VoidCallback callBack}) =>
      IconButton(
        onPressed: callBack,
        icon: const Icon(Icons.edit, size: 30),
      );
}
