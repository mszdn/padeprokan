import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:padeprokan/components/organisms/appBar/appbar_widget.dart';
import 'package:padeprokan/graphql/courses/get_all_quorses.dart';
import 'package:padeprokan/views/space/features/courses/quiz/answer_quiz.dart';

class QuizPage extends StatefulWidget {
  // ValueNotifier<dynamic> questions = ValueNotifier<dynamic>('');
  ValueNotifier<dynamic> quiz;
  final String idCourse;
  // final String idQuiz;
  QuizPage({
    super.key,
    required this.quiz,
    required this.idCourse,
    // required this.questions,
  });

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context, 'Quiz'),
      body: SingleChildScrollView(
        child: Column(
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
                          padding: const EdgeInsets.only(left: 8, top: 8),
                          child: Text(
                            widget.quiz.value["title"],
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "|" +
                                widget.quiz.value['questions'].length
                                    .toString() +
                                " Questions",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w300),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: SizedBox(
                            // height: MediaQuery.of(context).size.height,
                            child: Text(
                              widget.quiz.value["subdesc"],
                              style: TextStyle(overflow: TextOverflow.ellipsis),
                              maxLines: 3,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Spacer(),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: ElevatedButton(
                        //     onPressed: () {
                        //       setState(() {
                        //         // print(widget.quiz.value['questions']);
                        //         // // widget.quiz.value['questions'];
                        //         // // widget.quiz.notifyListeners();
                        //         // // print(widget.questions.value =
                        //         // //     widget.quiz.value['quiz']['questions']);
                        //         // Navigator.push(
                        //         //     context,
                        //         //     MaterialPageRoute(
                        //         //         builder: (context) => AnsweQuizPage(
                        //         //             idCourse: widget.idCourse,
                        //         //             quiz: widget.quiz)));
                        //       });
                        //     },
                        //     child: const Text('Start quiz'),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
