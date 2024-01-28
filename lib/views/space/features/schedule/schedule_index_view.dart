// import 'package:flutter/material.dart';

// class ScheduleIndexPage extends StatefulWidget {
//   const ScheduleIndexPage({super.key, required String spaceId});

//   @override
//   State<ScheduleIndexPage> createState() => _ScheduleIndexPageState();
// }

// class _ScheduleIndexPageState extends State<ScheduleIndexPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         elevation: 0,
//         backgroundColor: Colors.white,
//         title: Text("Schedule"),
//         leading: GestureDetector(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: Icon(
//             Icons.arrow_back,
//             color: Colors.black.withOpacity(0.6),
//             // add custom icons also
//           ),
//         ),
//         actions: <Widget>[
//           Padding(
//             padding: EdgeInsets.only(right: 20.0),
//             child: GestureDetector(
//               onTap: () {},
//               child: Icon(
//                 Icons.notifications,
//                 size: 26.0,
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(right: 20.0),
//             child: GestureDetector(
//               onTap: () {},
//               child: Icon(Icons.person_rounded),
//             ),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.only(top: 30, left: 20),
//         child: Wrap(
//           // direction: Axis.vertical,
//           // alignment: WrapAlignment.center,
//           spacing: 8.0,
//           // runAlignment:WrapAlignment.center,
//           runSpacing: 8.0,
//           // crossAxisAlignment: WrapCrossAlignment.center,
//           // textDirection: TextDirection.rtl,
//           // verticalDirection: VerticalDirection.up,
//           children: <Widget>[
//             Container(
//               color: Colors.grey.withOpacity(0.3),
//               width: 100,
//               height: 100,
//               child: Center(
//                 child: Image.network(
//                   "https://png.pngtree.com/png-vector/20210718/ourlarge/pngtree-video-converence-interactive-e-learning-png-image_3614769.jpg",
//                 ),
//               ),
//             ),
//             Container(
//               color: Colors.red,
//               width: 100,
//               height: 100,
//               child: Center(
//                 child: Text(
//                   "W2",
//                   textScaleFactor: 2.5,
//                 ),
//               ),
//             ),
//             Container(
//               color: Colors.teal,
//               width: 100,
//               height: 100,
//               child: Center(
//                 child: Text(
//                   "W3",
//                   textScaleFactor: 2.5,
//                 ),
//               ),
//             ),
//             Container(
//               color: Colors.indigo,
//               width: 100,
//               height: 100,
//               child: Center(
//                 child: Text(
//                   "W4",
//                   textScaleFactor: 2.5,
//                 ),
//               ),
//             ),
//             Container(
//               color: Colors.orange,
//               width: 100,
//               height: 100,
//               child: Center(
//                 child: Text(
//                   "W5",
//                   textScaleFactor: 2.5,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
