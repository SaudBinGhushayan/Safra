import 'package:flutter/material.dart';

class dashboardn extends StatefulWidget {
  const dashboardn({Key? key}) : super(key: key);

  @override
  State<dashboardn> createState() => _dashboardnState();
}


class _dashboardnState extends State<dashboardn> {
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

      child: Column(
        children: [
          Row(
            //menu icon
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
                //profile icon
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
            ], //end1st row
          ),
          Row(
            //2ndrow
            children: [
              Container(
                  //Your next activity
                  width: 210,
                  height: 30,
                  margin: EdgeInsets.only(left: 14, top: 150),
                  decoration: BoxDecoration(),
                  child: Text(
                    "Your next activity",
                    style: TextStyle(fontSize: 22),
                  ),
                  alignment: Alignment.center),
              Container(
                //See all
                width: 50,
                margin: EdgeInsets.only(left: 60, top: 150, right: 1),
                //  decoration:
                //   BoxDecoration(border: Border.all(color: Colors.red)),
                child: Text(
                  "See all",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Container(
                //arrowbutton
                //  decoration:
                // BoxDecoration(border: Border.all(color: Colors.red)),

                margin: EdgeInsets.only(
                  left: 7,
                  top: 150,
                ),
                child: IconButton(
                  iconSize: 10,
                  onPressed: () {},
                  icon: Image.asset("images/see all arrow.png"),
                ),
              ),
            ],
          ),
          Row(
            //3rdrow
            children: [
              Container(
                  //My Trips
                  width: 170,
                  height: 30,
                  margin: EdgeInsets.only(left: 14, top: 242),
                  // decoration:
                  //   BoxDecoration(border: Border.all(color: Colors.blue)),
                  child: Text(
                    "My trips",
                    style: TextStyle(fontSize: 22),
                  ),
                  alignment: Alignment.center),
              Container(
                //See all
                width: 50,
                margin: EdgeInsets.only(left: 93, top: 241, right: 1),
                //  decoration:
                //  BoxDecoration(border: Border.all(color: Colors.red)),
                child: Text(
                  "See all",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Container(
                //arrowbutton
                // decoration:
                //   BoxDecoration(border: Border.all(color: Colors.red)),

                margin: EdgeInsets.only(
                  left: 7,
                  top: 241,
                ),
                child: IconButton(
                  iconSize: 10,
                  onPressed: () {},
                  icon: Image.asset("images/see all arrow.png"),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 132),
            height: 90,
            width: 360,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/bottomnavigatiobar.jpg"))),
            child: Row(
              children: [
                IconButton(
                  alignment: Alignment.topCenter,
                  onPressed: () {},
                  icon: Image.asset('images/dashboradbutton .jpg'),
                  iconSize: 45,
                  padding: EdgeInsets.only(top: 9, left: 14),
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
                  icon: Image.asset('images/greyschedule.jpg'),
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
      ),
    ));
  }
}