import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GetImageCoursesView extends StatefulWidget {
  const GetImageCoursesView({super.key});

  @override
  State<GetImageCoursesView> createState() => _GetImageCoursesState();
}

class _GetImageCoursesState extends State<GetImageCoursesView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Center(
            child: SvgPicture.asset(
              "assets/images/section.svg",
              width: MediaQuery.of(context).size.width / 2,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "This Course is Empty!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          // Container(
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: SizedBox(
          //       width: 200,
          //       height: 40,
          //       child: ElevatedButton(
          //           style: ElevatedButton.styleFrom(
          //             backgroundColor: Colors.orange,
          //           ),
          //           child: Text(
          //             'Create New Courses',
          //             style: TextStyle(color: Colors.white),
          //           ),
          //           onPressed: () {}),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
