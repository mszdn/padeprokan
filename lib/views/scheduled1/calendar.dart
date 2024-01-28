// import 'package:cr_calendar_example/pages/calendar_page.dart';
// import 'package:cr_calendar_example/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:padeprokan/views/scheduled1/pages/calendar_page.dart';

class Calendarview extends StatefulWidget {
  const Calendarview({super.key});

  @override
  _CalendarviewState createState() => _CalendarviewState();
}

class _CalendarviewState extends State<Calendarview> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /// Example app theme.
      theme: ThemeData(
        floatingActionButtonTheme:
            const FloatingActionButtonThemeData(backgroundColor: Colors.orange),
        primaryColor: Colors.orange,
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: Colors.orange),
        iconTheme: const IconThemeData(color: Colors.black),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            textStyle: const TextStyle(
              color: Colors.orange,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            foregroundColor: Colors.orange,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            shadowColor: Colors.transparent,
            elevation: 0,
            foregroundColor: Colors.orange,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
          ),
        ),
        dialogTheme: const DialogTheme(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
        ),
      ),
      home: const CalendarPage(
        spaceId: '',
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
