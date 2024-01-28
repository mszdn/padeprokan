import 'package:cr_calendar/cr_calendar.dart';
// import 'package:cr_calendar_example/utills/constants.dart';
// import 'package:cr_calendar_example/utills/extensions.dart';
import 'package:flutter/material.dart';
import 'package:padeprokan/views/scheduled1/utills/extensions.dart';

import '../utills/constants.dart';

/// Draggable bottom sheet with events for the day.
class DayEventsBottomSheet extends StatefulWidget {
  const DayEventsBottomSheet({
    required this.screenHeight,
    required this.events,
    required this.day,
    super.key,
  });

  final List<CalendarEventModel> events;
  final DateTime day;
  final double screenHeight;

  @override
  State<DayEventsBottomSheet> createState() => _DayEventsBottomSheetState();
}

class _DayEventsBottomSheetState extends State<DayEventsBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        maxChildSize: 0.9,
        expand: false,
        builder: (context, controller) {
          return widget.events.isEmpty
              ? const Center(child: Text('No events for this day'))
              : ListView.builder(
                  controller: controller,
                  itemCount: widget.events.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          left: 18,
                          top: 16,
                          bottom: 16,
                        ),
                        child: Text(widget.day.format('yy/MM/dd')),
                      );
                    } else {
                      final event = widget.events[index - 1];
                      return Container(
                          height: 100,
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 4),
                              child: Card(
                                  clipBehavior: Clip.antiAlias,
                                  child: Row(
                                    children: [
                                      Container(
                                        color: event.eventColor,
                                        width: 6,
                                      ),
                                      Expanded(
                                          child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 16),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                event.name,
                                                style: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                '${event.begin.format(kDateRangeFormat)} - '
                                                '${event.end.format(kDateRangeFormat)}',
                                                style: const TextStyle(
                                                    fontSize: 14),
                                              )
                                            ],
                                          ),
                                        ),
                                      ))
                                    ],
                                  ))));
                    }
                  });
        });
  }
}
