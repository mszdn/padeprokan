import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:padeprokan/components/utils/theme_colors.dart';
import 'package:padeprokan/views/auth/register_view.dart';
import 'package:padeprokan/views/space/space_index_view.dart';
// import 'package:padeprokan/views/home/home.dart';

class ButtonLogin extends StatefulWidget {
  const ButtonLogin({super.key});

  @override
  State<ButtonLogin> createState() => _ButtonLoginState();
}

class _ButtonLoginState extends State<ButtonLogin> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorStyle().yellowButton,
              ),
              child: const Text(
                'Login',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                
              }),
        ),
      ),
    );
  }
}
