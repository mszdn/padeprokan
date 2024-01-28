import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:padeprokan/components/organisms/appBar/appbar_widget.dart';
// import 'package:padeprokan/components/organisms/appBar/appbar_widget_courses.dart';
import 'package:padeprokan/components/organisms/get_image/get_image_courses.dart';
// import 'package:padeprokan/components/organisms/get_image/get_image_space_courses.dart';
import 'package:padeprokan/graphql/courses/get_all_quorses.dart';
import 'package:padeprokan/graphql/courses/get_space_courses.dart';
import 'package:padeprokan/views/space/features/courses/article/map_course_view.dart';
// import 'package:padeprokan/views/space/features/courses/article/no_courses_view.dart';
import 'package:padeprokan/views/space/features/courses/article/no_space_courses_index_view.dart';
import 'package:padeprokan/views/space/features/courses/quiz/quiz_view.dart';
// import 'package:padeprokan/views/space/features/courses/slide.dart';
// import 'package:padeprokan/views/space/features/courses/article/courses_article_index_view.dart';
// import 'package:padeprokan/views/space/features/courses/space_courses/no_space_courses_index_view.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';
import 'dart:math' as math;

import 'package:flutter_randomcolor/flutter_randomcolor.dart';

class SpaceCoursesIndexView extends StatefulWidget {
  final String spaceId;
  // final String idCourse;
  // final String createdById;
  // final List<Map<String, dynamic>> myList = [
  //   {
  //     "name": "Gataujuga",
  //   },
  //   {
  //     "name": "Gatau",
  //   },
  // ];

  SpaceCoursesIndexView({
    Key? key,
    required this.spaceId,
    // required this.idCourse,
    //required this.createdById
  }) : super(key: key);

  @override
  State<SpaceCoursesIndexView> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<SpaceCoursesIndexView> {
  final rnd = math.Random();

  Color getRandomColor() => Color(rnd.nextInt(0xffffffff));

  // var myList;

  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(document: gql(coursesQuery), variables: {
          "idSpace": widget.spaceId,
          // "idCourse": "63f4f6c7f5292300332ff713",
        }),
        builder: (result, {fetchMore, refetch}) {
          if (result.data != null) {
          }
          if (result.hasException) {
            return const Center(
              child: Text("error"),
            );
          }
          if (result.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          // return NoSpaceCourses();
          return Scaffold(
            appBar: appBarWidget(context, "Courses"),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  // result.data![0]["description"] == "Coba dongdssd"
                  //?

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: Container(
                      height: 35,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                        border:
                            Border.all(color: Colors.grey.shade200, width: 0.5),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 20),
                            hintText: "Search course by title or categories",
                            suffixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5))),
                      ),
                    ),
                  ),
                  // :
                  if (result.data?["courses"].length == 0) ...[
                    const GetImageCourses(),
                  ],
                  Wrap(
                    children: [
                      Container(
                        child: GridView.count(
                          primary: false,
                          padding: const EdgeInsets.all(5),
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          shrinkWrap: true,
                          children: [
                            if (result.data != null) ...[
                              ...result.data!['courses'].map(
                                (course) {
                                  var coba = course['courseCategories'] ?? "";
                                  [
                                    ...coba.map((category) {
                                    })
                                  ];
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                      });
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MapCourseView(
                                            idCourse: course["id"],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Ink(
                                      child: Column(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.2,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                3.2,
                                            child: Card(
                                              color: getRandomColor(),
                                              elevation: 2,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Column(
                                                // crossAxisAlignment:
                                                //     CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2.2,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            6.5,
                                                    color: Colors.white,
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              const SizedBox(
                                                                height: 20,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  ...coba.map(
                                                                      (category) {
                                                                    return Text(
                                                                      category[
                                                                              "name"]
                                                                          .toString(),
                                                                      style: const TextStyle(
                                                                          overflow:
                                                                              TextOverflow.ellipsis),
                                                                    );
                                                                  }),
                                                                  // Icon(Icons
                                                                  //     .abc_rounded)
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 15,
                                                              ),
                                                              SizedBox(
                                                                width: 150,
                                                                child: Text(
                                                                  course["title"] ??
                                                                      "",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 15,
                                                              ),
                                                              SizedBox(
                                                                width: 150,
                                                                child: Text(
                                                                  course["description"] ??
                                                                      "",
                                                                  // "ss",
                                                                  maxLines: 1,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ] else ...[
                              // NoSpaceCourses(),
                            ]
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            // floatingActionButton: SpeedDial(
            //   child: const Icon(
            //     Icons.add,
            //     color: Colors.white,
            //     size: 30,
            //   ),
            //   speedDialChildren: <SpeedDialChild>[
            //     SpeedDialChild(
            //         child: Icon(
            //           Icons.add_to_drive_outlined,
            //           color: Colors.white,
            //         ),
            //         label: "Add Course",
            //         onPressed: () {
            //           showDialog(
            //             context: context,
            //             builder: (context) => AlertDialog(
            //               title: Row(
            //                 children: [
            //                   Text(
            //                     "Add Course",
            //                     style: TextStyle(
            //                       fontSize: 16,
            //                     ),
            //                   ),
            //                   Padding(
            //                     padding: const EdgeInsets.symmetric(horizontal: 0),
            //                     child: IconButton(
            //                       alignment: Alignment.centerRight,
            //                       onPressed: () => Navigator.of(context).pop(),
            //                       icon: Icon(Icons.close),
            //                       iconSize: 14,
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //               content: Container(
            //                 height: 420,
            //                 width: 315,
            //                 child: Column(
            //                   children: [
            //                     Row(
            //                       children: [
            //                         Text('Title'),
            //                         Padding(
            //                           padding: const EdgeInsets.only(left: 5),
            //                           child: Text(
            //                             '*',
            //                             style: TextStyle(
            //                               color: Colors.red,
            //                             ),
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                     SizedBox(height: 10),
            //                     Container(
            //                       height: 45,
            //                       child: TextField(
            //                         decoration: InputDecoration(
            //                           border: OutlineInputBorder(
            //                               borderRadius: BorderRadius.circular(8)),
            //                           hoverColor: Colors.purple,
            //                           hintText: 'Insert Course title',
            //                           hintStyle: TextStyle(
            //                             color: Colors.grey,
            //                           ),
            //                         ),
            //                         keyboardType: TextInputType.text,
            //                       ),
            //                     ),
            //                     SizedBox(
            //                       height: 20,
            //                     ),
            //                     Row(
            //                       children: [
            //                         Text('Categories'),
            //                         Padding(
            //                           padding: const EdgeInsets.only(left: 5),
            //                           child: Text(
            //                             '*',
            //                             style: TextStyle(
            //                               color: Colors.red,
            //                             ),
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                     SizedBox(
            //                       height: 10,
            //                     ),
            //                     Container(
            //                       height: 45,
            //                       child: TextField(
            //                         decoration: InputDecoration(
            //                           border: OutlineInputBorder(
            //                             borderRadius: BorderRadius.circular(8),
            //                           ),
            //                           hintText: 'Please Select Categories',
            //                           hintStyle: TextStyle(color: Colors.grey),
            //                         ),
            //                         keyboardType: TextInputType.text,
            //                       ),
            //                     ),
            //                     Row(
            //                       children: [
            //                         Text('Estimate finish time'),
            //                         Padding(
            //                           padding: const EdgeInsets.only(left: 5),
            //                           child: Text(
            //                             '*',
            //                             style: TextStyle(
            //                               color: Colors.red,
            //                             ),
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                     SizedBox(
            //                       height: 5,
            //                     ),
            //                     Container(
            //                       height: 45,
            //                       child: TextField(
            //                         decoration: InputDecoration(
            //                           border: OutlineInputBorder(
            //                             borderRadius: BorderRadius.circular(8),
            //                           ),
            //                           hintText: '00:00:00',
            //                           hintStyle: TextStyle(color: Colors.grey),
            //                         ),
            //                         keyboardType: TextInputType.text,
            //                       ),
            //                     ),
            //                     SizedBox(
            //                       height: 10,
            //                     ),
            //                     Row(
            //                       children: [
            //                         Text('Description'),
            //                         Padding(
            //                           padding: const EdgeInsets.only(left: 5),
            //                           child: Text(
            //                             '*',
            //                             style: TextStyle(
            //                               color: Colors.red,
            //                             ),
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                     SizedBox(
            //                       height: 10,
            //                     ),
            //                     Container(
            //                       height: 70,
            //                       child: TextField(
            //                         decoration: InputDecoration(
            //                           border: OutlineInputBorder(
            //                             borderRadius: BorderRadius.circular(8),
            //                           ),
            //                           hintText: 'Insert Course Description',
            //                           hintStyle: TextStyle(color: Colors.grey),
            //                         ),
            //                         keyboardType: TextInputType.text,
            //                       ),
            //                     ),
            //                     SizedBox(
            //                       height: 30,
            //                     ),
            //                     Row(
            //                       crossAxisAlignment: CrossAxisAlignment.end,
            //                       children: [
            //                         Spacer(),
            //                         Container(
            //                           child: Column(
            //                             children: [
            //                               Container(
            //                                 height: 40,
            //                                 decoration: BoxDecoration(
            //                                     color: Colors.white,
            //                                     borderRadius:
            //                                         BorderRadius.circular(5),
            //                                     border:
            //                                         Border.all(color: Colors.black)),
            //                                 child: TextButton(
            //                                   onPressed: () =>
            //                                       Navigator.of(context).pop(),
            //                                   child: Text(
            //                                     'Cancel',
            //                                     style: TextStyle(
            //                                       color: Colors.black,
            //                                     ),
            //                                   ),
            //                                 ),
            //                               ),
            //                             ],
            //                           ),
            //                         ),
            //                         SizedBox(
            //                           width: 20,
            //                         ),
            //                         Container(
            //                           child: Column(
            //                             children: [
            //                               Container(
            //                                 height: 40,
            //                                 decoration: BoxDecoration(
            //                                   color: Colors.purple,
            //                                   borderRadius: BorderRadius.circular(5),
            //                                   border: Border.all(
            //                                     color:
            //                                         Color.fromRGBO(173, 120, 211, 1),
            //                                   ),
            //                                 ),
            //                                 child: TextButton(
            //                                   onPressed: () =>
            //                                       Navigator.of(context).pop(),
            //                                   child: Text(
            //                                     'Submit',
            //                                     style: TextStyle(
            //                                       color: Colors.white,
            //                                     ),
            //                                   ),
            //                                 ),
            //                               ),
            //                             ],
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ),
            //           );
            //         }),
            //   ],
            // ),
          );
        });
  }
}
