import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:padeprokan/blocs/login_bloc.dart';
import 'package:padeprokan/components/organisms/appBar/appbar_widget.dart';
import 'package:padeprokan/components/organisms/modal/manage_members_modal.dart';
import 'package:padeprokan/graphql/auth/myuser.dart';
import 'package:padeprokan/views/auth/login_view.dart';
import 'package:padeprokan/views/coments/coment.dart';
import 'package:padeprokan/views/scheduled1/pages/calendar_page.dart';
import 'package:padeprokan/views/space/features/automaticCheckins/automatic_checkin_index.dart';
import 'package:padeprokan/views/space/features/chat/chat_index_view.dart';
// import 'package:padeprokan/views/space/features/groupchat/groupchat_index_view.dart';
import 'package:padeprokan/views/space/features/conference/conference_index_view.dart';
import 'package:padeprokan/views/space/features/conference/test_jitsi_meet.dart';
import 'package:padeprokan/views/space/features/courses/article/courses_index_view.dart';
import 'package:padeprokan/views/space/features/courses/article/map_course_view.dart';
import 'package:padeprokan/views/space/features/courses/article/space_courses_index_view.dart';
// import 'package:padeprokan/views/space/features/courses/space_courses/space_courses_index_view.dart';
// import 'package:padeprokan/views/space/features/groupchat/groupchat_index_view.dart';
import 'package:padeprokan/views/space/features/conference/conference_index_view.dart';
import 'package:padeprokan/views/space/features/courses/quiz/quiz_view.dart';
import 'package:padeprokan/views/space/features/docsfiles/docs_files_view.dart';
import 'package:padeprokan/views/space/features/info_board/info_board_view.dart';
import 'package:padeprokan/views/space/features/schedule/schedule_calendar.dart';
import 'package:padeprokan/views/space/features/task/task_index_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpaceIndexView extends StatefulWidget {
  final dynamic spaceMenu;
  final String spaceId;
  final String spaceName;
  // final String idCourse;
  // final String createdById;
  const SpaceIndexView(
      this.spaceMenu, this.spaceId, this.spaceName,
      // this.idCourse,
      //this.createdById,
      {super.key});

  @override
  State<SpaceIndexView> createState() => _SpaceIndexViewState();
}

class _SpaceIndexViewState extends State<SpaceIndexView> {
  List menus = [
    {
      "mgCheck": "conference",
      "key": "videoConverence",
      "title": "Video Conference",
      "thumbnail": "assets/images/conference.png",
      "description": "Meet your team online",
      "color": "yellow",
    },
    {
      "mgCheck": "course",
      "key": "courses",
      "title": "Courses",
      "thumbnail": "assets/images/courses.png",
      "description":
          "Collection of our learning materials on any format such as Video, Ebook, Doc, etc",
      "color": "green",
    },
    {
      "mgCheck": "docFile",
      "key": "docsFiles",
      "title": "Docs & Files",
      "thumbnail": "assets/images/docs.png",
      "description": "Upload or Read your Docs & Files here",
      "color": "red",
    },
    {
      "mgCheck": "schedule",
      "key": "schedule",
      "title": "Schedule",
      "thumbnail": "assets/images/schedule.png",
      "description": "Schedule your work/activities timeline here",
      "color": "purple",
    },
    {
      "mgCheck": "autoCheckIn",
      "key": "automaticCheckins",
      "title": "Automatic Check-ins",
      "thumbnail": "assets/images/checkin.png",
      "description": "Daily Report to track your own/team progress",
      "color": "yellow",
    },
    {
      "mgCheck": "groupChat",
      "key": "grupChat",
      "title": "Group Chat",
      "thumbnail": "assets/images/groupchat.png",
      "description":
          "Chit Chat about your work progress, your daily acitivity, or just some random talk",
      "color": "red",
    },
    {
      "mgCheck": "infoBoard",
      "key": "infoBoard",
      "title": "Info Board",
      "thumbnail": "assets/images/infoboard.png",
      "description": "Get the latest information on your workplace/school",
      "color": "purple",
    },
    {
      "mgCheck": "task",
      "key": "tasks",
      "title": "Tasks",
      "thumbnail": "assets/images/tasks.png",
      "description": "Kanban Board to track your Task/Project",
      "color": "green",
    }
  ];

  @override
  Widget build(BuildContext context) {
    List menusAvailable = [];
    widget.spaceMenu != null
        ? menus.map((menu) {
            if (widget.spaceMenu[menu["mgCheck"]]) {
              menusAvailable.add({
                "key": menu["key"],
                "thumbnail": menu["thumbnail"],
                "title": menu["title"],
                "description": menu["description"]
              });
            }
          }).toList()
        : menusAvailable.add({
            "key": "pass",
            "thumbnail": "pass",
            "title": "pass",
            "description": "pass"
          });

    return Scaffold(
      appBar: appBarWidget(context, widget.spaceName),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Query(
                //     options: QueryOptions(
                //       // fetchPolicy: FetchPolicy.networkOnly,
                //       document: gql(simpleMyUser),
                //       // pollInterval: const Duration(seconds: 10),
                //     ),
                //     builder: (result, {fetchMore, refetch}) {
                //       if (result.isLoading) {
                //         return const Text('Loading');
                //       }
                //       print(result);
                //       return ElevatedButton(
                //           onPressed: () {}, child: const Text("aaaa"));
                //     }),
                IconButton(
                  icon: const Icon(Icons.more_horiz_outlined, size: 40),
                  onPressed: () {
                    manageMembers(context, widget.spaceId);
                  },
                ),
              ],
            ),
          ),
          Flexible(
              child: GridView.count(
                  primary: false,
                  padding: const EdgeInsets.all(5),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  childAspectRatio: 0.6,
                  shrinkWrap: true,
                  children: [
                if (widget.spaceMenu == null &&
                    menusAvailable[0]["key"] == "pass") ...[
                  ...menus.map((menu) {
                    return InkWell(
                      onTap: () {
                        switch (menu["key"]) {
                          case "videoConverence":
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ConferencePage(
                                    spaceId: widget.spaceId,
                                  ),
                                ));
                            break;
                          case "docsFiles":
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DocsFilesView(
                                    spaceId: widget.spaceId,
                                    folderId: widget.spaceName,
                                  ),
                                ));
                            break;
                          case "courses":
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SpaceCoursesIndexView(
                                          spaceId: widget.spaceId,
                                        )));
                            break;
                          case "schedule":
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CalendarPage(spaceId: widget.spaceId)));
                            break;
                          case "automaticCheckins":
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AutomaticCheckinsScreen(
                                          spaceId: widget.spaceId,
                                          id: '',
                                          refetchSpaces: null,
                                        )));
                            break;
                          case "infoBoard":
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => coment(
                                          spaceId: widget.spaceId,
                                          postId: '',
                                        )));
                            break;
                          case "tasks":
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TaskIndexView(
                                          spaceId: widget.spaceId,
                                        )));
                            break;
                          case "grupChat":
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatIndexView(
                                    spaceId: widget.spaceId,
                                  ),
                                ));
                            break;
                        }
                      },
                      child: Ink(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Card(
                            color: Colors.white,
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(menu["thumbnail"],
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.2),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      menu["title"],
                                      // maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    SizedBox(
                                      height: 70,
                                      child: Text(
                                        menu["description"],
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            overflow: TextOverflow.fade),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      ),
                    );
                  })
                ] else ...[
                  ...menusAvailable.map((menu) {
                    return InkWell(
                      onTap: () {
                        switch (menu["key"]) {
                          case "videoConverence":
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ConferencePage(
                                    spaceId: widget.spaceId,
                                  ),
                                ));
                            break;
                          case "docsFiles":
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DocsFilesView(
                                    spaceId: widget.spaceId,
                                    folderName: widget.spaceName,
                                  ),
                                ));
                            break;
                          case "courses":
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SpaceCoursesIndexView(
                                    spaceId: widget.spaceId,
                                    // idCourse: "63f4f6c7f5292300332ff713",
                                  ),
                                ));
                            break;
                          case "grupChat":
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatIndexView(
                                    spaceId: widget.spaceId,
                                  ),
                                ));
                            break;
                          case "automaticCheckins":
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AutomaticCheckinsScreen(
                                    spaceId: widget.spaceId,
                                    id: '',
                                    refetchSpaces: '',
                                  ),
                                ));
                            break;
                          case "tasks":
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      TaskIndexView(spaceId: widget.spaceId),
                                ));
                            break;
                          case "infoBoard":
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => coment(
                                          spaceId: widget.spaceId,
                                          postId: '',
                                        )));
                            break;
                          case "tasks":
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TaskIndexView(
                                          spaceId: widget.spaceId,
                                        )));
                            break;
                          case "schedule":
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CalendarPage(spaceId: widget.spaceId)));
                            break;
                        }
                      },
                      child: Ink(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Card(
                            color: Colors.white,
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(menu["thumbnail"],
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.2),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      menu["title"],
                                      // maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    SizedBox(
                                      height: 60,
                                      child: Text(
                                        menu["description"],
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            overflow: TextOverflow.fade),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      ),
                    );
                  })
                ]
              ]))
        ],
      ),
    );
  }

  AppBar appbarclass(BuildContext context) {
    LoginBloc loginBloc = BlocProvider.of<LoginBloc>(context);

    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: true,
      title: const Text(
        'Class',
        style: TextStyle(color: Colors.black),
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.notifications,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
        Query(
          options: QueryOptions(
            document: gql(simpleMyUser),
          ),
          builder: (result, {fetchMore, refetch}) {
            if (result.data == null) {
              return const Center(
                child: Text('Loading'),
              );
            } else {
              return PopupMenuButton(
                icon: const Icon(Icons.person),
                itemBuilder: (context) => [
                  PopupMenuItem(
                      child: Container(
                    margin: const EdgeInsets.only(right: 0),
                    child: ListTile(
                      leading: const CircleAvatar(),
                      title: Text(result.data!["user"]["firstName"].toString()),
                    ),
                  )),
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
                                      builder: (context) =>
                                          const LoginView())));
                        },
                        child: const Text(
                          "Change password",
                          style: TextStyle(color: Colors.black),
                        )),
                  ),
                  PopupMenuItem(
                    child: TextButton(
                      onPressed: () async {
                        final sharedPref =
                            await SharedPreferences.getInstance();
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
                  ),
                ],
              );
            }
          },
        )
      ],
    );
  }
}
