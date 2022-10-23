import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:safra/backend/httpHandler.dart';
import 'package:safra/backend/supabase.dart';
import 'package:safra/objects/Places.dart';
import 'package:safra/objects/displayAllTrips.dart';

class test extends StatefulWidget {
  const test({Key? key}) : super(key: key);

  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: ElevatedButton(
                onPressed: () async {
                  List<DisplayTripsInfo> lst;
                  final response = await SupaBase_Manager()
                      .client
                      .from('participate')
                      .select('trips_info(*)')
                      .eq('uid', user.uid)
                      .execute();
                  var data = response.data.toString();
                  data = data.replaceAll('{', '{"');
                  data = data.replaceAll(' {"', ' [{"');
                  data = data.replaceAll(': ', '": "');
                  data = data.replaceAll(', ', '", "');
                  data = data.replaceAll('"[{', '[{');
                  data = data.replaceAll('}}"', '"}]}');
                  data = data.replaceAll(', [{"', ', {"');
                  data = data.replaceAll('}}]', '"}]}]');
                  lst = DisplayTripsInfoFromJson(data);

                  print(lst.length);
                },
                child: Text('press'))));
  }
}
