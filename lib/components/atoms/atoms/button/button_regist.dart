import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:padeprokan/components/utils/theme_colors.dart';

class ButtonDaftar extends StatefulWidget {
  const ButtonDaftar({super.key});

  @override
  State<ButtonDaftar> createState() => ButtonDaftarState();
}

class ButtonDaftarState extends State<ButtonDaftar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: ElevatedButton(
              child: const Text('Register'),
              onPressed: () {
                
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => LoginPage()),
                // );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorStyle().yellowButton,
              )),
        ),
      ),
    );
  }
}
