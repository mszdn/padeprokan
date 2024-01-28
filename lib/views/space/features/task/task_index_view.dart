import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:padeprokan/components/atoms/avatar/mini_avatar.dart';
import 'package:padeprokan/components/organisms/appBar/appbar_widget.dart';
import 'package:padeprokan/components/utils/model/myuser/user_sharedpref.dart';
import 'package:padeprokan/components/utils/model/students/manage_members.dart';
import 'package:padeprokan/components/utils/model/tasks/workspaces.dart';
import 'package:padeprokan/graphql/space/space_members.dart';
// import 'package:padeprokan/graphql/tasks/action_workspace.dart';
import 'package:padeprokan/graphql/tasks/action_workspaces_boards.dart';
import 'package:padeprokan/graphql/tasks/get_workspace_boards.dart';
import 'package:padeprokan/views/space/features/task/detail/task_detail_index_view.dart';
// import 'package:padeprokan/views/space/features/task/detail/tastk_detail_index_view.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';
// import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class TaskIndexView extends StatefulWidget {
  final String spaceId;
  const TaskIndexView({super.key, required this.spaceId});

  @override
  State<TaskIndexView> createState() => _TaskIndexViewState();
}

class _TaskIndexViewState extends State<TaskIndexView> {
  String dropdownval = "one";
  bool? rememberMe = false;

  dynamic refetchWorkspace;
  dynamic refetchPersonalBoard;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBarWidget(context, "Tasks"),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // NoTaskIndexView()

              Query(
                  options: QueryOptions(
                    document: gql(getPersonalBoards),
                    variables: {
                      "where": {"spaceId": widget.spaceId, "workspaceId": null}
                    },
                  ),
                  builder: (result, {fetchMore, refetch}) {
                    refetchPersonalBoard = refetch;
                    if (result.isLoading) {}
                    if (result.hasException) {}
                    if (result.data != null) {
                      List<dynamic> data =
                          result.data?["boardsConnection"]["data"];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Icon(Icons.person, size: 30),
                                Text(
                                  "Personal Boards",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    ...data.map((v) {
                                      print("ADADEH ${v}");
                                      int background = int.parse(
                                          "0xfff${v["background"].toString().substring(1)}");
                                      return InkWell(
                                        onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  TaskDetailIndexView(
                                                id: v["id"],
                                                boardId: v["id"],
                                                boardName:
                                                    v["name"] ?? "undefined",
                                                boardType: "Personal Board",
                                                spaceId: widget.spaceId,
                                              ),
                                            )),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 10, 0),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.625,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.25,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Color(background),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        v["name"],
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800),
                                                      ),
                                                      PopupMenuButton(
                                                        color: Colors.white,
                                                        itemBuilder:
                                                            (context) => [
                                                          PopupMenuItem(
                                                              child: Mutation(
                                                                  options:
                                                                      MutationOptions(
                                                                    document: gql(
                                                                        deleteBoard),
                                                                    onCompleted:
                                                                        (data) {
                                                                      if (data !=
                                                                          null) {
                                                                        Navigator.pop(
                                                                            context);
                                                                        Navigator.pop(
                                                                            context);
                                                                        refetchPersonalBoard();
                                                                      }
                                                                    },
                                                                  ),
                                                                  builder:
                                                                      (runMutation,
                                                                          result) {
                                                                    return TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          showDialog(
                                                                              context: context,
                                                                              builder: (context) => AlertDialog(
                                                                                    title: const Text("Delete this board"),
                                                                                    actions: [
                                                                                      ElevatedButton(
                                                                                        onPressed: () {
                                                                                          runMutation({
                                                                                            "id": v["id"]
                                                                                          });
                                                                                        },
                                                                                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                                                                        child: const Text(
                                                                                          "Delete",
                                                                                          style: TextStyle(color: Colors.white),
                                                                                        ),
                                                                                      )
                                                                                    ],
                                                                                  ));
                                                                        },
                                                                        child: const Text(
                                                                            "Delete"));
                                                                  }))
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    })
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    } else {
                      return const Text("Error");
                    }
                  }),
              Query(
                  options: QueryOptions(
                    document: gql(getWorkspaces),
                    variables: {
                      "where": {
                        "spaceId": widget.spaceId,
                      },
                    },
                  ),
                  builder: (result, {fetchMore, refetch}) {
                    refetchWorkspace = refetch;
                    if (result.isLoading) {
                      return LoadingAnimationWidget.halfTriangleDot(
                          color: Colors.black, size: 50);
                    }
                    if (result.hasException) {
                      return LoadingAnimationWidget.halfTriangleDot(
                          color: Colors.black, size: 50);
                    }
                    if (result.data != null) {
                      List<WorkspacesModel> workspaces = result
                          .data?["workspacesConnection"]?["data"]
                          .map<WorkspacesModel>(
                              (v) => workspacesModelFromJson(json.encode(v)))
                          .toList();

                      print(workspaces);
                      return Column(
                        children: [
                          ...workspaces.map((v) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Flexible(
                                          child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(children: [
                                          const Icon(Icons.groups, size: 30),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: Text(
                                              v.name,
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          ...v.students.map((c) {
                                            return InkWell(
                                              onTap: () {},
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 2.5),
                                                child: miniAvatar(
                                                    avatarUrl: c.user.avatar,
                                                    firstName: c.user.firstName,
                                                    id: c.user.id),
                                              ),
                                            );
                                          })
                                        ]),
                                      ))
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          ...v.boards.map((d) {
                                            int background = int.parse(
                                                "0xfff${d.background.toString().substring(1)}");
                                            return InkWell(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 0, 10, 0),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.625,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.25,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: Color(background),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              d.name,
                                                              style: const TextStyle(
                                                                  fontSize: 18,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800),
                                                            ),
                                                            PopupMenuButton(
                                                              color:
                                                                  Colors.white,
                                                              itemBuilder:
                                                                  (context) => [
                                                                PopupMenuItem(
                                                                    child: Mutation(
                                                                        options: MutationOptions(
                                                                          document:
                                                                              gql(deleteBoard),
                                                                          onCompleted:
                                                                              (data) {
                                                                            if (data !=
                                                                                null) {
                                                                              Navigator.pop(context);
                                                                              Navigator.pop(context);
                                                                              refetchWorkspace();
                                                                            }
                                                                          },
                                                                        ),
                                                                        builder: (runMutation, result) {
                                                                          return TextButton(
                                                                              onPressed: () {
                                                                                showDialog(
                                                                                    context: context,
                                                                                    builder: (context) => AlertDialog(
                                                                                          title: const Text("Delete this board"),
                                                                                          actions: [
                                                                                            ElevatedButton(
                                                                                              onPressed: () {
                                                                                                runMutation({"id": d.id});
                                                                                              },
                                                                                              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                                                                              child: const Text(
                                                                                                "Delete",
                                                                                                style: TextStyle(color: Colors.white),
                                                                                              ),
                                                                                            )
                                                                                          ],
                                                                                        ));
                                                                              },
                                                                              child: const Text("Delete"));
                                                                        }))
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                        ],
                                      ),
                                    ),
                                  ),
                                  if (v.boards.isEmpty) ...[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 0, 10, 0),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  40,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.15,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color:
                                                      const Color(0xfffe6f7ff),
                                                  border: Border.all(
                                                      color: const Color(
                                                          0xfff91d5ff))),
                                              child: const Padding(
                                                padding: EdgeInsets.all(10),
                                                child: Center(
                                                  child: Text(
                                                    "This team have no boards!",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]
                                ],
                              ),
                            );
                          }),
                        ],
                      );
                    } else {
                      return const Text("Error");
                    }
                  }),
            ],
          ),
        ),
      ),
      floatingActionButton: SpeedDial(
        speedDialChildren: <SpeedDialChild>[
          SpeedDialChild(
              child: const Icon(
                Icons.note,
                color: Colors.white,
              ),
              label: 'Create task',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Query(
                        options: QueryOptions(
                            document: gql(getWorkspaceMini),
                            variables: {
                              "where": {"spaceId": widget.spaceId}
                            }),
                        builder: (result, {fetchMore, refetch}) {
                          String workspaceId = "orenonawaereyenyeagah";
                          TextEditingController boardName =
                              TextEditingController();

                          List bgOptions = [
                            '#1abc9c',
                            '#f1c40f',
                            '#3498db',
                            '#9b59b6',
                            '#34495e',
                            '#e67e22',
                            '#e74c3c',
                            '#95a5a6',
                            '#bdc3c7'
                          ];

                          String randomColor() {
                            dynamic colorPickRan =
                                bgOptions[Random().nextInt(bgOptions.length)];
                            return colorPickRan;
                          }

                          if (result.isLoading) {
                            return const AlertDialog(
                              content: CircularProgressIndicator(),
                            );
                          }
                          if (result.data != null) {
                            List workspaces =
                                result.data!["workspacesConnection"]["data"];
                            return AlertDialog(
                              title: FutureBuilder<GetUserData>(
                                  future: getUserDataFromJson(),
                                  builder: (context, snapshot) {
                                    GetUserData? user = snapshot.data;
                                    return Column(
                                      children: [
                                        const Text(
                                          "Create Board",
                                        ),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        Row(
                                          children: const [
                                            Text(
                                              "Board Name",
                                              style: TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(left: 5),
                                              child: Text(
                                                "*",
                                                style: TextStyle(
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                          controller: boardName,
                                          cursorColor: Colors.black,
                                          decoration: InputDecoration(
                                            fillColor: const Color.fromRGBO(
                                                173, 120, 211, 1),
                                            hintStyle: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                            ),
                                            hintText: "Board Name",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              borderSide: const BorderSide(
                                                color: Color.fromRGBO(
                                                    173, 120, 211, 1),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        StatefulBuilder(
                                            builder: (context, setState) {
                                          return DropdownButtonFormField<
                                              dynamic>(
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder()),
                                            value: workspaceId,
                                            onChanged: (dynamic newValue) {
                                              setState(() {
                                                workspaceId = newValue;
                                              });
                                            },
                                            items: [
                                              const DropdownMenuItem<String>(
                                                value: "orenonawaereyenyeagah",
                                                child: Text(
                                                  "No Team",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                              ...workspaces.map((v) {
                                                return DropdownMenuItem<String>(
                                                  value: v["id"],
                                                  child: Text(v["name"]),
                                                );
                                              }),
                                            ],
                                          );
                                        }),
                                        const SizedBox(
                                          height: 34,
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: const BoxDecoration(
                                            color: Colors.green,
                                          ),
                                          child: Mutation(
                                              options: MutationOptions(
                                                document: gql(createBoard),
                                                onCompleted: (resultData) {
                                                  if (resultData != null) {
                                                    Navigator.pop(context);
                                                    if (workspaceId ==
                                                        "orenonawaereyenyeagah") {
                                                      refetchPersonalBoard();
                                                    } else {
                                                      refetchWorkspace();
                                                    }
                                                  }
                                                },
                                              ),
                                              builder: (runMutation, result) {
                                                return SizedBox(
                                                  height: 40,
                                                  child: TextButton(
                                                    style: TextButton.styleFrom(
                                                      textStyle:
                                                          const TextStyle(
                                                              fontSize: 18),
                                                    ),
                                                    onPressed: () {
                                                      runMutation({
                                                        "input": {
                                                          "name":
                                                              boardName.text,
                                                          "workspaceId":
                                                              workspaceId ==
                                                                      "orenonawaereyenyeagah"
                                                                  ? null
                                                                  : workspaceId,
                                                          "background":
                                                              randomColor(),
                                                          "spaceId":
                                                              widget.spaceId,
                                                          "studentsIds": [
                                                            user?.studentId
                                                          ]
                                                        }
                                                      });
                                                    },
                                                    child: const Text(
                                                      'Add',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ),
                                      ],
                                    );
                                  }),
                            );
                          } else {
                            return const AlertDialog(
                              content: CircularProgressIndicator(),
                            );
                          }
                        });
                  },
                );
              }),
          createWorkspaceModal(context),
        ],
        labelsBackgroundColor: Colors.black38,
        labelsStyle: const TextStyle(color: Colors.white),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  SpeedDialChild createWorkspaceModal(BuildContext context) {
    return SpeedDialChild(
        child: const Icon(
          Icons.groups_2,
          color: Colors.white,
        ),
        label: 'Create team',
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return Query(
                  options: QueryOptions(
                      document: gql(getSpaceMembers),
                      variables: {"id": widget.spaceId}),
                  builder: (result, {fetchMore, refetch}) {
                    TextEditingController nameWorkspace =
                        TextEditingController();
                    TextEditingController description = TextEditingController();
                    FocusNode nameWorkspaceFocus = FocusNode();
                    FocusNode descriptionFocus = FocusNode();
                    if (result.isLoading) {
                      return const AlertDialog(
                        content: CircularProgressIndicator(),
                      );
                    }

                    if (result.data != null) {
                      List<String> idStudents = [];
                      List<SpaceStudentsModel> spaceStudentsModel = result
                          .data?["space"]?["students"]
                          .map<SpaceStudentsModel>(
                              (v) => spaceStudentsModelFromJson(json.encode(v)))
                          .toList();
                      return AlertDialog(
                        content: SingleChildScrollView(
                          child: FutureBuilder<GetUserData>(
                              future: getUserDataFromJson(),
                              builder: (context, snapshot) {
                                GetUserData? user = snapshot.data;
                                return StatefulBuilder(
                                    builder: (context, setStateOne) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "let's Build a team",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      const Text(
                                        "Boost your productivy by making it eaiser for everyone to access boards in one location",
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      Row(
                                        children: const [
                                          Text(
                                            "Team Name",
                                            style: TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 5),
                                            child: Text(
                                              "*",
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                        focusNode: nameWorkspaceFocus,
                                        cursorColor: Colors.black,
                                        controller: nameWorkspace,
                                        decoration: InputDecoration(
                                          fillColor: const Color.fromRGBO(
                                              173, 120, 211, 1),
                                          hintStyle: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                          ),
                                          hintText: "Your team name",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: const BorderSide(
                                              color: Color.fromRGBO(
                                                  173, 120, 211, 1),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: const [
                                          Text(
                                            "Invite Members",
                                            style: TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 5),
                                            child: Text(
                                              "*",
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      CreateWorkspaceModalMembers(
                                          nameWorkspaceFocus:
                                              nameWorkspaceFocus,
                                          descriptionFocus: descriptionFocus,
                                          spaceStudentsModel:
                                              spaceStudentsModel,
                                          idStudents: idStudents,
                                          result: result,
                                          setStateOne: setStateOne),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: const [
                                          Text(
                                            "Team Description",
                                            style: TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 5),
                                            child: Text(
                                              "*",
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                        controller: description,
                                        focusNode: descriptionFocus,
                                        cursorColor: Colors.black,
                                        decoration: InputDecoration(
                                          fillColor: const Color.fromRGBO(
                                              173, 120, 211, 1),
                                          hintStyle: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                          ),
                                          hintText: "Your Team Description",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: const BorderSide(
                                              color: Color.fromRGBO(
                                                  173, 120, 211, 1),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Mutation(
                                          options: MutationOptions(
                                            document: gql(createWorkspace),
                                            onCompleted: (dynamic resultData) {
                                              print("---- $resultData");
                                              if (resultData != null) {
                                                refetchWorkspace();
                                                Navigator.pop(context);
                                              }
                                            },
                                          ),
                                          builder: (
                                            runMutation,
                                            result,
                                          ) {
                                            return Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: const BoxDecoration(
                                                color: Colors.green,
                                              ),
                                              child: SizedBox(
                                                height: 40,
                                                child: TextButton(
                                                  style: TextButton.styleFrom(
                                                    textStyle: const TextStyle(
                                                        fontSize: 18),
                                                  ),
                                                  onPressed: () {
                                                    idStudents.add(user!.id);
                                                    runMutation({
                                                      "input": {
                                                        "name":
                                                            nameWorkspace.text,
                                                        "studentsIds":
                                                            idStudents,
                                                        "description":
                                                            description.text,
                                                        "spaceId":
                                                            widget.spaceId
                                                      }
                                                    });
                                                  },
                                                  child: const Text(
                                                    'Create',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                    ],
                                  );
                                });
                              }),
                        ),
                      );
                    } else {
                      return const AlertDialog(
                        content: CircularProgressIndicator(),
                      );
                    }
                  });
            },
          );
        });
  }
}

class CreateWorkspaceModalMembers extends StatelessWidget {
  const CreateWorkspaceModalMembers(
      {super.key,
      required this.nameWorkspaceFocus,
      required this.descriptionFocus,
      required this.spaceStudentsModel,
      required this.idStudents,
      required this.result,
      required this.setStateOne});

  final FocusNode nameWorkspaceFocus;
  final FocusNode descriptionFocus;
  final List<SpaceStudentsModel> spaceStudentsModel;
  final List<String> idStudents;
  final QueryResult result;
  final Function setStateOne;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        nameWorkspaceFocus.unfocus();
        descriptionFocus.unfocus();
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    StatefulBuilder(
                      builder: (BuildContext context, setStateSecond) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Builder(builder: (context) {
                            if (result.data != null) {
                              return Column(
                                children: [
                                  ...spaceStudentsModel.map((e) {
                                    bool checkStudent =
                                        idStudents.contains(e.id);
                                    return CheckboxListTile(
                                      title: Row(
                                        children: [
                                          miniAvatar(
                                              avatarUrl: e.user.avatar,
                                              firstName: e.user.firstName,
                                              id: e.id),
                                          Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5),
                                              child: Text(
                                                "${e.user.firstName ?? e.user.email}",
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      onChanged: (bool? value) {
                                        setStateOne(() {
                                          setStateSecond(() {
                                            if (checkStudent == true) {
                                              idStudents.removeWhere(
                                                  (element) => element == e.id);
                                            } else {
                                              idStudents.add(e.id);
                                            }
                                          });
                                        });
                                      },
                                      value: idStudents.contains(e.id),
                                    );
                                  })
                                ],
                              );
                            }
                            return Container();
                          }),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Builder(builder: (context) {
        List<SpaceStudentsModel> studentsCheck = spaceStudentsModel
            .where((map) => idStudents.contains(map.id))
            .toList();
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          decoration: BoxDecoration(border: Border.all()),
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                "Select Members, click this area!",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              ...studentsCheck.map((e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.5),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        children: [
                          miniAvatar(
                              avatarUrl: e.user.avatar,
                              firstName: e.user.firstName,
                              id: e.id),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                "${e.user.firstName ?? e.user.email}",
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        );
      }),
    );
  }
}
