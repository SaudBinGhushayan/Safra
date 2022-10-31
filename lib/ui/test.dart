// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:safra/backend/httpHandler.dart';
// import 'package:safra/backend/supabase.dart';
// import 'package:safra/objects/Places.dart';
// import 'package:safra/objects/Trips.dart';
// import 'package:safra/objects/displayAllTrips.dart';

// class test extends StatefulWidget {
//   const test({Key? key}) : super(key: key);

//   @override
//   State<test> createState() => _testState();
// }

// class _testState extends State<test> {
//   final user = FirebaseAuth.instance.currentUser!;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Center(
//             child: ElevatedButton(
//                 onPressed: () async {
//                   List<Trips> trips;
//                   final response = await SupaBase_Manager()
//                       .client
//                       .from('activities')
//                       .select()
//                       .eq('name', 'Amorino Gelato Al Naturale')
//                       .eq('trip_id', '1.1058e+2')
//                       .execute();

//                   if (response.data.isNotEmpty) {
//                     var data = response.data.toString();
//                     data = data.replaceAll('{', '{"');
//                     data = data.replaceAll(': ', '": "');
//                     data = data.replaceAll(', ', '", "');
//                     data = data.replaceAll('}', '"}');
//                     data = data.replaceAll('}",', '},');
//                     data = data.replaceAll('"{', '{');
//                     trips = TripsFromJson(data);
//                     print(trips[0].fsq_id);
//                   } else {
//                     return null;
//                   }
//                 },
//                 child: Text('press'))));
//   }
// }
