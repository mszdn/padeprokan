import 'package:cr_calendar/cr_calendar.dart';
// import 'package:cr_calendar_example/res/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Widget that represents week days in row above calendar month view.
class WeekDaysWidget extends StatefulWidget {
  const WeekDaysWidget({
    required this.day,
    super.key,
  });

  /// [WeekDay] value from [WeekDaysBuilder].
  final WeekDay day;

  @override
  State<WeekDaysWidget> createState() => _WeekDaysWidgetState();
}

class _WeekDaysWidgetState extends State<WeekDaysWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: Center(
        child: Text(
          describeEnum(widget.day).substring(0, 1).toUpperCase(),
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
