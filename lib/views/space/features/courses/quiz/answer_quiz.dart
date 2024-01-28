import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:padeprokan/components/organisms/appBar/appbar_widget.dart';
import 'package:padeprokan/components/utils/theme_colors.dart';
import 'package:padeprokan/graphql/courses/get_all_quorses.dart';
import 'package:padeprokan/graphql/space/space_members.dart';
import 'package:padeprokan/views/space/features/courses/article/map_course_view.dart';
import 'package:webviewx/webviewx.dart';

class AnsweQuizPage extends StatefulWidget {
  // ValueNotifier<dynamic> questions = ValueNotifier<dynamic>('');

  // final String idQuiz;
  // final String quizId;
  final String idCourse;
  // ValueNotifier<dynamic> questions;
  ValueNotifier<dynamic> quiz;
  AnsweQuizPage(
      {super.key,
      required this.idCourse,
      // required this.questions,
      required this.quiz});

  @override
  State<AnsweQuizPage> createState() => _AnsweQuizPageState();
}

class _AnsweQuizPageState extends State<AnsweQuizPage> {
  // late WebViewXController webViewController;

  // String? answer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context, 'Quiz'),
      body: SingleChildScrollView(
        child: Query(
          options: QueryOptions(
            document: gql(allCoursesQuery),
            variables: {'idCourse': widget.idCourse},
          ),
          builder: (result, {fetchMore, refetch}) {
            if (result.data == null) {
              print('kosong');
            }
            print("${result.data} AAAA");
            return Column(
              children: [
                Container(
                  child: Container(
                    height: MediaQuery.of(context).size.height / 4,
                    width: MediaQuery.of(context).size.width / 0.5,
                    child: Card(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 8, top: 8),
                              child: Text(
                                'bjir',
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: SizedBox(
                                // height: MediaQuery.of(context).size.height,
                                child: Text(
                                  "Desc",
                                  // widget.questions.value["subdesc"],
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis),
                                  maxLines: 3,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  print(widget.quiz.value["questions"]);
                                  // print(result.data);
                                });
                              },
                              child: Text('sss'),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
