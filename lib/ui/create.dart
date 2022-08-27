import 'dart:ui';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class create extends StatefulWidget {
  const create({Key? key}) : super(key: key);

  @override
  State<create> createState() => _createState();
}

class _createState extends State<create> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
      //////1st column
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage('images/background.jpg'),
        fit: BoxFit.cover,
      )),

      child: Column(children: [
        Row(
          children: [
            Container(
                width: 33,
                height: 33,
                margin: EdgeInsets.fromLTRB(5, 40.5, 1, 1),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Icon(
                  Icons.menu,
                  size: 20,
                )),
            SizedBox(
              height: 90,
            ),
            Container(
              height: 50,
              width: 140,
              margin: EdgeInsets.fromLTRB(228, 47.8, 1, 1),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Row(
                children: [
                  Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/Arabian guy.jpg')),
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  Expanded(child: Text("abdulmalik "))
                ],
              ),
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Where To Go?",
                  style: TextStyle(
                      color: Color.fromARGB(255, 49, 47, 47),
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                )
              ],
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(40),
                  ),
                  color: Colors.white),
              child: TextField(
                style: TextStyle(),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(40),
                      ),
                    ),
                    hintText: 'dubai',
                    prefixIcon: Icon(Icons.search, color: Colors.black)),
              ),
            ),
            Row(
              children: [
                Container(
                  width: 140,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red),
                  ),
                  margin: EdgeInsets.only(top: 100, left: 20),
                  child: Text(
                    'categories',
                    style: TextStyle(fontSize: 27),
                  ),
                )
              ],
            ),
            Row(children: [
              Container(
                  width: 96,
                  height: 41,
                  margin: EdgeInsets.only(left: 60, top: 47),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      ),
                      color: Colors.grey),
                  child: Text(
                    "Activites",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  alignment: Alignment.center),
              Container(
                  width: 96,
                  height: 41,
                  margin: EdgeInsets.only(left: 60, top: 47),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      ),
                      color: Colors.grey),
                  child: Text(
                    "Places",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  alignment: Alignment.center)
            ]),
            Container(
              margin: EdgeInsets.only(top: 290),
              height: 90,
              width: 360,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/bottomnavigatiobar.jpg"))),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset('images/homebutton.jpg'),
                    iconSize: 35,
                    padding: EdgeInsets.only(left: 24, bottom: 8),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset('images/mention iccon.jpg'),
                    iconSize: 39,
                    padding: EdgeInsets.only(left: 32),
                  ),
                  Container(
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(33, 0.2, 22, 34),
                          child: CircleAvatar(
                              radius: 25,
                              backgroundColor: Color.fromARGB(255, 250, 101, 2),
                              child: IconButton(
                                icon: Icon(Icons.search, color: Colors.white),
                                iconSize: 35,
                                onPressed: () {},
                              )))),
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset('images/Schedu.jpg'),
                    iconSize: 39,
                    padding: EdgeInsets.only(left: 0.2, right: 17),
                    highlightColor: Colors.white,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset('images/profile button.jpg'),
                    iconSize: 39,
                    padding: EdgeInsets.only(right: 1, left: 18),
                  ),
                ],
              ),
            )
          ],
        )
      ]),
    ));
  }
}
