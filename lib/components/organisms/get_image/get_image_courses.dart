import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GetImageCourses extends StatefulWidget {
  const GetImageCourses({super.key});

  @override
  State<GetImageCourses> createState() => _GetImageCoursesState();
}

class _GetImageCoursesState extends State<GetImageCourses> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SvgPicture.asset(
            "assets/images/courselist.svg",
            width: MediaQuery.of(context).size.width / 2,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "You're Space not have course now!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 200,
                height: 40,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                    child: const Text(
                      'Create New Courses',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {}),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
