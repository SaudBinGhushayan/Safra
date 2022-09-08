import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:safra/backend/storage.dart';
import 'package:safra/objects/user.dart';
import 'package:safra/ui/dashboardn.dart';

import 'package:safra/ui/schedule1.dart';
import 'package:safra/ui/search.dart';
import 'package:safra/ui/accountInformation.dart';

class travelhistory extends StatefulWidget {
  const travelhistory({Key? key}) : super(key: key);

  @override
  State<travelhistory> createState() => _travelhistory();
}

class _travelhistory extends State<travelhistory> {
  @override
  String activetrip = '4';
  String numofactivity = '25';
  String tripterminated = '7 ';
  String likes = '9 ';

  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                height: 4900,
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
                          margin: const EdgeInsets.fromLTRB(5, 1, 1, 1),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.menu),
                            iconSize: 20,
                            onPressed: () {},
                          )),
                      Container(
                        //profile icon
                        height: 50,
                        width: 140,
                        margin: const EdgeInsets.fromLTRB(228, 5, 1, 1),
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
                            ),
                            Expanded(child: Text('from database'))
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Center(
                      //start profile image
                      child: Container(
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.white),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              "https://images.unsplash.com/photo-1583864697784-a0efc8379f70?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTd8fG1hbnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60"),
                        )),
                  )),
                  SizedBox(
                    //space between profile image +edit icon(Pen)
                    height: 27,
                  ),
                  Container(
                    //start of username,acoount information ,travel history,save,navigation bar
                    height: 560,
                    width: 500,

                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      //start of username,acoount information ,travel history,save,navigation bar
                      Text("3bdol", style: TextStyle()),
                      (Text("@Aldobh", style: TextStyle())),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            //For Account information button
                            style: TextButton.styleFrom(
                              textStyle: const TextStyle(
                                fontSize: 13,
                                color: Colors.black,
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
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                          ),
                          TextButton(
                            //For Travel history  button
                            style: TextButton.styleFrom(
                              textStyle: const TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor:
                                    Color.fromARGB(255, 10, 50, 130),
                                decorationThickness: 2.9,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const travelhistory()));
                            },
                            child: const Text(
                              'Travel History',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                          ),
                        ],
                      ),

                      Row(
                        // start for 2 container (Active trip,number of activity)
                        children: [
                          Container(
                            //start for  container (activetrip)
                            margin: EdgeInsets.only(left: 50),
                            height: 115,

                            width: 140,
                            padding: EdgeInsets.only(left: 0, top: 15),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                color: Color.fromARGB(255, 77, 189, 224)),
                            child: Column(
                              children: [
                                Text(
                                  'Active Trip',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(fontSize: 17),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text('1', style: TextStyle(fontSize: 15))
                              ],
                            ),
                          ), //End for  container (activetrip)
                          Container(
                            //start for  container (number of activity)
                            margin: EdgeInsets.only(left: 55),
                            height: 115,

                            width: 140,
                            padding: EdgeInsets.only(left: 11, top: 15),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                color: Color.fromARGB(255, 77, 189, 224)),
                            child: Column(
                              //has contents of container num of activity
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      'number of Activity',
                                      style: TextStyle(fontSize: 17),
                                    )),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      '25',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 15),
                                    )),
                                  ],
                                )
                              ],
                            ), //end contents of container (num of activity)
                          ), //End for  container (num of activity)
                        ],
                      ), // end for 2 container (active trip,num of activity)
                      SizedBox(
                        height: 15,
                      ),
                      //space between row of active trip,num of activity
                      Row(
                        //start for 2 containers (trip termainted,likes)
                        children: [
                          Container(
                            //start for  container (trip termainted)
                            margin: EdgeInsets.only(left: 49),
                            height: 115,
                            width: 140,
                            padding: EdgeInsets.only(top: 27, left: 9),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                color: Color.fromARGB(255, 77, 189, 224)),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      'Trips terminated',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(fontSize: 16),
                                    )),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      '7',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 15),
                                    )),
                                  ],
                                )
                              ],
                            ),
                          ), ////End for  container (trip termainted)

                          Container(
                            //start for  container (likes)
                            margin: EdgeInsets.only(left: 58),

                            height: 115,
                            width: 140,
                            padding: EdgeInsets.only(top: 27, left: 5),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                color: Color.fromARGB(255, 77, 189, 224)),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      'Likes',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 16),
                                    )),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      '9',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 15),
                                    )),
                                  ],
                                )
                              ],
                            ),
                          ), //End for  container (likes)
                        ],
                      ),
                      //End for 2 containers (trip termainted,likes)

                      Container(
                        //start of navigation bar
                        margin: const EdgeInsets.only(top: 54),
                        padding: EdgeInsets.only(bottom: 0),
                        height: 176,
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
                              padding:
                                  const EdgeInsets.only(left: 29, bottom: 29),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Image.asset(
                                  'images/NavigationBar/Mention.jpg'),
                              iconSize: 55,
                              padding:
                                  const EdgeInsets.only(left: 14, bottom: 29),
                            ),
                            Container(
                                child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        27, 0.2, 30, 64),
                                    child: CircleAvatar(
                                        radius: 24,
                                        backgroundColor: const Color.fromARGB(
                                            255, 250, 101, 2),
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
                                        builder: (context) =>
                                            const schedule1()));
                              },
                              icon: Image.asset(
                                  'images/NavigationBar/Schedule.jpg'),
                              iconSize: 55,
                              padding:
                                  const EdgeInsets.only(left: 1, bottom: 29),
                              highlightColor: Colors.white,
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const travelhistory()));
                              },
                              icon: Image.asset(
                                  'images/NavigationBar/ProfileActive.jpg'),
                              iconSize: 55,
                              padding:
                                  const EdgeInsets.only(left: 10, bottom: 26),
                            ),
                          ],
                        ),
                      ) //end of navigation bar
                    ]), //end column  of username,account information ,travel history,,navigation bar
                  ), //end conatiner  of username,account information ,travel history,,navigation bar
                ]) //end column of whole page
                ) //end container of whole page
            ));
  }
}
