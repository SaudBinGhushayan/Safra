import 'package:flutter/material.dart';

class schedule1 extends StatefulWidget {
  const schedule1({super.key});
  @override
  State<schedule1> createState() => _schedule1();
}

class _schedule1 extends State<schedule1> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: Drawer(),
      body: Container(
        //////1st column
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('images/backgroundimage.png'),
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
          SizedBox(
            height: 50,
          ),

          //bottomnavigationbar
          Container(
            margin: EdgeInsets.only(top: 83),
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
        ]),
      ),
    );
  }
}
