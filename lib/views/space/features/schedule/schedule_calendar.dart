// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:table_calendar/table_calendar.dart';

// class CalendarSchedule extends StatefulWidget {
//   const CalendarSchedule({super.key, required String spaceId});

//   @override
//   State<CalendarSchedule> createState() => _CalendarScheduleState();
// }

// class _CalendarScheduleState extends State<CalendarSchedule> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
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
//         body: Column(
//           children: [
//             Container(
//               child: TableCalendar(
//                 calendarFormat: CalendarFormat.month,
//                 firstDay: DateTime.utc(2010 , 1, 1),
//                 lastDay: DateTime.utc(2030, 1, 1),
//                 focusedDay: DateTime.now(),

//                 // onDaySelected: ((selectedDay, focusedDay) {
//                 //   if (!isSameDay(_selectedDay, selectedDay)){
//                 //     setState(() {
//                 //       _selectedDay = selectedDay;
//                 //       _focusedDay = focusedDay;
//                 //     });
//                 //   }
//                 // }),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }