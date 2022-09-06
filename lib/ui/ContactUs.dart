// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:safra/backend/authError.dart';
import 'package:safra/ui/dashboardn.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class contactUs extends StatefulWidget {
  const contactUs({Key? key}) : super(key: key);

  @override
  State<contactUs> createState() => _contactUsState();
}

class _contactUsState extends State<contactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                                builder: (context) => const dashboardn()));
                      })),
              const SizedBox(height: 20),
              const Text(''' Contact Us''',
                  style: TextStyle(
                      fontSize: 33, color: Color.fromARGB(255, 75, 74, 74))),
              const SizedBox(height: 80),
              Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Padding(padding: EdgeInsets.all(10)),
                  const Icon(Icons.person, size: 30),
                  const Padding(padding: EdgeInsets.only(left: 30)),
                  const Text(
                    'Saud Bin Ghushayan',
                    style: TextStyle(
                        color: Color.fromARGB(255, 75, 74, 74), fontSize: 23),
                  ),
                ],
              ),
              Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Padding(padding: EdgeInsets.all(10)),
                  const Icon(Icons.email, size: 30),
                  const Padding(padding: EdgeInsets.only(left: 20)),
                  Text(
                    '439102666@student.ksu.edu.sa',
                    style: TextStyle(
                        color: Color.fromARGB(255, 75, 74, 74),
                        fontSize: 20,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Padding(padding: EdgeInsets.all(10)),
                  const Icon(Icons.person, size: 30),
                  const Padding(padding: EdgeInsets.only(left: 30)),
                  const Text(
                    'Abdullah Alkhalifah',
                    style: TextStyle(
                        color: Color.fromARGB(255, 75, 74, 74), fontSize: 23),
                  ),
                ],
              ),
              Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Padding(padding: EdgeInsets.all(10)),
                  const Icon(Icons.email, size: 30),
                  const Padding(padding: EdgeInsets.only(left: 20)),
                  Text(
                    '439101707@student.ksu.edu.sa',
                    style: TextStyle(
                        color: Color.fromARGB(255, 75, 74, 74),
                        fontSize: 20,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Padding(padding: EdgeInsets.all(10)),
                  const Icon(Icons.person, size: 30),
                  const Padding(padding: EdgeInsets.only(left: 30)),
                  const Text(
                    'Abdulmalik Albesher',
                    style: TextStyle(
                        color: Color.fromARGB(255, 75, 74, 74), fontSize: 23),
                  ),
                ],
              ),
              Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Padding(padding: EdgeInsets.all(10)),
                  const Icon(Icons.email, size: 30),
                  const Padding(padding: EdgeInsets.only(left: 20)),
                  Text(
                    '439101946@student.ksu.edu.sa',
                    style: TextStyle(
                        color: Color.fromARGB(255, 75, 74, 74),
                        fontSize: 20,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
