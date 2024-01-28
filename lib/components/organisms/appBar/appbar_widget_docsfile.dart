import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:padeprokan/blocs/login_bloc.dart';
import 'package:padeprokan/graphql/auth/myuser.dart';
import 'package:padeprokan/views/auth/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

AppBar MyAppBar(BuildContext context, String title) {
  LoginBloc loginBloc = BlocProvider.of<LoginBloc>(context);

  return AppBar(
    centerTitle: true,
    title: Text(
      title,
      style: const TextStyle(
        color: Colors.black,
      ),
    ),
    elevation: 0,
    backgroundColor: Colors.white,
    leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_ios_rounded,
          color: Colors.black,
        )),
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.notifications,
          color: Colors.black,
        ),
      ),
      Query(
          options: QueryOptions(
            document: gql(simpleMyUser),
          ),
          builder: (result, {fetchMore, refetch}) {
            if (result.data == null) {
              return const Center(
                child: Text("Loading"),
              );
            } else {
              return PopupMenuButton(
                icon: const Icon(Icons.person),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Container(
                      child: ListTile(
                        leading: const CircleAvatar(),
                        title:
                            Text(result.data!["user"]["firstName"].toString()),
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    child: TextButton(
                      onPressed: () async {
                        final sharedPref =
                            await SharedPreferences.getInstance();
                        await sharedPref.remove("token");
                        loginBloc.generateToken("");
                        Timer(
                          const Duration(milliseconds: 500),
                          () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginView(),
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        "Change password",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    child: TextButton(
                      onPressed: () async {
                        final sharedPref =
                            await SharedPreferences.getInstance();
                        await sharedPref.remove("token");
                        loginBloc.generateToken("");
                        Timer(
                          const Duration(milliseconds: 500),
                          () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginView(),
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        "Logout",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              );
            }
          }),
    ],
  );
}
