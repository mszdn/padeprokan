import 'package:cr_calendar/cr_calendar.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:padeprokan/graphql/schedule/getEvent.dart';

/// Custom event widget with rounded borders
class EventWidget extends StatefulWidget {
  //  final rnd = math.Random();
  final String spaceId;

  EventWidget({
    // required this.drawer,
    required this.spaceId,
    super.key,
  });
  // var colors = [
  //   Colors.green,
  //   Colors.blue,
  //   Colors.orange,
  //   Colors.red,
  //   Colors.yellow,
  // ];

  // final EventProperties drawer;

  @override
  State<EventWidget> createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {
  // final String spaceId;
  // final rnd = math.Random();

  // Color getRandomColor() => Color(rnd.nextInt(0xffffffff));
  // List colors = [
  //   Colors.red,
  //   Colors.green,
  //   Colors.blue,
  //   Colors.yellow,
  //   Colors.orange
  // ];
  // Random random = new Random();

  // int index = 0;

  // void changeIndex() {
  //   setState(() => index = random.nextInt(3));
  // }

  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(
          document: gql(getSchedule),
          variables: {"idSpace": widget.spaceId},
        ),
        builder: (result, {fetchMore, refetch}) {
          print("${result.data} AKU ANAK SEHAT");
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 3),
            padding: const EdgeInsets.symmetric(horizontal: 5),
            decoration: const BoxDecoration(
              // borderRadius: const BorderRadius.all(Radius.circular(4)),
              // color: colors[++index],
              color: Colors.blue,
            ),
            child: FittedBox(
              fit: BoxFit.fitHeight,
              alignment: Alignment.centerLeft,
              child: Text(
                "${result.data?["events"][0]["title"]}",
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          );
        });
  }
}
