import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:padeprokan/components/organisms/appBar/appbar_widget.dart';
import 'package:padeprokan/graphql/courses/get_all_quorses.dart';
import 'package:padeprokan/graphql/courses/get_space_courses.dart';
import 'package:padeprokan/views/space/features/courses/slide/slide.dart';
import 'package:padeprokan/views/space/features/courses/video/videoqw.dart';

class CourseArticleIndexView extends StatefulWidget {
  final String spaceId;

  CourseArticleIndexView({Key? key, required this.spaceId}) : super(key: key);
  @override
  State<CourseArticleIndexView> createState() => _CoursesIndexViewState();
}

class _CoursesIndexViewState extends State<CourseArticleIndexView> {
  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(document: gql(coursesQuery), variables: {
          "idSpace": widget.spaceId,
        }),
        builder: (result, {fetchMore, refetch}) {
          if (result.hasException) {
            return const Text("error");
          }

          return Scaffold(
            appBar: appBarWidget(context, 'Courses'),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (result.data != null) ...[
                        ...result.data!['courses'].map((allcourses) {
                          var cobalagi = allcourses['article'];
                          [
                            ...cobalagi.map((article) {
                            })
                          ];
                        })
                      ],
                      const Text(
                        'coba',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.circle,
                            size: 40,
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            'Rifqi Maulana   •',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const Text(
                        'Cobaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
                        style: TextStyle(fontSize: 15),
                      ),
                      const SizedBox(
                        height: 120,
                      ),
                      const Divider(
                        color: Colors.black,
                        thickness: 0.2,
                      ),
                      Row(
                        children: [
                          Container(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueGrey),
                              child: const Text(
                                "<< Previous",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => VideoQwPage(
                                            embed: ValueNotifier(""),
                                          )),
                                );
                              },
                            ),
                          ),
                          const Spacer(),
                          Container(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueGrey),
                              child: const Text(
                                "Next >>",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => slide(
                                        embed: ValueNotifier(''), spaceId: widget.spaceId,
                                            // spaceId: 'courses',
                                          )),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        child: Row(
                          children: const [
                            Text(
                              "Course Content",
                              style: TextStyle(fontSize: 22),
                            ),
                            Spacer(),
                            Text(
                              ">>",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.blue),
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   height: 25,
                      // ),
                      // Divider(
                      //   color: Colors.black,
                      //   thickness: 0.2,
                      // ),
                      // Container(
                      //   child: ElevatedButton.icon(
                      //     style: ElevatedButton.styleFrom(
                      //         backgroundColor: Color.fromARGB(255, 255, 145, 0)),
                      //     onPressed: () {},
                      //     icon: Icon(
                      //       Icons.add_outlined,
                      //       color: Colors.white,
                      //     ),
                      //     label: Text(
                      //       "Add Section",
                      //       style: TextStyle(color: Colors.white),
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(
                        height: 10,
                      ),
                      ExpansionTile(
                        title: Row(
                          children: [
                            const Text(
                              'Coba',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            IconButton(
                              icon: const Icon(
                                Icons.add_circle,
                                color: Colors.purple,
                              ),
                              onPressed: () {
                                // showDialog(
                                //   context: context,
                                //   builder: (context) => AlertDialog(
                                //     title: SingleChildScrollView(
                                //       child: Column(
                                //         children: [
                                //           Row(
                                //             children: [
                                //               Text("Add Lecture"),
                                //             ],
                                //           ),
                                //           SizedBox(
                                //             height: 20,
                                //           ),
                                //           Row(
                                //             children: [
                                //               Text(
                                //                 "Lecture Title",
                                //                 style: TextStyle(
                                //                   fontSize: 14,
                                //                   color: Color(0xFF808080),
                                //                 ),
                                //               ),
                                //             ],
                                //           ),
                                //           SizedBox(
                                //             height: 10,
                                //           ),
                                //           Container(
                                //             height: 40,
                                //             child: TextFormField(
                                //               cursorColor: Colors.black,
                                //               decoration: InputDecoration(
                                //                 fillColor:
                                //                     Color.fromRGBO(173, 120, 211, 1),
                                //                 hintStyle: TextStyle(
                                //                   color: Colors.grey,
                                //                   fontSize: 14,
                                //                 ),
                                //                 hintText: "Insert Lecture title here",
                                //                 border: OutlineInputBorder(
                                //                   borderRadius:
                                //                       BorderRadius.circular(5),
                                //                   borderSide: BorderSide(
                                //                     color: Color.fromRGBO(
                                //                         173, 120, 211, 1),
                                //                   ),
                                //                 ),
                                //               ),
                                //             ),
                                //           ),
                                //           SizedBox(
                                //             height: 25,
                                //           ),
                                //           Row(
                                //             children: [
                                //               Text(
                                //                 "Type",
                                //                 style: TextStyle(fontSize: 14),
                                //               ),
                                //             ],
                                //           ),
                                //         ],
                                //       ),
                                //     ),
                                //   ),
                                // );
                              },
                            )
                          ],
                        ),
                        children: [
                          Row(
                            children: const [
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 18),
                                child: Text("Coba"),
                              ),
                            ],
                          ),
                          Container(
                            color: Colors.grey.shade200,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                      height: 60,
                                      width: 100,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Icon(Icons.table_rows),
                                  const Text(
                                    "ARTICLE",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                        onExpansionChanged: (bool expanded) {},
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
