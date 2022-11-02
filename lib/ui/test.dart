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
//                   dynamic data;
//                   final response = await SupaBase_Manager()
//                       .client
//                       .from('participate')
//                       .select()
//                       .eq('trip_id', '231.2704')
//                       .execute();
//                   if (response.error == null) {
//                     data = response.data[0] as Map<String, dynamic>;
//                     print(data['active']);
//                   }
//                 },
//                 child: Text('press'))));
//   }
// }
