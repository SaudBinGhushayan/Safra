import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:safra/backend/httpHandler.dart';
import 'package:safra/objects/Places.dart';

class test extends StatefulWidget {
  const test({Key? key}) : super(key: key);

  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
  List<Places>? places;
  var isloaded = false;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    places = await httpHandler().getPlaces();
    if (places != null) {
      setState(() {
        isloaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Visibility(
        visible: isloaded,
        child: ListView.builder(
            itemCount: places?.length,
            itemBuilder: ((context, index) {
              return Container(
                  child: Text('${places![index].name.toString()}'));
            })),
        replacement: const Center(
          child: Text('no data'),
        ),
      ),
    );
  }
}
