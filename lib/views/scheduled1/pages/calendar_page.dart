import 'package:cr_calendar/cr_calendar.dart';
// import 'package:cr_calendar_example/res/colors.dart';
// import 'package:cr_calendar_example/utills/constants.dart';
// import 'package:cr_calendar_example/utills/extensions.dart';
// import 'package:cr_calendar_example/widgets/create_event_dialog.dart';
// import 'package:cr_calendar_example/widgets/day_events_bottom_sheet.dart';
// import 'package:cr_calendar_example/widgets/day_item_widget.dart';
// import 'package:cr_calendar_example/widgets/event_widget.dart';
// import 'package:cr_calendar_example/widgets/week_days_widget.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:padeprokan/graphql/schedule/getEvent.dart';
import 'package:padeprokan/views/scheduled1/utills/extensions.dart';

import '../../../components/organisms/appBar/appbar_widget.dart';
import '../utills/constants.dart';
import '../widgets/create_event_dialog.dart';
import '../widgets/day_events_bottom_sheet.dart';
import '../widgets/day_item_widget.dart';
import '../widgets/event_widget.dart';
import '../widgets/week_days_widget.dart';

/// Main calendar page.
class CalendarPage extends StatefulWidget {
  final String spaceId;
  const CalendarPage({super.key, required this.spaceId});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final _currentDate = DateTime.now();

  late CrCalendarController _calendarController;
  late String _appbarTitle;
  late String _monthName;

  @override
  void initState() {
    _setTexts(_currentDate.year, _currentDate.month);
    _createExampleEvents();

    super.initState();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
          document: gql(getSchedule), variables: {"idSpace": widget.spaceId}),
      builder: (result, {fetchMore, refetch}) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: appBarWidget(context, 'Schedule'),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: _addEvent,
          //   child: const Icon(Icons.add),
          // ),
          body: Column(
            children: [
              // Text("${result.data?["events"][0]["title"]}"),

              /// Calendar control row.
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(_appbarTitle,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      _changeCalendarPage(showNext: false);
                    },
                  ),
                  Text(
                    _monthName,
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: () {
                      _changeCalendarPage(showNext: true);
                    },
                  ),
                ],
              ),

              /// Calendar view.
              Expanded(
                child: CrCalendar(
                  firstDayOfWeek: WeekDay.monday,
                  eventsTopPadding: 32,
                  initialDate: _currentDate,
                  maxEventLines: 3,
                  controller: _calendarController,
                  forceSixWeek: true,
                  dayItemBuilder: (builderArgument) =>
                      DayItemWidget(properties: builderArgument),
                  weekDaysBuilder: (day) => WeekDaysWidget(day: day),
                  // eventBuilder: (drawer) => EventWidget(
                  //   // drawer: drawer,
                  //   spaceId: widget.spaceId,
                  // ),
                  onDayClicked: (events, day) {
                    print(day);
                  },
                  minDate: DateTime.now().subtract(const Duration(days: 1000)),
                  maxDate: DateTime.now().add(const Duration(days: 180)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      showEventModal(context, result);
                    },
                    child: Text('List Events'),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Future<dynamic> showEventModal(
      BuildContext context, QueryResult<Object?> result) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Column(
            children: [
              if (result.data != null) ...[
                ...result.data?["events"].map((e) {
                  print(e);
                  String datetime3 = DateFormat.EEEE()
                      .format(DateTime.parse(e['start']).toLocal());

                  String datetime2 = DateFormat.jm()
                      .format(DateTime.parse(e["start"]).toLocal());
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    e["title"],
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const Spacer(),
                                  Text(
                                    datetime3 + ", " + datetime2,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                e["description"],
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                })
              ],
            ],
          ),
        );
      },
    );
  }

  void _changeCalendarPage({required bool showNext}) => showNext
      ? _calendarController.swipeToNextMonth()
      : _calendarController.swipeToPreviousPage();

  void _onCalendarPageChanged(int year, int month) {
    setState(() {
      _setTexts(year, month);
    });
  }

  /// Set app bar text and month name over calendar.
  void _setTexts(int year, int month) {
    final date = DateTime(year, month);
    _appbarTitle = date.format(kAppBarDateFormat);
    _monthName = date.format(kMonthFormat);
  }

  /// Show current month page.
  void _showCurrentMonth() {
    _calendarController.goToDate(_currentDate);
  }

  /// Show [CreateEventDialog] with settings for new event.
  Future<void> _addEvent() async {
    final event = await showDialog(
        context: context, builder: (context) => const CreateEventDialog());
    if (event != null) {
      _calendarController.addEvent(event);
    }
  }

  void _createExampleEvents() {
    final now = _currentDate;
    _calendarController = CrCalendarController(
      onSwipe: _onCalendarPageChanged,
      events: [],
    );
  }

  // void _showDayEventsInModalSheet(
  //     List<CalendarEventModel> events, DateTime day) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (context) {
  //       return Query(
  //         options: QueryOptions(
  //             document: gql(getSchedule),
  //             variables: {'idSpace': widget.spaceId}),
  //         builder: (result, {fetchMore, refetch}) {
  //           return Column(
  //             children: [
  //               if (result.data != null) ...[
  //                 ...result.data?["events"].map((e) {
  //                   String datetime3 = DateFormat.MMMMEEEEd()
  //                       .format(DateTime.parse(e['start']));

  //                   String datetime2 =
  //                       DateFormat.Hms().format(DateTime.parse(e["start"]));
  //                   return SingleChildScrollView(
  //                     child: Card(
  //                       child: ListTile(
  //                         title: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Row(
  //                               children: [
  //                                 Text(
  //                                   e["title"],
  //                                   style: const TextStyle(
  //                                       color: Colors.black,
  //                                       fontSize: 11,
  //                                       fontWeight: FontWeight.w400),
  //                                 ),
  //                                 const Spacer(),
  //                                 Text(
  //                                   datetime3 + " " + datetime2,
  //                                   style: const TextStyle(
  //                                       color: Colors.black,
  //                                       fontSize: 10,
  //                                       fontWeight: FontWeight.w400),
  //                                 )
  //                               ],
  //                             ),
  //                             const SizedBox(
  //                               height: 20,
  //                             ),
  //                             Text(
  //                               e["description"],
  //                               style: const TextStyle(
  //                                   fontSize: 14, fontWeight: FontWeight.w400),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                   );
  //                 })
  //               ],
  //             ],
  //           );
  //         },
  //       );
  //     },
  //   );
  //   ;
  // }
}
