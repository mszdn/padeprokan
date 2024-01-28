import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:padeprokan/blocs/login_bloc.dart';
import 'package:padeprokan/views/auth/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../graphql/auth/myuser.dart';
import '../../../views/profile/profilview.dart';

AppBar appBarWidget(
  BuildContext context,
  String routeName,
  // GlobalKey<ScaffoldState> scaffold
) {
  LoginBloc loginBloc = BlocProvider.of<LoginBloc>(context);

  return AppBar(
    backgroundColor: Colors.white,
    shadowColor: null,
    elevation: 0,
    leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        )),
    // leading: IconButton(
    //   icon: const Icon(
    //     Icons.arrow_back_ios,
    //     color: Colors.black,
    //   ),),
    //   onPressed: () async {
    //     final sharedPref = await SharedPreferences.getInstance();
    //     sharedPref.remove("token");
    //     sharedPref.remove("user");
    //     loginBloc.generateToken("");
    //     // print("object");
    //     Timer(
    //         const Duration(milliseconds: 500),
    //         () => Navigator.push(context,
    //             MaterialPageRoute(builder: (context) => const LoginView())));
    //   },
    // ),
    centerTitle: true,
    title: Text(
      routeName,
      style: const TextStyle(color: Colors.black),
    ),
    // actions: <Widget>[
    //   IconButton(
    //     icon: const Icon(
    //       Icons.notifications,
    //       color: Colors.black,
    //     ),
    //     onPressed: () {},
    //   ),
    //   IconButton(
    //     icon: const Icon(
    //       Icons.person,
    //       color: Colors.black,
    //     ),
    //     onPressed: () => scaffold.currentState!.openEndDrawer(),
    //   ),
    // ],
    actions: <Widget>[
      // IconButton(
      //   icon: const Icon(
      //     Icons.notifications,
      //     color: Colors.black,
      //   ),
      //   onPressed: () {},
      // ),
      PopupMenuButton(
        icon: const Icon(Icons.person),
        itemBuilder: (context) => [
          PopupMenuItem(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => profilview()));
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Query(
                          options: QueryOptions(
                            document: gql(simpleMyUser),
                          ),
                          builder: (result, {fetchMore, refetch}) {
                            print(result.data?['user']['firstName']);
                            return Text("${result.data?['user']['firstName']}");
                          },
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () async {
                    final sharedPref = await SharedPreferences.getInstance();
                    sharedPref.remove("token");
                    loginBloc.generateToken("");
                    // print("object");
                    Timer(
                        const Duration(milliseconds: 500),
                        () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginView())));
                  },
                  child: const Text(
                    "Logout",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ],
  );
}
