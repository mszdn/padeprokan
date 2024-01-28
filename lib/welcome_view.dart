import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:padeprokan/components/atoms/button/button_welcome.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Image.asset('assets/images/logo.png'),
              ),
            ),
            const Text('Selamat Datang Di Padeprokan'),
            const Spacer(),
            const SizedBox(
              height: 20,
            ),
            const ButtonWelcome(),
            const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: ButtonRegist(),
            ),
          ],
        ),
      ),
    );
  }
}
