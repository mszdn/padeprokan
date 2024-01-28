import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:padeprokan/components/organisms/appBar/appbar_widget.dart';
import 'package:padeprokan/components/organisms/get_image/get_image_courses_view..dart';
import 'package:padeprokan/graphql/courses/get_all_quorses.dart';
// import 'package:padeprokan/views/space/features/courses/slide.dart';
// import 'package:padeprokan/views/space/features/courses/videoqw.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:padeprokan/views/space/features/courses/article/course_article_index_view.dart';
import 'package:padeprokan/views/space/features/courses/quiz/answer_quiz.dart';
import 'package:padeprokan/views/space/features/courses/quiz/quiz_view.dart';
import 'package:padeprokan/views/space/features/courses/slide/slide.dart';
import 'dart:math' as math;

import 'package:padeprokan/views/space/features/courses/video/videoqw.dart';

// import '../../../../graphql/courses/allcouerses.dart';

// String allQuorsesQuery = """
// query(\$idCourse:String!) {
//   course(id:\$idCourse) {
//     title
//     id
//     space{
//       id
//       createdBy{
//         id
//       }
//     }
//     courseCategories {
//       id
//       name
//     }
//     sections{
//       id
//       title
//       description
//       lectures{
//         id
//         title
//         type
//         description
//         embed
//         article{
//           id
//           title
//           markdown
//         }
//         quiz {
//           id
//           title
//           questions{
//             id
//             title
//             options {
//               id
//               check
//               desc
//             }
//           }
//         }
//       }
//     }
//     finishTime
//     description
//   }
// }
// """;

class MapCourseView extends StatefulWidget {
  String idCourse;

  MapCourseView({super.key, required this.idCourse});

  @override
  State<MapCourseView> createState() => _MapCourseViewState();
}

class _MapCourseViewState extends State<MapCourseView> {
  String? type;
  ValueNotifier<String> embed = ValueNotifier<String>('');
  ValueNotifier<dynamic> article = ValueNotifier<dynamic>('');
  ValueNotifier<dynamic> quiz = ValueNotifier<dynamic>('');
  ValueNotifier<dynamic> questions = ValueNotifier<dynamic>('');

  final rnd = math.Random();

  Color getRandomColor() => Color(rnd.nextInt(0xffffffff));
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   embed.addListener(() {});
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    article.addListener(() {});
    quiz.addListener(() {});
    questions.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context, "Courses"),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Query(
          options: QueryOptions(
              document: gql(allCoursesQuery),
              variables: {"idCourse": widget.idCourse}),
          builder: (result, {fetchMore, refetch}) {
            if (result.data != null) {
              print("0000 ${result.data?["course"]} 0000");
              // print(
              // "${result.data?["course"]["sections"]["lectures"]} SDASDSADSADASDASD");
            }

            if (result.hasException) {
              return Center(
                child: LoadingAnimationWidget.halfTriangleDot(
                    color: Colors.black, size: 50),
              );
            }
            // print("${result.isLoading.toString()} llppp");
            if (result.isLoading) {
              return Center(
                child: LoadingAnimationWidget.halfTriangleDot(
                    color: Colors.black, size: 50),
              );
            }

            return result.data?["course"]!['sections'].length == 0
                ? const Center(child: GetImageCoursesView())
                : Column(
                    children: [
                      if (type == "video") ...[
                        SizedBox(height: 205, child: VideoQwPage(embed: embed)),
                      ] else if (type == "slide") ...[
                        SizedBox(
                            height: 205,
                            child: slide(
                              embed: embed,
                              spaceId: widget.idCourse,
                            )),
                      ] else if (type == "article") ...[
                        SizedBox(
                          height: 255,
                          child: ArticlePage(article: article),
                        )
                      ] else if (type == "QUIZ") ...[
                        SizedBox(
                          height: 205,
                          child: QuizPage(
                            quiz: quiz,
                            idCourse: widget.idCourse,
                          ),
                        )
                      ] else ...[
                        const SizedBox(
                          height: 205,
                        )
                      ],

                      // const WebViewX(
                      //   initialContent:
                      //       '<div style=""><p><strong>er</strong></p><p><strong>Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.<span class="ql-cursor">﻿</span></strong><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACIAAAAZCAYAAABU+vysAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAAFiUAABYlAUlSJPAAAABiSURBVEhL7dJBCsAgDERRc/9DW1y4cJg0BY1amMDbVKt/YTGzegOFIIUghSAakjXsrs4NYd9nRGe+hniD+7+I/lMI2hrShq01CkF6rOgfIStFZ7ohGcPu6mjICQpBChlZfQB+Lcb/6/ZsvwAAAABJRU5ErkJggg=="></p>',
                      //   initialSourceType: SourceType.html,
                      //   // onWebViewCreated: (controller) => webviewController = controller,
                      //   height: 110,
                      //   width: 110,
                      // ),

                      // Row(
                      //   children: [
                      //     Container(
                      //       alignment: Alignment.topLeft,
                      //       child: Padding(
                      //         padding: const EdgeInsets.all(8.0),
                      //         child: SizedBox(
                      //           width: 160,
                      //           height: 45,
                      //           child: ElevatedButton(
                      //               style: ButtonStyle(
                      //                 // foregroundColor: MaterialStateProperty.all(Colors.yellow),
                      //                 backgroundColor: MaterialStateProperty
                      //                     .resolveWith<Color?>((states) {
                      //                   if (states
                      //                       .contains(MaterialState.pressed)) {
                      //                     return Colors.blue;
                      //                   }
                      //                   return Colors.grey;
                      //                 }),
                      //               ),
                      //               child: const Text(
                      //                 ' << Previous',
                      //                 style: TextStyle(color: Colors.white),
                      //               ),
                      //               onPressed: () {}),
                      //         ),
                      //       ),
                      //     ),
                      //     Container(
                      //       child: Padding(
                      //         padding: const EdgeInsets.all(8.0),
                      //         child: SizedBox(
                      //           width: 160,
                      //           height: 45,
                      //           child: ElevatedButton(
                      //               style: ButtonStyle(
                      //                 // foregroundColor: MaterialStateProperty.all(Colors.yellow),
                      //                 backgroundColor: MaterialStateProperty
                      //                     .resolveWith<Color?>((states) {
                      //                   if (states
                      //                       .contains(MaterialState.pressed)) {
                      //                     return Colors.blue;
                      //                   }
                      //                   return Colors.grey;
                      //                 }),
                      //               ),
                      //               child: const Text(
                      //                 'Next >>',
                      //                 style: TextStyle(color: Colors.white),
                      //               ),
                      //               onPressed: () {
                      //                 // Navigator.push(
                      //                 //   context,
                      //                 //   MaterialPageRoute(
                      //                 //       builder: (context) => slide(
                      //                 //             embed: ValueNotifier(""),
                      //                 //           )),
                      //                 // );
                      //               }),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              if (result.data != null) ...[
                                // Text(result.data!["course"][""]["title"] ?? ""),
                                ...result.data?["course"]["sections"]?.map((v) {
                                  return Container(
                                    child: Column(
                                      children: [
                                        ExpansionTile(
                                          title: Text(
                                            v["title"],
                                            maxLines: 1,
                                            style: const TextStyle(
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 270, bottom: 10),
                                              child: SizedBox(
                                                width: 100,
                                                child: Text(
                                                  v["description"] ?? "",
                                                  maxLines: 1,
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                children: [
                                                  const SizedBox(
                                                    height: 7,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          ...v["lectures"]
                                                              .map((a) {
                                                            return Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                InkWell(
                                                                  onTap: () {
                                                                    if (a['type'] ==
                                                                        'SLIDE') {
                                                                      setState(
                                                                          () {
                                                                        type =
                                                                            "slide";
                                                                        embed.value =
                                                                            a['embed'];
                                                                      });
                                                                    } else if (a[
                                                                            'type'] ==
                                                                        "VIDEO") {
                                                                      setState(
                                                                          () {
                                                                        type =
                                                                            "slide";
                                                                        embed.value =
                                                                            a['embed'];
                                                                      });
                                                                    } else if (a[
                                                                            "type"] ==
                                                                        "ARTICLE") {
                                                                      setState(
                                                                          () {
                                                                        type =
                                                                            "article";
                                                                        article.value =
                                                                            a['article'];
                                                                        article
                                                                            .notifyListeners();
                                                                      });
                                                                    } else if (a[
                                                                            'type'] ==
                                                                        "QUIZ") {
                                                                      setState(
                                                                          () {
                                                                        print(
                                                                            "${questions.value = a['quiz']['questions']} PPPPPP");
                                                                        type =
                                                                            "QUIZ";
                                                                        quiz.value =
                                                                            a["quiz"];
                                                                        quiz.notifyListeners();
                                                                      });
                                                                    }
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    width: 320,
                                                                    child:
                                                                        SizedBox(
                                                                      width:
                                                                          220,
                                                                      // MediaQuery.of(context).size.width *
                                                                      //     0.85,
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Padding(
                                                                            padding: const EdgeInsets.only(
                                                                                left: 6,
                                                                                top: 8,
                                                                                bottom: 8,
                                                                                right: 8),
                                                                            child:
                                                                                Align(
                                                                              alignment: Alignment.topLeft,
                                                                              child: Container(
                                                                                height: 50,
                                                                                width: 70,
                                                                                color: Colors.blue,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                220,
                                                                            child:
                                                                                Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Text(
                                                                                  a["title"],
                                                                                  style: const TextStyle(overflow: TextOverflow.ellipsis),
                                                                                ),
                                                                                const SizedBox(
                                                                                  height: 6,
                                                                                ),
                                                                                Text(
                                                                                  a["type"],
                                                                                  style: const TextStyle(color: Colors.grey),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                // Text("test")
                                                                // Text(v["type"]
                                                                //     .toString())
                                                              ],
                                                            );
                                                          }),
                                                        ],
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        ...v["lectures"].map(
                                          (c) {
                                            return Container(
                                              child: Column(
                                                children: [
                                                  if (c["type"] ==
                                                      "ARTICLE") ...[
                                                    // ExpansionTile(
                                                    //   iconColor: Colors.black,
                                                    //   textColor: Colors.black,
                                                    //   title: SizedBox(
                                                    //       width: 120,
                                                    //       child: Text(
                                                    //         v["title"],
                                                    //         maxLines: 1,
                                                    //         style: TextStyle(
                                                    //             overflow:
                                                    //                 TextOverflow
                                                    //                     .ellipsis),
                                                    //       )),
                                                    //   children: [
                                                    //     Padding(
                                                    //       padding:
                                                    //           const EdgeInsets
                                                    //                   .symmetric(
                                                    //               horizontal:
                                                    //                   18),
                                                    //       child: Row(
                                                    //         children: [
                                                    //           SizedBox(
                                                    //             width: 150,
                                                    //             child: Text(
                                                    //               v?["description"] ??
                                                    //                   "",
                                                    //               maxLines: 1,
                                                    //               style: const TextStyle(
                                                    //                   color: Colors
                                                    //                       .grey,
                                                    //                   overflow:
                                                    //                       TextOverflow
                                                    //                           .ellipsis),
                                                    //             ),
                                                    //           ),
                                                    //         ],
                                                    //       ),
                                                    //     ),
                                                    //     Container(
                                                    //       color: Colors.black12,
                                                    //       child: Padding(
                                                    //         padding:
                                                    //             const EdgeInsets
                                                    //                 .all(8.0),
                                                    //         child: InkWell(
                                                    //           onTap: () {
                                                    //             print(
                                                    //                 'Test Article');
                                                    //             setState(() {
                                                    // type =
                                                    //     "article";
                                                    // article.value =
                                                    //     c["article"];
                                                    // article
                                                    //     .notifyListeners();
                                                    //             });
                                                    //           },
                                                    //           child: Row(
                                                    //             children: [
                                                    //               Align(
                                                    //                 alignment:
                                                    //                     Alignment
                                                    //                         .topLeft,
                                                    //                 child:
                                                    //                     Container(
                                                    //                   height:
                                                    //                       60,
                                                    //                   width:
                                                    //                       100,
                                                    //                   color:
                                                    //                       getRandomColor(),
                                                    //                 ),
                                                    //               ),
                                                    //               const SizedBox(
                                                    //                 width: 7,
                                                    //               ),
                                                    //               Column(
                                                    //                 crossAxisAlignment:
                                                    //                     CrossAxisAlignment
                                                    //                         .start,
                                                    //                 children: [
                                                    //                   Row(
                                                    //                     children: [
                                                    //                       Text(c[
                                                    //                           "title"]),
                                                    //                       const Icon(
                                                    //                         Icons.remove_red_eye_outlined,
                                                    //                         size:
                                                    //                             20,
                                                    //                       ),
                                                    //                     ],
                                                    //                   ),
                                                    //                   Row(
                                                    //                     children: [
                                                    //                       const Icon(
                                                    //                         Icons.table_rows,
                                                    //                         color:
                                                    //                             Colors.grey,
                                                    //                         size:
                                                    //                             20,
                                                    //                       ),
                                                    //                       Text(
                                                    //                         c["type"],
                                                    //                         style:
                                                    //                             const TextStyle(color: Colors.grey),
                                                    //                       ),
                                                    //                     ],
                                                    //                   )
                                                    //                 ],
                                                    //               ),
                                                    //             ],
                                                    //           ),
                                                    //         ),
                                                    //       ),
                                                    //     )
                                                    //   ],
                                                    //   onExpansionChanged:
                                                    //       (bool expanded) {},
                                                    // ),
                                                    // const Text("artickel data"),
                                                    // Text(c["article"]["title"])
                                                    // ] else if (c["type"] ==
                                                    //     "VIDEO") ...[
                                                    //   ExpansionTile(
                                                    //     iconColor: Colors.black,
                                                    //     textColor: Colors.black,
                                                    //     // collapsedTextColor: Colors.black,

                                                    //     title: Text(
                                                    //       v["title"],
                                                    //       maxLines: 1,
                                                    //       style: TextStyle(
                                                    //           overflow: TextOverflow
                                                    //               .ellipsis),
                                                    //     ),

                                                    //     children: [
                                                    //       Padding(
                                                    //         padding:
                                                    //             const EdgeInsets
                                                    //                     .only(
                                                    //                 right: 270,
                                                    //                 bottom: 10),
                                                    //         child: SizedBox(
                                                    //           width: 100,
                                                    //           child: Text(
                                                    //             v["description"] ??
                                                    //                 "",
                                                    //             maxLines: 1,
                                                    //             style: const TextStyle(
                                                    //                 color:
                                                    //                     Colors.grey,
                                                    //                 overflow:
                                                    //                     TextOverflow
                                                    //                         .ellipsis),
                                                    //           ),
                                                    //         ),
                                                    //       ),
                                                    //       Container(
                                                    //         color: Colors.black12,
                                                    //         child: Padding(
                                                    //           padding:
                                                    //               const EdgeInsets
                                                    //                   .all(8.0),
                                                    //           child: InkWell(
                                                    //             onTap: () {
                                                    //               setState(() {
                                                    //                 // print(result
                                                    //                 //         .data?[
                                                    //                 //     "lectures"]);
                                                    //                 type = "slide";
                                                    //                 embed.value = c[
                                                    //                         "embed"]
                                                    //                     .toString();
                                                    //               });
                                                    //             },
                                                    //             child: Row(
                                                    //               children: [
                                                    //                 Align(
                                                    //                   alignment:
                                                    //                       Alignment
                                                    //                           .topLeft,
                                                    //                   child:
                                                    //                       Container(
                                                    //                     height: 60,
                                                    //                     width: 100,
                                                    //                     color: Colors
                                                    //                         .blue,
                                                    //                   ),
                                                    //                 ),
                                                    //                 const SizedBox(
                                                    //                   width: 7,
                                                    //                 ),
                                                    //                 Column(
                                                    //                   crossAxisAlignment:
                                                    //                       CrossAxisAlignment
                                                    //                           .start,
                                                    //                   children: [
                                                    //                     Row(
                                                    //                       children: [
                                                    //                         SizedBox(
                                                    //                           width:
                                                    //                               150,
                                                    //                           child:
                                                    //                               Text(
                                                    //                             c["title"],
                                                    //                             maxLines:
                                                    //                                 1,
                                                    //                             style:
                                                    //                                 TextStyle(overflow: TextOverflow.ellipsis),
                                                    //                           ),
                                                    //                         ),
                                                    //                         const Icon(
                                                    //                           Icons
                                                    //                               .remove_red_eye_outlined,
                                                    //                           size:
                                                    //                               20,
                                                    //                         )
                                                    //                       ],
                                                    //                     ),
                                                    //                     Row(
                                                    //                       children: [
                                                    //                         const Icon(
                                                    //                           Icons
                                                    //                               .play_circle,
                                                    //                           color:
                                                    //                               Colors.grey,
                                                    //                           size:
                                                    //                               20,
                                                    //                         ),
                                                    //                         Text(
                                                    //                           c["type"],
                                                    //                           style:
                                                    //                               const TextStyle(color: Colors.grey),
                                                    //                         ),
                                                    //                       ],
                                                    //                     )
                                                    //                   ],
                                                    //                 ),
                                                    //               ],
                                                    //             ),
                                                    //           ),
                                                    //         ),
                                                    //       ),
                                                    //     ],
                                                    //     onExpansionChanged:
                                                    //         (bool expanded) {},
                                                    //   ),
                                                  ] else if (c["type"] ==
                                                      "SLIDE") ...[
                                                    // ExpansionTile(
                                                    //   iconColor: Colors.black,
                                                    //   textColor: Colors.black,
                                                    //   // collapsedTextColor: Colors.black,

                                                    //   title: Text(v["title"]),

                                                    //   children: [
                                                    //     Padding(
                                                    //       padding:
                                                    //           const EdgeInsets
                                                    //                   .only(
                                                    //               right: 280,
                                                    //               bottom: 10),
                                                    //       child: Text(
                                                    //         v["description"],
                                                    //         style:
                                                    //             const TextStyle(
                                                    //                 color: Colors
                                                    //                     .grey),
                                                    //       ),
                                                    //     ),
                                                    //     Container(
                                                    //       color: Colors.black12,
                                                    //       child: Padding(
                                                    //         padding:
                                                    //             const EdgeInsets
                                                    //                 .all(8.0),
                                                    //         child: InkWell(
                                                    //           onTap: () {
                                                    //             setState(() {
                                                    //               type =
                                                    //                   "slide";
                                                    //               embed.value =
                                                    //                   c["embed"];
                                                    //             });
                                                    //           },
                                                    //           child: Row(
                                                    //             children: [
                                                    //               Align(
                                                    //                 alignment:
                                                    //                     Alignment
                                                    //                         .topLeft,
                                                    //                 child:
                                                    //                     Container(
                                                    //                   height:
                                                    //                       60,
                                                    //                   width:
                                                    //                       100,
                                                    //                   color: Colors
                                                    //                       .blue,
                                                    //                 ),
                                                    //               ),
                                                    //               const SizedBox(
                                                    //                 width: 7,
                                                    //               ),
                                                    //               Column(
                                                    //                 crossAxisAlignment:
                                                    //                     CrossAxisAlignment
                                                    //                         .start,
                                                    //                 children: [
                                                    //                   Row(
                                                    //                     children: [
                                                    //                       Text(c[
                                                    //                           "title"]),
                                                    //                       const Icon(
                                                    //                         Icons.remove_red_eye_outlined,
                                                    //                         size:
                                                    //                             20,
                                                    //                       )
                                                    //                     ],
                                                    //                   ),
                                                    //                   Row(
                                                    //                     children: [
                                                    //                       const Icon(
                                                    //                           FontAwesomeIcons.book,
                                                    //                           color: Colors.grey,
                                                    //                           size: 15),
                                                    //                       const SizedBox(
                                                    //                         width:
                                                    //                             4,
                                                    //                       ),
                                                    //                       Text(
                                                    //                         c["type"],
                                                    //                         style:
                                                    //                             const TextStyle(color: Colors.grey),
                                                    //                       ),
                                                    //                     ],
                                                    //                   )
                                                    //                 ],
                                                    //               ),
                                                    //             ],
                                                    //           ),
                                                    //         ),
                                                    //       ),
                                                    //     ),
                                                    //   ],
                                                    //   onExpansionChanged:
                                                    //       (bool expanded) {},
                                                    // ),
                                                  ] else if (c["type"] ==
                                                      "QUIZ") ...[
                                                    // Container(
                                                    //   child: Container(
                                                    //     height: MediaQuery.of(
                                                    //                 context)
                                                    //             .size
                                                    //             .height /
                                                    //         4,
                                                    //     width: MediaQuery.of(
                                                    //                 context)
                                                    //             .size
                                                    //             .width /
                                                    //         0.5,
                                                    //     child: Card(
                                                    //       child: Align(
                                                    //         alignment: Alignment
                                                    //             .topLeft,
                                                    //         child: Column(
                                                    //           children: [
                                                    //             Padding(
                                                    //               padding: const EdgeInsets
                                                    //                       .only(
                                                    //                   left: 8,
                                                    //                   top: 8),
                                                    //               child: Align(
                                                    //                 alignment:
                                                    //                     Alignment
                                                    //                         .topLeft,
                                                    //                 child:
                                                    //                     Align(
                                                    //                   alignment:
                                                    //                       Alignment
                                                    //                           .topLeft,
                                                    //                   child:
                                                    //                       Text(
                                                    //                     c["quiz"]
                                                    //                         [
                                                    //                         "title"],
                                                    //                     style: TextStyle(
                                                    //                         fontSize:
                                                    //                             30,
                                                    //                         fontWeight:
                                                    //                             FontWeight.w500),
                                                    //                   ),
                                                    //                 ),
                                                    //               ),
                                                    //             ),
                                                    //             Padding(
                                                    //               padding:
                                                    //                   const EdgeInsets
                                                    //                           .all(
                                                    //                       8.0),
                                                    //               child: Align(
                                                    //                 alignment:
                                                    //                     Alignment
                                                    //                         .topLeft,
                                                    //                 child: Text(
                                                    //                   '1 Question',
                                                    //                   style: TextStyle(
                                                    //                       fontSize:
                                                    //                           16,
                                                    //                       fontWeight:
                                                    //                           FontWeight.w300),
                                                    //                 ),
                                                    //               ),
                                                    //             ),
                                                    //             Padding(
                                                    //               padding:
                                                    //                   const EdgeInsets
                                                    //                           .all(
                                                    //                       8.0),
                                                    //               child: Align(
                                                    //                   alignment:
                                                    //                       Alignment
                                                    //                           .topLeft,
                                                    //                   child: Text(
                                                    //                       c["quiz"]
                                                    //                           [
                                                    //                           "subdesc"])),
                                                    //             ),
                                                    //             SizedBox(
                                                    //               height: 10,
                                                    //             ),
                                                    //             Spacer(),
                                                    //             Padding(
                                                    //               padding:
                                                    //                   const EdgeInsets
                                                    //                           .all(
                                                    //                       8.0),
                                                    //               child: Align(
                                                    //                 alignment:
                                                    //                     Alignment
                                                    //                         .topLeft,
                                                    //                 child:
                                                    //                     ElevatedButton(
                                                    //                   onPressed:
                                                    //                       () {
                                                    //                     Navigator.push(
                                                    //                         context,
                                                    //                         MaterialPageRoute(
                                                    //                             builder: (context) => AnsweQuizPage(
                                                    //                                   idCourse: widget.idCourse,
                                                    //                                   // : widget.idCourse,
                                                    //                                   // idCourse: c["quiz"]["questions"].toString(),
                                                    //                                   // quizId: widget.idCourse,
                                                    //                                 )));
                                                    //                     // print(c["quiz"][
                                                    //                     //         "questions"]
                                                    //                     //     .toString());
                                                    //                   },
                                                    //                   child: Text(
                                                    //                       'Start quiz'),
                                                    //                 ),
                                                    //               ),
                                                    //             ),
                                                    //           ],
                                                    //         ),
                                                    //       ),
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                    // ExpansionTile(
                                                    //   iconColor: Colors.black,
                                                    //   textColor: Colors.black,
                                                    //   title: Text(v["title"]),
                                                    //   children: [
                                                    //     Padding(
                                                    //       padding:
                                                    //           const EdgeInsets
                                                    //                   .symmetric(
                                                    //               horizontal:
                                                    //                   18),
                                                    //       child: Row(
                                                    //         children: [
                                                    //           Text(
                                                    //             v["description"]
                                                    //                 .toString(),
                                                    //             // "",
                                                    //             style: TextStyle(
                                                    //                 color: Colors
                                                    //                     .grey),
                                                    //           ),
                                                    //         ],
                                                    //       ),
                                                    //     ),
                                                    //     Container(
                                                    //       color: Colors.black12,
                                                    //       child: Padding(
                                                    //         padding:
                                                    //             const EdgeInsets
                                                    //                 .all(8.0),
                                                    //         child: InkWell(
                                                    //           onTap: () {
                                                    //             setState(() {
                                                    //               // type = "QUIZ";
                                                    //               quiz.value =
                                                    //                   c["quiz"];
                                                    //               Navigator.push(
                                                    //                   context,
                                                    //                   MaterialPageRoute(
                                                    //                       builder: (context) => QuizPage(
                                                    //                             quiz: quiz,
                                                    //                             idCourse: widget.idCourse,
                                                    //                           )));
                                                    //             });
                                                    //           },
                                                    //           child: Row(
                                                    //             children: [
                                                    //               Align(
                                                    //                 alignment:
                                                    //                     Alignment
                                                    //                         .topLeft,
                                                    //                 child:
                                                    //                     Container(
                                                    //                   height:
                                                    //                       60,
                                                    //                   width:
                                                    //                       100,
                                                    //                   color:
                                                    //                       getRandomColor(),
                                                    //                 ),
                                                    //               ),
                                                    //               SizedBox(
                                                    //                 width: 7,
                                                    //               ),
                                                    //               Column(
                                                    //                 crossAxisAlignment:
                                                    //                     CrossAxisAlignment
                                                    //                         .start,
                                                    //                 children: [
                                                    //                   Row(
                                                    //                     children: [
                                                    //                       Text(c[
                                                    //                           "title"]),
                                                    //                       Icon(
                                                    //                         Icons.remove_red_eye_outlined,
                                                    //                         size:
                                                    //                             20,
                                                    //                       ),
                                                    //                     ],
                                                    //                   ),
                                                    //                   Row(
                                                    //                     children: [
                                                    //                       Icon(
                                                    //                         Icons.table_rows,
                                                    //                         color:
                                                    //                             Colors.grey,
                                                    //                         size:
                                                    //                             20,
                                                    //                       ),
                                                    //                       Text(
                                                    //                         c["type"],
                                                    //                         style:
                                                    //                             TextStyle(color: Colors.grey),
                                                    //                       ),
                                                    //                     ],
                                                    //                   )
                                                    //                 ],
                                                    //               ),
                                                    //             ],
                                                    //           ),
                                                    //         ),
                                                    //       ),
                                                    //     )
                                                    //   ],
                                                    //   onExpansionChanged:
                                                    //       (bool expanded) {},
                                                    // ),
                                                  ]
                                                ],
                                              ),
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                  );
                                })
                              ],
                            ],
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
