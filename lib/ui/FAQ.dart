import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:safra/ui/dashboardn.dart';

class FAQ extends StatefulWidget {
  const FAQ({Key? key}) : super(key: key);

  @override
  State<FAQ> createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  bool expand = false;
  bool expand2 = false;
  bool expand3 = false;
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
                                  builder: (context) => const dashboardn()));
                        })),
                const SizedBox(height: 20),
                const Text('''   Frequently Asked 
         Questions''',
                    style: TextStyle(
                        fontSize: 33, color: Color.fromARGB(255, 75, 74, 74))),
                const SizedBox(height: 80),
                Expanded(
                    child: ListView(padding: EdgeInsets.all(10), children: [
                  Row(
                    children: [
                      const Padding(
                          padding: EdgeInsets.only(left: 10, top: 10)),
                      Container(
                          alignment: Alignment.bottomLeft,
                          child: buildButton()),
                      const Padding(padding: EdgeInsets.only(left: 10)),
                      Expanded(child: buildtext('''
What Safra Provide?

Safra main goal is to guide travelers on their new destinations'''))
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      const Padding(padding: EdgeInsets.only(left: 10)),
                      Container(
                          alignment: Alignment.center, child: buildButton2()),
                      const Padding(padding: EdgeInsets.only(left: 10)),
                      Expanded(child: buildtext2('''
Create trip differences?

There are three different methods to create trip 

- Create trip manually (if the user know his destination and doesn’t what any recommendations from safra

- Create trip by searching Safra system for similar trip and select what suits the user 

- Generate trip by using user’s entrests same as surprise me   '''))
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      const Padding(padding: EdgeInsets.only(left: 10)),
                      Container(
                          alignment: Alignment.center, child: buildButton3()),
                      const Padding(padding: EdgeInsets.only(left: 10)),
                      Expanded(child: buildtext3('''
How can Safra benefits me? 

Safra is a social network application in which it can help you organize your trip or even get trips recommendations on your destination'''))
                    ],
                  ),
                ])),
              ],
            )));
  }

  Widget buildButton() => IconButton(
      onPressed: () => setState(() => expand = !expand),
      icon: Icon(expand ? Icons.remove : Icons.add),
      iconSize: 33,
      color: expand
          ? Color.fromARGB(255, 163, 1, 1)
          : const Color.fromARGB(255, 75, 74, 74));

  Widget buildButton2() => IconButton(
      onPressed: () => setState(() => expand2 = !expand2),
      icon: Icon(expand2 ? Icons.remove : Icons.add),
      iconSize: 33,
      color: expand2
          ? Color.fromARGB(255, 163, 1, 1)
          : const Color.fromARGB(255, 75, 74, 74));

  Widget buildButton3() => IconButton(
      onPressed: () => setState(() => expand3 = !expand3),
      icon: Icon(expand3 ? Icons.remove : Icons.add),
      iconSize: 33,
      color: expand3
          ? Color.fromARGB(255, 163, 1, 1)
          : const Color.fromARGB(255, 75, 74, 74));

  Widget buildtext(String text) {
    final maxLines = expand ? null : 1;
    return Text(
      text,
      maxLines: maxLines,
      style: TextStyle(
          color: const Color.fromARGB(255, 75, 74, 74),
          fontSize: 21,
          fontWeight: FontWeight.normal),
    );
  }

  Widget buildtext2(String text) {
    final maxLines = expand2 ? null : 1;
    return Text(
      text,
      maxLines: maxLines,
      style: TextStyle(
          color: const Color.fromARGB(255, 75, 74, 74),
          fontSize: 21,
          fontWeight: FontWeight.normal),
    );
  }

  Widget buildtext3(String text) {
    final maxLines = expand3 ? null : 1;
    return Text(
      text,
      maxLines: maxLines,
      style: TextStyle(
          color: const Color.fromARGB(255, 75, 74, 74),
          fontSize: 21,
          fontWeight: FontWeight.normal),
    );
  }
}
