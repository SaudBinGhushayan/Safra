import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:safra/ui/accountInformation.dart';
import 'package:safra/ui/dashboardn.dart';
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
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        height: 900,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('images/BackgroundPics/background.jpg'),
          fit: BoxFit.cover,
        )),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                    width: 33,
                    height: 33,
                    margin: const EdgeInsets.fromLTRB(5, 4, 1, 1),
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
              height: 16,
            ),
            SizedBox(
              height: 34,
            ),
            Container(
              margin: EdgeInsets.only(top: 14.7),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(40),
                  ),
                  color: Colors.white),
              child: const TextField(
                style: TextStyle(),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(40),
                      ),
                    ),
                    hintText: 'Explore new trip',
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: const Icon(Icons.search,
                        color: Color.fromARGB(255, 102, 101, 101))),
              ),
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10, top: 99),
                  height: 60,
                  width: 150,
                  child: Text(
                    "Most Liked Trips",
                    style: TextStyle(fontSize: 20),
                  ),
                )
              ],
            ),
            Container(
              //start of navigation bar
              margin: const EdgeInsets.only(top: 339),
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
                    onPressed: () {},
                    icon: Image.asset('images/NavigationBar/Mention.jpg'),
                    iconSize: 55,
                    padding: const EdgeInsets.only(left: 14, bottom: 29),
                  ),
                  Container(
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(27.5, 0.2, 30, 70),
                          child: CircleAvatar(
                              radius: 24,
                              backgroundColor: Color.fromARGB(255, 39, 97, 213),
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
                              builder: (context) => accountInformation()));
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
    ));
  }
}
