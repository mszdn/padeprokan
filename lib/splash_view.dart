import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:padeprokan/blocs/login_bloc.dart';
import 'package:padeprokan/views/auth/login_view.dart';
import 'package:padeprokan/views/spaces/spaces_index_view.dart';
import 'package:padeprokan/welcome_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  void checkLogin(LoginBloc loginBloc) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString("token") != null) {
      Timer(
        const Duration(seconds: 2),
        () {
          loginBloc.generateToken(prefs.getString("token") ?? "");
        },
      );
      Timer(
          const Duration(milliseconds: 2),
          () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => const SpacesIndexView()),
                (Route<dynamic> route) => false,
              ));
    } else {
      Timer(
          const Duration(seconds: 2),
          () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginView())));
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      // showDialog(
      //   useSafeArea: false,
      //   context: context,
      //   builder: (context) {
      // LoginBloc loginBloc = BlocProvider.of<LoginBloc>(context);
      // checkLogin(loginBloc);

      //     return Dialog(
      //       backgroundColor: Colors.transparent,
      //       child: Container(
      //           alignment: FractionalOffset.center,
      //           height: 80.0,
      //           padding: const EdgeInsets.all(20.0),
      //           child: const Text("")),
      //     );
      //   },
      // );
      showGeneralDialog(
          context: context,
          pageBuilder: (BuildContext buildContext, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            LoginBloc loginBloc = BlocProvider.of<LoginBloc>(context);
            checkLogin(loginBloc);
            return SafeArea(child: Builder(builder: (context) {
              return Container();
            }));
          },
          barrierDismissible: true,
          barrierColor: Colors.transparent,
          barrierLabel:
              MaterialLocalizations.of(context).modalBarrierDismissLabel,
          transitionDuration: const Duration(milliseconds: 150));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Center(
          // heightFactor: ,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Image.asset(
                'assets/images/padeprokan.png',
                width: MediaQuery.of(context).size.width / 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
