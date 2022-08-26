import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:dot_navigation_bar/dot_navigation_bar.dart';

class dashboardn extends StatefulWidget {
  const dashboardn({super.key});
  @override
  State<dashboardn> createState() => _dashboardn();
}

class _dashboardn extends State<dashboardn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      body: Container(
        //////1st column
        width: 900,

        height: 870,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
              'images/Desktop Screenshot 2022.08.24 - 05.25.43.34 (2).png'),
          fit: BoxFit.cover,
        )),

        child: Column(children: [
          Row(
            children: [
              Container(
                  width: 33,
                  height: 33,
                  margin: EdgeInsets.fromLTRB(5, 69.4, 1, 1),
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
                width: 132,
                margin: EdgeInsets.fromLTRB(202, 70, 3, 1),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
//IconButton(onPressed: (){}, icon:Image.asset('images/9b2924c63e033aa31efbca99d02622de3f15f501.png'),
//iconSize: 24,

                    Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                'images/9b2924c63e033aa31efbca99d02622de3f15f501.png')),
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),

                    Expanded(child: Text("abdulmalik "))
                  ],
                ),
              )
            ],
          ),
          Container(
            width: 290,
            height: 69,
            margin: EdgeInsets.fromLTRB(5, 217, 1, 5),
            decoration: BoxDecoration(
              color: Color.fromARGB(206, 6, 39, 116),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              'Join',
              style: TextStyle(
                fontFamily: 'Curisve',
                fontSize: 44,
                color: Colors.white,
              ),
            ),
            alignment: Alignment.center,
          ),
          Container(
            width: 290,
            height: 69,
            margin: EdgeInsets.fromLTRB(5, 90, 1, 5),
            decoration: BoxDecoration(
              color: Color.fromARGB(206, 6, 39, 116),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              'Create',
              style: TextStyle(
                fontFamily: 'Curisve',
                fontSize: 44,
                color: Colors.white,
              ),
            ),
            alignment: Alignment.center,
          ),

          //bottomnavigationbar
          Container(
            margin: EdgeInsets.only(top: 83),
            height: 90,
            width: 360,
            decoration: BoxDecoration(
                border: Border.all(color: Color.fromARGB(255, 150, 111, 108)),
                image: DecorationImage(
                    image:
                        AssetImage("images/Screenshot 2022-08-26 190849.jpg"))),
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
                IconButton(
                  onPressed: () {},
                  icon: Image.asset('images/Search button.png'),
                  iconSize: 43,
                  padding: EdgeInsets.fromLTRB(33, 0.2, 22, 34),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Image.asset('images/Schedu.jpg'),
                  iconSize: 39,
                  padding: EdgeInsets.only(left: 0.2, right: 17),
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
        ]),

        //End White container
      ),

      // extendBody: true,
      // bottomNavigationBar: Padding(
      //   padding: EdgeInsets.only(bottom: 10),
      //   child: DotNavigationBar(
      //       margin: EdgeInsets.only(left: 10, right: 10),
      //       currentIndex: _SelectedTab.values.indexOf(_selectedTab),
      //       dotIndicatorColor: Colors.black,
      //       unselectedItemColor: Color.fromARGB(255, 136, 127, 127),
      //       onTap: handleIndexChanged,
      //       items: [
      //         DotNavigationBarItem(
      //           icon: Icon(Icons.home),
      //           selectedColor: Color.fromARGB(255, 0, 0, 0),
      //         ),
      //         DotNavigationBarItem(
      //           icon: Icon(Icons.favorite),
      //           selectedColor: Color.fromARGB(255, 0, 0, 0),
      //         ),
      //         DotNavigationBarItem(
      //           icon: Icon(Icons.shopping_bag),
      //           selectedColor: Color.fromARGB(255, 0, 0, 0),
      //         ),
      //         DotNavigationBarItem(
      //           icon: Icon(Icons.person),
      //           selectedColor: Color.fromARGB(255, 0, 0, 0),
      //         ),
      //       ]),
      // )
      //
      //
      //
    );
  }
}
