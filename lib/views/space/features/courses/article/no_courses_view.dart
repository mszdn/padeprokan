import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:padeprokan/components/organisms/appBar/appbar_widget.dart';
import 'package:padeprokan/components/organisms/get_image/get_image_courses_view..dart';
// import 'package:padeprokan/components/organisms/get_image/get_image_space_courses.dart';

class NoCoursesView extends StatefulWidget {
  const NoCoursesView({super.key});

  @override
  State<NoCoursesView> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<NoCoursesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context, "Courses"),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Container(
              height: 35,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade200, width: 0.5),
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
          GetImageCoursesView(),
        ],
      ),
      // floatingActionButton: SpeedDial(
      //   child: const Icon(
      //     Icons.add,
      //     color: Colors.white,
      //     size: 30,
      //   ),
      //   speedDialChildren: [
      //     SpeedDialChild(
      //       child: const Icon(
      //         Icons.add_to_drive_outlined,
      //         color: Colors.white,
      //       ),
      //       label: "Add Course",
      //       onPressed: () {
      //         showDialog(
      //           context: context,
      //           builder: (context) => AlertDialog(
      //             title: Text("Add Course"),
      //             content: SingleChildScrollView(
      //               child: Container(
      //                 child: Column(
      //                   children: [
      //                     Row(
      //                       children: [
      //                         Text("Title"),
      //                         Padding(
      //                           padding: const EdgeInsets.only(left: 5),
      //                           child: Text(
      //                             "*",
      //                             style: TextStyle(color: Colors.red),
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                     SizedBox(
      //                       height: 10,
      //                     ),
      //                     Container(
      //                       height: 40,
      //                       child: TextFormField(
      //                         cursorColor: Colors.black,
      //                         decoration: InputDecoration(
      //                           fillColor: Color.fromRGBO(173, 120, 211, 1),
      //                           hintStyle: TextStyle(
      //                             color: Colors.grey,
      //                             fontSize: 14,
      //                           ),
      //                           hintText: "Insert Courses Title",
      //                           border: OutlineInputBorder(
      //                             borderRadius: BorderRadius.circular(5),
      //                             borderSide: BorderSide(
      //                               color: Color.fromRGBO(173, 120, 211, 1),
      //                             ),
      //                           ),
      //                         ),
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ),
      //           ),
      //         );
      //       },
      //     ),
      //   ],
      // ),
    );
  }
}
