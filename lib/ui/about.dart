import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:safra/ui/stngs.dart';

class about extends StatefulWidget {
  const about({Key? key}) : super(key: key);

  @override
  State<about> createState() => _aboutState();
}

class _aboutState extends State<about> {
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
                                builder: (context) => const stngs()));
                      })),
              const SizedBox(height: 20),
              const Text(''' About''',
                  style: TextStyle(
                      fontSize: 33, color: Color.fromARGB(255, 75, 74, 74))),
              const SizedBox(height: 80),
              Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "We're three students from College of Computer Science and Information in King Saud University...",
                        style: TextStyle(
                            color: Color.fromARGB(255, 75, 74, 74),
                            fontSize: 19),
                      )),
                ],
              ),
            ],
          )),
    );
  }
}
