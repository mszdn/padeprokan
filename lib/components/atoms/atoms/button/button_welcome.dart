import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:padeprokan/components/utils/theme_colors.dart';
import 'package:padeprokan/views/auth/login_view.dart';
import 'package:padeprokan/views/auth/register_view.dart';

class ButtonWelcome extends StatefulWidget {
  const ButtonWelcome({super.key});

  @override
  State<ButtonWelcome> createState() => _ButtonWelcomeState();
}

class _ButtonWelcomeState extends State<ButtonWelcome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginView()),
                );
              },
              child: const Text('Login'),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorStyle().yellowButton,
              ),
            )),
      ),
    );
  }
}

class ButtonRegist extends StatefulWidget {
  const ButtonRegist({super.key});

  @override
  State<ButtonRegist> createState() => _ButtonRegistState();
}

class _ButtonRegistState extends State<ButtonRegist> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginView()),
              );
            },
            child: const Text('Register'),
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 223, 219, 211)),
          ),
        ),
      ),
    );
  }
}
