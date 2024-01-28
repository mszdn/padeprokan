import 'dart:convert';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
// import 'package:padeprokan/components/atoms/avatar/mini_avatar.dart';
// import 'package:padeprokan/components/atoms/avatar/mini_avatar.dart';
import 'package:padeprokan/components/organisms/appBar/appbar_widget.dart';
import 'package:padeprokan/components/organisms/modal/mini_confirmation_modal.dart';
import 'package:padeprokan/components/utils/model/myuser/user_sharedpref.dart';
import 'package:padeprokan/components/utils/model/students/manage_members.dart';
import 'package:padeprokan/components/utils/model/tasks/allBoardsCardsModel.dart';
import 'package:padeprokan/graphql/space/space_members.dart';
import 'package:padeprokan/graphql/tasks/action_workspaces_boards.dart';
import 'package:padeprokan/graphql/tasks/get_workspace_boards.dart';
import 'package:padeprokan/views/space/features/task/detail/qumutaactiv.dart';
import 'package:padeprokan/views/space/features/task/detail/checklist.dart';

import '../../../../../components/atoms/atoms/avatar/mini_avatar.dart';
import '../../../../../graphql/automaticheckin/deleteCheckInRoom.dart';
import '../../../../../graphql/tasks/cecklist.dart';
import '../../../../../graphql/tasks/qumutaactiv.dart';
import 'activity.dart';
import 'mutaupdate.dart';

// import '../../../../../components/atoms/atoms/avatar/mini_avatar.dart';

class TaskDetailIndexView extends StatefulWidget {
  final String boardName;
  final String boardId;
  final String boardType;
  final String spaceId;
  final String id;

  const TaskDetailIndexView(
      {super.key,
      required this.boardId,
      required this.boardName,
      required this.boardType,
      required this.id,
      required this.spaceId});

  @override
  State<TaskDetailIndexView> createState() => _TaskDetailIndexViewState();
}

class _TaskDetailIndexViewState extends State<TaskDetailIndexView> {
  final TextEditingController textchecklist = TextEditingController();
  final TextEditingController _textcontrollerdesc = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String boardName = widget.boardName;
    String boardId = widget.boardId;
    String boardType = widget.boardType;
    String spaceId = widget.spaceId;

    return GestureDetector(
      onDoubleTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: appBarWidget(context, boardName),
        body: SingleChildScrollView(
          child: FutureBuilder<GetUserData>(
              future: getUserDataFromJson(),
              builder: (context, snapshot) {
                GetUserData? user = snapshot.data;
                print("${user?.id} wkwkw");
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            boardName,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 24),
                          ),
                          const Divider(),
                          ManageMemberBoard(
                              boardId: boardId,
                              boardType: boardType,
                              spaceId: spaceId),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        dragStartBehavior: DragStartBehavior.start,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Query(
                              options: QueryOptions(
                                  document: gql(getAllListsCards),
                                  variables: {"boardId": widget.boardId}),
                              builder: (result, {fetchMore, refetch}) {
                                if (result.isLoading) {}
                                if (result.hasException) {}
                                if (result.data != null) {
                                  List<AllBoardsCardsModel> boardsCards = result
                                      .data!["listsConnection"]["data"]
                                      .map<AllBoardsCardsModel>((v) =>
                                          allBoardsCardsModelFromJson(
                                              json.encode(v)))
                                      .toList();
                                  List<String> bgOptions = [
                                    "#1abc9c",
                                    "#f1c40f",
                                    "#3498db",
                                    "#f53b57",
                                    "#9b59b6",
                                    "#34495e",
                                    "#e67e22",
                                    "#4bcffa",
                                    "#e74c3c",
                                    "#95a5a6",
                                    "#bdc3c7",
                                    "#05c46b",
                                    "#34e7e4",
                                    "#387AEF",
                                    "#4b6584",
                                    "#0652DD",
                                  ];
                                  String randomColor() {
                                    dynamic colorPickRan = bgOptions[
                                        Random().nextInt(bgOptions.length)];
                                    return colorPickRan;
                                  }

                                  bool isAddAnotherList = false;
                                  TextEditingController
                                      textEditingControllerAddAnotherList =
                                      TextEditingController();

                                  bool isAddAnotherCard = false;
                                  TextEditingController
                                      textEditingControllerAddAnotherCard =
                                      TextEditingController();
                                  bool isAddAnotherDes = false;
                                  TextEditingController
                                      textEditingControllerAddAnotherDesc =
                                      TextEditingController();
                                  return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ...boardsCards.map((v) {
                                        int background = int.parse(
                                            "0xfff${v.background.toString().substring(1)}");

                                        return Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 10, 30),
                                          child: Container(
                                            clipBehavior: Clip.hardEdge,
                                            width: 260,
                                            decoration: BoxDecoration(
                                                color: const Color(0xfffeaeef4),
                                                borderRadius:
                                                    BorderRadius.circular(2.5)),
                                            child: Column(
                                              children: [
                                                Container(
                                                    color: Color(background),
                                                    width: double.infinity,
                                                    height: 5),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Flexible(
                                                        child: Text(
                                                          v.name,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: const TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ),
                                                      Mutation(
                                                          options:
                                                              MutationOptions(
                                                            document:
                                                                gql(deleteList),
                                                            onCompleted:
                                                                (data) {
                                                              if (data !=
                                                                  null) {
                                                                refetch!();
                                                              }
                                                            },
                                                          ),
                                                          builder: (runMutation,
                                                              result) {
                                                            return IconButton(
                                                                onPressed: () {
                                                                  miniConfirmationModal(
                                                                      context,
                                                                      runMutation({
                                                                        "id": v
                                                                            .id,
                                                                        "input":
                                                                            {
                                                                          "isDeleted":
                                                                              true
                                                                        }
                                                                      }));
                                                                },
                                                                icon: const Icon(
                                                                    Icons
                                                                        .delete));
                                                          }),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 10),
                                                        child: Column(
                                                            children: [
                                                              // Query(
                                                              //   options: QueryOptions(
                                                              //       document: gql(
                                                              //           getDetailTasks),
                                                              //       variables: {
                                                              //         'id': v.id
                                                              //       }),
                                                              //   builder: (result,
                                                              //       {fetchMore,
                                                              //       refetch}) {
                                                              //     print(
                                                              //         "detail card ${result.data}");
                                                              //     return Text(
                                                              //         'helo');
                                                              //   },
                                                              // ),
                                                              ...v.cards
                                                                  .map((b) {
                                                                print(
                                                                    "card detail ${b.toJson()}");
                                                                return Query(
                                                                  options: QueryOptions(
                                                                      document:
                                                                          gql(getDetailTasks),
                                                                      variables: {
                                                                        'id':
                                                                            b.id
                                                                      }),
                                                                  builder: (result,
                                                                      {fetchMore,
                                                                      refetch}) {
                                                                    print(
                                                                        "detail card ${result.data}");
                                                                    return InkWell(
                                                                      onTap:
                                                                          () {
                                                                        print(
                                                                            "lisstt ${result.data}");
                                                                        showDialog(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (context) {
                                                                            return AlertDialog(
                                                                              content: SingleChildScrollView(
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.all(4.0),
                                                                                  child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                                                                                    // Row(
                                                                                    //   children: const [
                                                                                    //     Icon(Icons.view_comfortable_outlined)
                                                                                    //   ],
                                                                                    // ),
                                                                                    // Text("DUE DATE \ -  ${date.year}/${date.month}/${date.day}"),
                                                                                    Row(
                                                                                      children: [
                                                                                        Icon(Icons.view_comfortable_outlined),
                                                                                        Padding(
                                                                                          padding: const EdgeInsets.all(8.0),
                                                                                          child: Text(
                                                                                            result.data?['card']['name'],
                                                                                            style: TextStyle(fontWeight: FontWeight.w600),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 10,
                                                                                    ),
                                                                                    // Text(date.toString()),
                                                                                    Row(
                                                                                      children: [
                                                                                        Icon(Icons.format_align_left_outlined),
                                                                                        Text(
                                                                                          "Description",
                                                                                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 10,
                                                                                    ),
                                                                                    StatefulBuilder(builder: (context, setStateAddAnotherDesc) {
                                                                                      return Column(
                                                                                        children: [
                                                                                          if (isAddAnotherCard == false) ...[
                                                                                            ConstrainedBox(
                                                                                              constraints: const BoxConstraints.tightFor(height: 100),
                                                                                              child: InkWell(
                                                                                                onTap: () {
                                                                                                  setStateAddAnotherDesc(() {
                                                                                                    isAddAnotherCard = true;
                                                                                                    textEditingControllerAddAnotherDesc.text = "";
                                                                                                  });
                                                                                                },
                                                                                                child: Container(
                                                                                                    width: MediaQuery.of(context).size.width,
                                                                                                    color: Color(0xfffeaeef4),
                                                                                                    height: 100,
                                                                                                    child: Padding(
                                                                                                      padding: const EdgeInsets.all(8.0),
                                                                                                      child: Text(result.data?['card']['description'] ?? ""),
                                                                                                    )),
                                                                                              ),
                                                                                            )
                                                                                          ] else ...[
                                                                                            Mutation(
                                                                                                options: MutationOptions(
                                                                                                  document: gql(addCard),
                                                                                                  onCompleted: (data) {
                                                                                                    if (data != null) {
                                                                                                      textEditingControllerAddAnotherDesc.text = "";
                                                                                                      isAddAnotherCard = false;
                                                                                                      refetch!();
                                                                                                    }
                                                                                                  },
                                                                                                ),
                                                                                                builder: (runMutation, context) {
                                                                                                  return Focus(
                                                                                                    child: Column(
                                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                      children: [
                                                                                                        TextFormField(
                                                                                                          decoration: InputDecoration(border: OutlineInputBorder(), hintText: "Add a more detailed description..."),
                                                                                                          controller: textEditingControllerAddAnotherDesc,
                                                                                                        ),
                                                                                                        Row(
                                                                                                          children: [
                                                                                                            ElevatedButton(
                                                                                                                onPressed: () {
                                                                                                                  // runMutation({
                                                                                                                  //   "input": {
                                                                                                                  //     "name": textEditingControllerAddAnotherCard.text,
                                                                                                                  //     "index": v.cards.length,
                                                                                                                  //     "listId": v.id
                                                                                                                  //   }
                                                                                                                  // });
                                                                                                                },
                                                                                                                style: ElevatedButton.styleFrom(backgroundColor: Colors.green[600]),
                                                                                                                child: const Text(
                                                                                                                  "Save",
                                                                                                                  style: TextStyle(color: Colors.white),
                                                                                                                )),
                                                                                                            IconButton(
                                                                                                                onPressed: () {
                                                                                                                  setStateAddAnotherDesc(() {
                                                                                                                    textEditingControllerAddAnotherDesc.text = "";
                                                                                                                    isAddAnotherCard = false;
                                                                                                                  });
                                                                                                                },
                                                                                                                icon: const Icon(Icons.close))
                                                                                                          ],
                                                                                                        )
                                                                                                      ],
                                                                                                    ),
                                                                                                    onFocusChange: (hasFocus) {
                                                                                                      if (hasFocus) {
                                                                                                      } else {
                                                                                                        setStateAddAnotherDesc(
                                                                                                          () {
                                                                                                            isAddAnotherCard = false;
                                                                                                          },
                                                                                                        );
                                                                                                      }
                                                                                                    },
                                                                                                  );
                                                                                                })
                                                                                          ],
                                                                                        ],
                                                                                      );
                                                                                    }),
                                                                                    SizedBox(
                                                                                      height: 10,
                                                                                    ),
                                                                                    activity(Id: b.id),
                                                                                    Text(
                                                                                      "ADD TO CARD",
                                                                                      style: TextStyle(fontWeight: FontWeight.bold),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 10,
                                                                                    ),

                                                                                ElevatedButton(
                                                                                    style: ButtonStyle(
                                                                                      backgroundColor: MaterialStatePropertyAll(Color(0xfffeaeef4)),
                                                                                    ),
                                                                                    onPressed: () {},
                                                                                    child: Row(
                                                                                      children: [
                                                                                        Icon(
                                                                                          Icons.person,
                                                                                          color: Colors.black54,
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: 2,
                                                                                        ),
                                                                                        Text(
                                                                                          "Members",
                                                                                          style: TextStyle(
                                                                                            color: Colors.black54,
                                                                                          ),
                                                                                        )
                                                                                      ],
                                                                                    )),
                                                                                ElevatedButton(
                                                                                    style: ButtonStyle(
                                                                                      backgroundColor: MaterialStatePropertyAll(Color(0xfffeaeef4)),
                                                                                    ),
                                                                                    onPressed: () {},
                                                                                    child: Row(
                                                                                      children: [
                                                                                        Icon(
                                                                                          Icons.label_important,
                                                                                          color: Colors.black54,
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: 2,
                                                                                        ),
                                                                                        Text(
                                                                                          "labels",
                                                                                          style: TextStyle(
                                                                                            color: Colors.black54,
                                                                                          ),
                                                                                        )
                                                                                      ],
                                                                                    )),
                                                                                ElevatedButton(
                                                                                    style: ButtonStyle(
                                                                                      backgroundColor: MaterialStatePropertyAll(Color(0xfffeaeef4)),
                                                                                    ),
                                                                                    onPressed: () {
                                                                                      showDialog(
                                                                                        context: context,
                                                                                        builder: (context) {
                                                                                          return AlertDialog(
                                                                                            title: Row(
                                                                                              children: [
                                                                                                Text(
                                                                                                  'Add Checklist',
                                                                                                  style: TextStyle(fontSize: 16),
                                                                                                ),
                                                                                                Spacer(),
                                                                                                IconButton(
                                                                                                    onPressed: () {
                                                                                                      Navigator.pop(context);
                                                                                                    },
                                                                                                    icon: Icon(Icons.close))
                                                                                              ],
                                                                                            ),
                                                                                            actions: [
                                                                                              Column(
                                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                children: [
                                                                                                  TextFormField(
                                                                                                    controller: textchecklist,
                                                                                                    decoration: InputDecoration(
                                                                                                      border: OutlineInputBorder(),
                                                                                                      hintText: "Checklist",
                                                                                                    ),
                                                                                                  ),
                                                                                                  Mutation(
                                                                                                      options: MutationOptions(document: gql(createChecklist)),
                                                                                                      builder: (runMutation, result) {
                                                                                                        return ElevatedButton(
                                                                                                            onPressed: () {
                                                                                                              runMutation({
                                                                                                                "input": {
                                                                                                                  "name": textchecklist.text,
                                                                                                                  "cardId": b.id
                                                                                                                }
                                                                                                              });
                                                                                                              refetch!();
                                                                                                              Navigator.pop(context);
                                                                                                            },
                                                                                                            style: ElevatedButton.styleFrom(backgroundColor: Colors.green[600]),
                                                                                                            child: const Text(
                                                                                                              "Add",
                                                                                                              style: TextStyle(color: Colors.white),
                                                                                                            ));
                                                                                                      }),
                                                                                                ],
                                                                                              ),
                                                                                            ],
                                                                                          );
                                                                                        },
                                                                                      );
                                                                                    },
                                                                                    child: Row(
                                                                                      children: [
                                                                                        Icon(
                                                                                          Icons.check_box,
                                                                                          color: Colors.black54,
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: 2,
                                                                                        ),
                                                                                        Text(
                                                                                          "Checklist",
                                                                                          style: TextStyle(
                                                                                            color: Colors.black54,
                                                                                          ),
                                                                                        )
                                                                                      ],
                                                                                    )),
                                                                                ElevatedButton(
                                                                                    style: ButtonStyle(
                                                                                      backgroundColor: MaterialStatePropertyAll(Color(0xfffeaeef4)),
                                                                                    ),
                                                                                    onPressed: () {},
                                                                                    child: Row(
                                                                                      children: [
                                                                                        Icon(
                                                                                          Icons.access_time,
                                                                                          color: Colors.black54,
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: 2,
                                                                                        ),
                                                                                        Text(
                                                                                          "Due Date",
                                                                                          style: TextStyle(
                                                                                            color: Colors.black54,
                                                                                          ),
                                                                                        )
                                                                                      ],
                                                                                    )),
                                                                                ElevatedButton(
                                                                                    style: ButtonStyle(
                                                                                      backgroundColor: MaterialStatePropertyAll(Color(0xfffeaeef4)),
                                                                                    ),
                                                                                    onPressed: () {},
                                                                                    child: Row(
                                                                                      children: [
                                                                                        Transform.rotate(
                                                                                          angle: 180,
                                                                                          child: Icon(
                                                                                            // Icons.rotate_90_degrees_ccw,
                                                                                            Icons.attach_file,
                                                                                            color: Colors.black54,
                                                                                          ),
                                                                                        ),
                                                                                        SizedBox(
                                                                                          width: 2,
                                                                                        ),
                                                                                        Text(
                                                                                          "Attachment",
                                                                                          style: TextStyle(
                                                                                            color: Colors.black54,
                                                                                          ),
                                                                                        )
                                                                                      ],
                                                                                    )),

                                                                                    SizedBox(height: 20),
                                                                                    Text(
                                                                                      "ACTION",
                                                                                      style: TextStyle(fontWeight: FontWeight.bold),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 10,
                                                                                    ),

                                                                                    ElevatedButton(
                                                                                        style: ButtonStyle(
                                                                                          backgroundColor: MaterialStatePropertyAll(Color(0xfffeaeef4)),
                                                                                        ),
                                                                                        onPressed: () {},
                                                                                        child: Row(
                                                                                          children: [
                                                                                            Icon(
                                                                                              Icons.arrow_forward_rounded,
                                                                                              color: Colors.black54,
                                                                                            ),
                                                                                            SizedBox(
                                                                                              width: 2,
                                                                                            ),
                                                                                            Text(
                                                                                              "Move",
                                                                                              style: TextStyle(color: Colors.black54),
                                                                                            )
                                                                                          ],
                                                                                        )),
                                                                                    ElevatedButton(
                                                                                        style: ButtonStyle(
                                                                                          backgroundColor: MaterialStatePropertyAll(Color(0xfffeaeef4)),
                                                                                        ),
                                                                                        onPressed: () {},
                                                                                        child: Row(
                                                                                          children: [
                                                                                            Icon(
                                                                                              Icons.delete_outline,
                                                                                              color: Colors.black54,
                                                                                            ),
                                                                                            SizedBox(
                                                                                              width: 2,
                                                                                            ),
                                                                                            Text(
                                                                                              "Delete",
                                                                                              style: TextStyle(color: Colors.black54),
                                                                                            )
                                                                                          ],
                                                                                        )),
                                                                                  ]),
                                                                                ),
                                                                              ),
                                                                            );
                                                                          },
                                                                        );
                                                                      },
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.symmetric(vertical: 5),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              double.infinity,
                                                                          padding:
                                                                              const EdgeInsets.all(10),
                                                                          decoration: BoxDecoration(
                                                                              color: Colors.white,
                                                                              borderRadius: BorderRadius.circular(2.5)),
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              b.cover.toString() != "" ? CachedNetworkImage(imageUrl: b.cover["fileUrl"]) : Container(),
                                                                              Padding(
                                                                                padding: const EdgeInsets.all(5),
                                                                                child: Text(b.name),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                );
                                                              }),
                                                            ]),
                                                      ),
                                                      StatefulBuilder(builder:
                                                          (context,
                                                              setStateAddAnotherCard) {
                                                        return Column(
                                                          children: [
                                                            if (isAddAnotherCard ==
                                                                false) ...[
                                                              ConstrainedBox(
                                                                constraints:
                                                                    const BoxConstraints
                                                                            .tightFor(
                                                                        height:
                                                                            50),
                                                                child: ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(
                                                                        side: const BorderSide(
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                        backgroundColor: const Color(0xfffeaeef4),
                                                                        elevation: 0),
                                                                    onPressed: () {
                                                                      setStateAddAnotherCard(
                                                                          () {
                                                                        isAddAnotherCard =
                                                                            true;
                                                                        textEditingControllerAddAnotherCard.text =
                                                                            "";
                                                                      });
                                                                    },
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: const [
                                                                        Icon(
                                                                          Icons
                                                                              .add_circle,
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              EdgeInsets.only(left: 5),
                                                                          child:
                                                                              Text("Add Another Card"),
                                                                        )
                                                                      ],
                                                                    )),
                                                              )
                                                            ] else ...[
                                                              Mutation(
                                                                  options:
                                                                      MutationOptions(
                                                                    document: gql(
                                                                        addCard),
                                                                    onCompleted:
                                                                        (data) {
                                                                      if (data !=
                                                                          null) {
                                                                        textEditingControllerAddAnotherCard.text =
                                                                            "";
                                                                        isAddAnotherCard =
                                                                            false;
                                                                        refetch!();
                                                                      }
                                                                    },
                                                                  ),
                                                                  builder:
                                                                      (runMutation,
                                                                          context) {
                                                                    return Focus(
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          TextField(
                                                                            controller:
                                                                                textEditingControllerAddAnotherCard,
                                                                          ),
                                                                          Row(
                                                                            children: [
                                                                              ElevatedButton(
                                                                                  onPressed: () {
                                                                                    runMutation({
                                                                                      "input": {
                                                                                        "name": textEditingControllerAddAnotherCard.text,
                                                                                        "index": v.cards.length,
                                                                                        "listId": v.id
                                                                                      }
                                                                                    });
                                                                                  },
                                                                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green[600]),
                                                                                  child: const Text(
                                                                                    "Save",
                                                                                    style: TextStyle(color: Colors.white),
                                                                                  )),
                                                                              IconButton(
                                                                                  onPressed: () {
                                                                                    setStateAddAnotherCard(() {
                                                                                      textEditingControllerAddAnotherCard.text = "";
                                                                                      isAddAnotherCard = false;
                                                                                    });
                                                                                  },
                                                                                  icon: const Icon(Icons.close))
                                                                            ],
                                                                          )
                                                                        ],
                                                                      ),
                                                                      onFocusChange:
                                                                          (hasFocus) {
                                                                        if (hasFocus) {
                                                                        } else {
                                                                          setStateAddAnotherCard(
                                                                            () {
                                                                              isAddAnotherCard = false;
                                                                            },
                                                                          );
                                                                        }
                                                                      },
                                                                    );
                                                                  })
                                                            ],
                                                          ],
                                                        );
                                                      })
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                      StatefulBuilder(builder:
                                          (context, setStateAddAnotherList) {
                                        if (isAddAnotherList == false) {
                                          return SizedBox(
                                            width: 260,
                                            child: ConstrainedBox(
                                              constraints:
                                                  const BoxConstraints.tightFor(
                                                      height: 50),
                                              child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          side:
                                                              const BorderSide(
                                                            color: Colors.black,
                                                          ),
                                                          backgroundColor:
                                                              const Color(
                                                                  0xfffeaeef4),
                                                          elevation: 0),
                                                  onPressed: () {
                                                    setStateAddAnotherList(() {
                                                      isAddAnotherList = true;
                                                      textEditingControllerAddAnotherList
                                                          .text = "";
                                                    });
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: const [
                                                      Icon(
                                                        Icons.add_circle,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 5),
                                                        child: Text(
                                                            "Add Another List"),
                                                      )
                                                    ],
                                                  )),
                                            ),
                                          );
                                        } else {
                                          return Container(
                                            clipBehavior: Clip.hardEdge,
                                            width: 260,
                                            decoration: BoxDecoration(
                                                color: const Color(0xfffeaeef4),
                                                borderRadius:
                                                    BorderRadius.circular(2.5)),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Mutation(
                                                  options: MutationOptions(
                                                    document: gql(addList),
                                                    onCompleted: (data) {
                                                      if (data != null) {
                                                        textEditingControllerAddAnotherList
                                                            .text = "";
                                                        isAddAnotherList =
                                                            false;
                                                        refetch!();
                                                      }
                                                    },
                                                  ),
                                                  builder:
                                                      (runMutation, context) {
                                                    return Focus(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          TextField(
                                                            controller:
                                                                textEditingControllerAddAnotherList,
                                                          ),
                                                          Row(
                                                            children: [
                                                              ElevatedButton(
                                                                  onPressed:
                                                                      () {
                                                                    runMutation({
                                                                      "input": {
                                                                        "name":
                                                                            textEditingControllerAddAnotherList.text,
                                                                        "background":
                                                                            randomColor(),
                                                                        "index":
                                                                            boardsCards.length,
                                                                        "boardId":
                                                                            widget.boardId
                                                                      }
                                                                    });
                                                                  },
                                                                  style: ElevatedButton.styleFrom(
                                                                      backgroundColor:
                                                                          Colors.green[
                                                                              600]),
                                                                  child:
                                                                      const Text(
                                                                    "Save",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  )),
                                                              IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    setStateAddAnotherList(
                                                                        () {
                                                                      textEditingControllerAddAnotherList
                                                                          .text = "";
                                                                      isAddAnotherList =
                                                                          false;
                                                                    });
                                                                  },
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .close))
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      onFocusChange:
                                                          (hasFocus) {
                                                        if (hasFocus) {
                                                        } else {
                                                          setStateAddAnotherList(
                                                            () {
                                                              isAddAnotherList =
                                                                  false;
                                                            },
                                                          );
                                                        }
                                                      },
                                                    );
                                                  }),
                                            ),
                                          );
                                        }
                                      }),
                                      // Container(
                                      //   width:
                                      //       MediaQuery.of(context).size.width,
                                      //   color: Colors.grey,
                                      //   padding: const EdgeInsets.fromLTRB(
                                      //       10, 20, 10, 20),
                                      //   child: Column(
                                      //     children: [
                                      //       Row(
                                      //         children: const [
                                      //           Icon(
                                      //               Icons
                                      //                   .view_comfortable_outlined,
                                      //               size: 30),
                                      //           Padding(
                                      //             padding:
                                      //                 EdgeInsets.only(left: 5),
                                      //             child: Flexible(
                                      //               child: Text(
                                      //                 "eeeee",
                                      //                 style: TextStyle(
                                      //                     fontSize: 18),
                                      //               ),
                                      //             ),
                                      //           )
                                      //         ],
                                      //       ),
                                      //     ],
                                      //   ),
                                      // )
                                    ],
                                  );
                                } else {
                                  return Container();
                                }
                              }),
                        ))
                  ],
                );
              }),
        ),
      ),
    );
  }
}

class ManageMemberBoard extends StatelessWidget {
  const ManageMemberBoard({
    super.key,
    required this.boardId,
    required this.boardType,
    required this.spaceId,
  });

  final String boardId;
  final String boardType;
  final String spaceId;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      dragStartBehavior: DragStartBehavior.start,
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Query(
              options: QueryOptions(
                  document: gql(getBoardStudents), variables: {"id": boardId}),
              builder: (result, {fetchMore, refetch}) {
                return Row(
                  children: [
                    Text(
                      boardType,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 20),
                    ),
                    if (result.isLoading) ...[
                      const SizedBox(
                        width: 25,
                        height: 25,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    ],
                    if (result.data != null) ...[
                      TextButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  dynamic resultBoardStudent = result.data;
                                  dynamic refetchMember = refetch;
                                  return Query(
                                      options: QueryOptions(
                                          document: gql(getSpaceMembers),
                                          variables: {"id": spaceId}),
                                      builder: (result, {fetchMore, refetch}) {
                                        if (result.isLoading) {
                                          const AlertDialog(
                                            content: Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          );
                                        }
                                        if (result.data != null &&
                                            resultBoardStudent != null) {
                                          List<SpaceStudentsModel>
                                              spaceStudentsModel = result
                                                  .data?["space"]?["students"]
                                                  .map<SpaceStudentsModel>((v) =>
                                                      spaceStudentsModelFromJson(
                                                          json.encode(v)))
                                                  .toList();
                                          List boardStudentsId =
                                              resultBoardStudent!["board"]
                                                      ["students"]
                                                  .map((a) => a["id"])
                                                  .toList();
                                          String idAdmin =
                                              resultBoardStudent["board"]
                                                  ["createdBy"]["id"];
                                          print(idAdmin);
                                          return AlertDialog(
                                            actions: [
                                              Mutation(
                                                  options: MutationOptions(
                                                    document:
                                                        gql(updateBoardMembers),
                                                    onCompleted: (data) {
                                                      print(data);
                                                      if (data != null) {
                                                        refetchMember();
                                                        Navigator.pop(context);
                                                      }
                                                    },
                                                  ),
                                                  builder:
                                                      (runMutation, result) {
                                                    return ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                backgroundColor:
                                                                    Colors.green[
                                                                        600]),
                                                        onPressed: () {
                                                          runMutation({
                                                            "boardId": boardId,
                                                            "studentIds":
                                                                boardStudentsId
                                                          });
                                                        },
                                                        child:
                                                            const Text("Save"));
                                                  }),
                                            ],
                                            content: StatefulBuilder(builder:
                                                (context, setStateOne) {
                                              return Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  ...spaceStudentsModel
                                                      .map((e) {
                                                    bool checkStudent =
                                                        boardStudentsId
                                                            .contains(e.id);
                                                    return CheckboxListTile(
                                                      title: Row(
                                                        children: [
                                                          miniAvatar(
                                                              avatarUrl:
                                                                  e.user.avatar,
                                                              firstName: e.user
                                                                  .firstName,
                                                              id: e.user.id),
                                                          Flexible(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 5),
                                                              child: Text(
                                                                "${idAdmin == e.user.id ? "(Admin) " : ""}${e.user.firstName ?? e.user.email} ",
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      onChanged: idAdmin ==
                                                              e.user.id
                                                          ? null
                                                          : (bool? value) {
                                                              setStateOne(() {
                                                                if (checkStudent ==
                                                                    true) {
                                                                  boardStudentsId.removeWhere(
                                                                      (element) =>
                                                                          element ==
                                                                          e.id);
                                                                } else {
                                                                  boardStudentsId
                                                                      .add(
                                                                          e.id);
                                                                }
                                                              });
                                                            },
                                                      value: boardStudentsId
                                                          .contains(e.id),
                                                    );
                                                  })
                                                ],
                                              );
                                            }),
                                          );
                                        }
                                        return const AlertDialog();
                                      });
                                });
                          },
                          child: const Text("Invite")),
                      const SizedBox(
                          height: 20,
                          child: VerticalDivider(
                            color: Colors.black,
                          )),
                      Builder(
                        builder: (context) {
                          List boardStudents =
                              result.data!["board"]["students"];
                          return Row(
                            children: [
                              ...boardStudents.map((e) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: miniAvatar(
                                        avatarUrl: e["user"]["avatar"],
                                        firstName: e["user"]["firstName"],
                                        id: e["user"]["id"]),
                                  ))
                            ],
                          );
                        },
                      )
                    ]
                  ],
                );
              }),
        ],
      ),
    );
  }
}
