import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:padeprokan/components/atoms/atoms/avatar/mini_avatar.dart';
import 'package:padeprokan/components/organisms/appBar/appbar_widget.dart';
import 'package:padeprokan/components/utils/model/docsfiles/userFiles.dart';
import 'package:padeprokan/components/utils/theme_colors.dart';
import 'package:intl/intl.dart';
import 'package:padeprokan/graphql/automaticheckin/auto.dart';
import 'package:padeprokan/graphql/automaticheckin/chenkinroom.dart';
import 'package:padeprokan/graphql/automaticheckin/comend.dart';
import 'package:padeprokan/graphql/automaticheckin/subcoment.dart';
import 'package:padeprokan/graphql/automaticheckin/update.dart';
import 'package:padeprokan/views/space/features/ainfoboard/infoboard.dart';

import '../../../../components/utils/model/myuser/user_sharedpref.dart';
import '../../../../graphql/automaticheckin/createCheckInRoom.dart';
import '../../../../graphql/automaticheckin/deleteCheckInRoom.dart';

class CheckinsPage extends StatefulWidget {
  final String id;
  final String spaceId;
  CheckinsPage({super.key, required this.spaceId, required this.id});

  @override
  State<CheckinsPage> createState() => _CheckinsPageState();
}

class _CheckinsPageState extends State<CheckinsPage> {
  TextEditingController texteditcomment = TextEditingController();
  TextEditingController textsubcomment = TextEditingController();
  TextEditingController texteditsubcomment = TextEditingController();
  final TextEditingController _Textcontroller = TextEditingController();
  List<String> posts = [];
  String text = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyle().scaffoldcolor,
      appBar: appBarWidget(context, 'Checkins'),
      body: SingleChildScrollView(
        child: FutureBuilder<GetUserData>(
            future: getUserDataFromJson(),
            builder: (context, snapshot) {
              GetUserData? user = snapshot.data;
              return Query(
                  options: QueryOptions(document: gql(checkInRoom), variables: {
                    "id": widget.id,
                  }),
                  builder: (result, {fetchMore, refetch}) {
                    print(" agagagga ${result.data}");
                    if (result.isLoading) {
                      return Center(
                        child: LoadingAnimationWidget.halfTriangleDot(
                            color: Colors.black, size: 50),
                      );
                    }
                    if (result.hasException) {
                      return Center(
                        child: LoadingAnimationWidget.halfTriangleDot(
                            color: Colors.black, size: 50),
                      );
                    }
                    if (result.isLoading) {
                      return Center(
                        child: LoadingAnimationWidget.halfTriangleDot(
                            color: Colors.black, size: 50),
                      );
                    }
                    if (result.isLoading) {
                      return Center(
                        child: LoadingAnimationWidget.halfTriangleDot(
                            color: Colors.black, size: 50),
                      );
                    }
                    if (result.isLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.blue),
                        ),
                      );
                    }

                    return Container(
                        child: Column(
                      children: [
                        if (result.data != null) ...[
                          // CircleAvatar(
                          //   backgroundImage: NetworkImage(result.data?["checkInRoom"]
                          //           ?["createdBy"]?["avatar"] ??
                          //       ""),
                          // ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                result.data?["checkInRoom"]?["question"] ?? "",
                                style: const TextStyle(fontSize: 24),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Card(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Row(
                                                children: [
                                                  const Text(
                                                      'Asking 1 people every weekday at'),
                                                  Text(
                                                    result.data?["checkInRoom"]
                                                            ?["time"] ??
                                                        "",
                                                  ),
                                                ],
                                              )),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              'Answer',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                  user?.avatar ??
                                                      'https://via.placeholder.com/150',
                                                ),
                                                // child: Text('M'),
                                                // radius: 16,
                                                // backgroundColor: Colors.red,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 250,
                                              child: Container(
                                                color: Colors.black12,
                                                child: TextFormField(
                                                  cursorColor: Colors.black,
                                                  controller: _Textcontroller,
                                                  decoration: InputDecoration(
                                                    border: const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .transparent)),
                                                    focusedBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent),
                                                    ),
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .transparent)),
                                                    hintText:
                                                        'type your mesage here',
                                                    suffixIcon: Mutation(
                                                        options: MutationOptions(
                                                            document: gql(
                                                                createComment)),
                                                        builder: (runMutation,
                                                            result) {
                                                          return IconButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                // _Textcontroller.clear();
                                                                // _Textcontroller.notifyListeners();
                                                                posts.add(
                                                                    _Textcontroller
                                                                        .text);
                                                                runMutation({
                                                                  "input": {
                                                                    "checkInRoomId":
                                                                        widget
                                                                            .id,
                                                                    "text":
                                                                        _Textcontroller
                                                                            .text
                                                                  }
                                                                });
                                                                refetch!();
                                                                _Textcontroller
                                                                    .clear();
                                                              });
                                                            },
                                                            icon: Icon(
                                                              Icons.send,
                                                              color: ColorStyle()
                                                                  .PurpleButton,
                                                            ),
                                                          );
                                                        }),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const Divider(),
                                        Text(DateFormat.yMMMMEEEEd()
                                            .format(DateTime.now())),
                                        const SizedBox(
                                          height: 20,
                                        )
                                      ],
                                    ),
                                  ),
                                  //coment
                                  ...?result.data!["checkInRoom"]?["comments"]
                                      ?.map((v) {
                                    return Container(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 0, 10, 0),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      CircleAvatar(
                                                          backgroundImage:
                                                              NetworkImage(
                                                                  v["createdBy"]
                                                                          [
                                                                          "avatar"] ??
                                                                      "")),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(v["createdBy"]
                                                          ["firstName"]),
                                                      const Spacer(),
                                                      PopupMenuButton(
                                                        child: const Icon(
                                                          Icons.more_horiz,
                                                          color: Colors.grey,
                                                        ),
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context) =>
                                                                <PopupMenuEntry>[
                                                          PopupMenuItem(
                                                              value: 'Edit',
                                                              // textStyle: TextStyle(
                                                              //     color: Colors.black),
                                                              child: Column(
                                                                children: [
                                                                  //EDITTTTT
                                                                  ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(
                                                                        backgroundColor:
                                                                            Colors
                                                                                .transparent,
                                                                        elevation:
                                                                            0),
                                                                    onPressed:
                                                                        () {
                                                                      setState(
                                                                          () {
                                                                        showDialog(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (context) {
                                                                            return AlertDialog(
                                                                              title: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                children: const [
                                                                                  Text('Edit coment'),
                                                                                ],
                                                                              ),
                                                                              actions: [
                                                                                Column(
                                                                                  children: [
                                                                                    Container(
                                                                                      height: 140,
                                                                                      width: MediaQuery.of(context).size.width,
                                                                                      color: Colors.white,
                                                                                      child: Column(
                                                                                        children: [
                                                                                          TextFormField(
                                                                                            controller: texteditcomment,
                                                                                            keyboardType: TextInputType.multiline,
                                                                                            decoration: const InputDecoration(
                                                                                              // focusedBorder: InputBorder.none,
                                                                                              // enabledBorder: InputBorder.none,
                                                                                              hintText: 'type your mesage here',
                                                                                              hintStyle: TextStyle(
                                                                                                color: Colors.grey,
                                                                                              ),
                                                                                              border: UnderlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(2))),
                                                                                            ),
                                                                                          ),
                                                                                          Padding(
                                                                                            padding: const EdgeInsets.all(8.0),
                                                                                            child: Row(
                                                                                              children: [
                                                                                                ElevatedButton(
                                                                                                  style: const ButtonStyle(
                                                                                                    backgroundColor: MaterialStatePropertyAll(Colors.white),
                                                                                                  ),
                                                                                                  onPressed: () {
                                                                                                    Navigator.pop(context);
                                                                                                  },
                                                                                                  child: const Text('Cancel'),
                                                                                                ),
                                                                                                const SizedBox(
                                                                                                  width: 10,
                                                                                                ),
                                                                                                Mutation(
                                                                                                    options: MutationOptions(document: gql(updateComment)),
                                                                                                    builder: (runMutation, result) {
                                                                                                      return ElevatedButton(
                                                                                                        onPressed: () {
                                                                                                          runMutation({
                                                                                                            "id": v["id"],
                                                                                                            "input": {
                                                                                                              "checkInRoomId": widget.id,
                                                                                                              "text": texteditcomment.text
                                                                                                            }
                                                                                                          });
                                                                                                          setState(() {});
                                                                                                          refetch!();
                                                                                                          Navigator.pop(context);
                                                                                                        },
                                                                                                        child: const Text('Edit'),
                                                                                                      );
                                                                                                    })
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            );
                                                                          },
                                                                        );
                                                                      });
                                                                    },
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: const [
                                                                        Icon(
                                                                          Icons
                                                                              .edit,
                                                                          color:
                                                                              Colors.black54,
                                                                        ),
                                                                        Text(
                                                                          "Edit",
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.black54,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Mutation(
                                                                      options:
                                                                          MutationOptions(
                                                                              document: gql(
                                                                                  deleteComment),
                                                                              onCompleted: (dynamic
                                                                                  resultData) {
                                                                                if (resultData != null) {
                                                                                  setState(() {});
                                                                                  refetch!();
                                                                                }
                                                                              }),
                                                                      builder:
                                                                          (runMutation,
                                                                              result) {
                                                                        return ElevatedButton(
                                                                          style: ElevatedButton.styleFrom(
                                                                              backgroundColor: Colors.transparent,
                                                                              elevation: 0),
                                                                          onPressed:
                                                                              () {
                                                                            showDialog(
                                                                              context: context,
                                                                              builder: (context) {
                                                                                return AlertDialog(
                                                                                  actionsAlignment: MainAxisAlignment.end,
                                                                                  actions: [
                                                                                    ElevatedButton(
                                                                                        onPressed: () {
                                                                                          Navigator.pop(context);
                                                                                        },
                                                                                        style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, elevation: 0),
                                                                                        child: const Text(
                                                                                          "Cancel",
                                                                                        )),
                                                                                    ElevatedButton(
                                                                                      onPressed: () {
                                                                                        setState(() {});
                                                                                        runMutation({
                                                                                          "id": v["id"]
                                                                                        });
                                                                                        // print("object");
                                                                                        // runMutation({
                                                                                        //   "spaceId": space.id
                                                                                        // });
                                                                                        // setState(
                                                                                        //     () {
                                                                                        //   posts.removeAt();
                                                                                        // runMutation({
                                                                                        //   "id": "63846f522833fe00339da56a",
                                                                                        //   "input": posts[index] = text
                                                                                        // });
                                                                                        // });

                                                                                        Navigator.pop(context);
                                                                                      },
                                                                                      style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, elevation: 0),
                                                                                      child: Column(
                                                                                        children: const [
                                                                                          Text(
                                                                                            "Delete",
                                                                                            style: TextStyle(
                                                                                              color: Colors.red,
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    )
                                                                                  ],
                                                                                  content: SizedBox(
                                                                                    height: 57,
                                                                                    child: Row(
                                                                                      children: [
                                                                                        const Icon(
                                                                                          Icons.question_mark,
                                                                                          color: Colors.amber,
                                                                                        ),
                                                                                        Column(
                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                          children: const [
                                                                                            Text(
                                                                                              "Delete Confirmation",
                                                                                              style: TextStyle(fontWeight: FontWeight.bold),
                                                                                            ),
                                                                                            Text(
                                                                                              "are you sure delete this\ncomment?",
                                                                                              maxLines: 2,
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              },
                                                                            );
                                                                          },
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: const [
                                                                              Icon(
                                                                                Icons.delete,
                                                                                color: Colors.black54,
                                                                              ),
                                                                              Text(
                                                                                "Delete",
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(
                                                                                  color: Colors.black54,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        );
                                                                      }),
                                                                ],
                                                              ))
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    v["text"] ?? "",
                                                  ),
                                                  ElevatedButton(
                                                      style: const ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStatePropertyAll(
                                                                Colors
                                                                    .transparent),
                                                        shadowColor:
                                                            MaterialStatePropertyAll(
                                                                Colors
                                                                    .transparent),
                                                      ),
                                                      onPressed: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                              title: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: const [
                                                                  Text(
                                                                      'coment'),
                                                                ],
                                                              ),
                                                              actions: [
                                                                Column(
                                                                  children: [
                                                                    Container(
                                                                      height:
                                                                          140,
                                                                      width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width,
                                                                      color: Colors
                                                                          .white,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          TextFormField(
                                                                            controller:
                                                                                textsubcomment,
                                                                            keyboardType:
                                                                                TextInputType.multiline,
                                                                            decoration:
                                                                                const InputDecoration(
                                                                              // focusedBorder: InputBorder.none,
                                                                              // enabledBorder: InputBorder.none,
                                                                              hintText: 'type your mesage here',
                                                                              hintStyle: TextStyle(
                                                                                color: Colors.grey,
                                                                              ),
                                                                              border: UnderlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(2))),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                ElevatedButton(
                                                                                  style: const ButtonStyle(
                                                                                    backgroundColor: MaterialStatePropertyAll(Colors.white),
                                                                                  ),
                                                                                  onPressed: () {
                                                                                    Navigator.pop(context);
                                                                                  },
                                                                                  child: const Text('Cancel'),
                                                                                ),
                                                                                const SizedBox(
                                                                                  width: 10,
                                                                                ),
                                                                                Mutation(
                                                                                    options: MutationOptions(document: gql(createSubComment)),
                                                                                    builder: (runMutation, result) {
                                                                                      return ElevatedButton(
                                                                                        onPressed: () {
                                                                                          runMutation({
                                                                                            "input": {
                                                                                              "commentId": v["id"],
                                                                                              "text": textsubcomment.text
                                                                                            }
                                                                                          });
                                                                                          setState(() {});
                                                                                          refetch!();
                                                                                          Navigator.pop(context);
                                                                                        },
                                                                                        child: const Text('Edit'),
                                                                                      );
                                                                                    })
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: const Text(
                                                        "comments",
                                                        style: TextStyle(
                                                            color: Colors.blue),
                                                      )),
                                                  //subcoment
                                                  ...v["subComments"].map((k) {
                                                    return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 20,
                                                                top: 10,
                                                                bottom: 10,
                                                                left: 20),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                CircleAvatar(
                                                                    backgroundImage:
                                                                        NetworkImage(k["createdBy"]["avatar"] ??
                                                                            "")),
                                                                const SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text(k["createdBy"]
                                                                        [
                                                                        "firstName"] ??
                                                                    ""),
                                                                const Spacer(),
                                                                PopupMenuButton(
                                                                  child:
                                                                      const Icon(
                                                                    Icons
                                                                        .more_horiz,
                                                                    color: Colors
                                                                        .grey,
                                                                  ),
                                                                  itemBuilder:
                                                                      (BuildContext
                                                                              context) =>
                                                                          <PopupMenuEntry>[
                                                                    PopupMenuItem(
                                                                        value:
                                                                            'Edit',
                                                                        // textStyle: TextStyle(
                                                                        //     color: Colors.black),
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            //EDITTTTT
                                                                            ElevatedButton(
                                                                              style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, elevation: 0),
                                                                              onPressed: () {
                                                                                setState(() {
                                                                                  showDialog(
                                                                                    context: context,
                                                                                    builder: (context) {
                                                                                      return AlertDialog(
                                                                                        title: Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                                                          children: const [
                                                                                            Text('Edit subcoment'),
                                                                                          ],
                                                                                        ),
                                                                                        actions: [
                                                                                          Column(
                                                                                            children: [
                                                                                              Container(
                                                                                                height: 140,
                                                                                                width: MediaQuery.of(context).size.width,
                                                                                                color: Colors.white,
                                                                                                child: Column(
                                                                                                  children: [
                                                                                                    TextFormField(
                                                                                                      controller: texteditsubcomment,
                                                                                                      keyboardType: TextInputType.multiline,
                                                                                                      decoration: const InputDecoration(
                                                                                                        // focusedBorder: InputBorder.none,
                                                                                                        // enabledBorder: InputBorder.none,
                                                                                                        // hintText: 'edit text here',
                                                                                                        hintStyle: TextStyle(
                                                                                                          color: Colors.grey,
                                                                                                        ),
                                                                                                        border: UnderlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(2))),
                                                                                                      ),
                                                                                                    ),
                                                                                                    Padding(
                                                                                                      padding: const EdgeInsets.all(8.0),
                                                                                                      child: Row(
                                                                                                        children: [
                                                                                                          ElevatedButton(
                                                                                                            style: const ButtonStyle(
                                                                                                              backgroundColor: MaterialStatePropertyAll(Colors.white),
                                                                                                            ),
                                                                                                            onPressed: () {
                                                                                                              Navigator.pop(context);
                                                                                                            },
                                                                                                            child: const Text('Cancel'),
                                                                                                          ),
                                                                                                          const SizedBox(
                                                                                                            width: 10,
                                                                                                          ),
                                                                                                          Mutation(
                                                                                                              options: MutationOptions(document: gql(updateSubComment)),
                                                                                                              builder: (runMutation, result) {
                                                                                                                return ElevatedButton(
                                                                                                                  onPressed: () {
                                                                                                                    runMutation({
                                                                                                                      "id": k["id"],
                                                                                                                      "input": {
                                                                                                                        "commentId": v["id"],
                                                                                                                        "text": texteditsubcomment.text
                                                                                                                      }
                                                                                                                    });
                                                                                                                    setState(() {});
                                                                                                                    refetch!();
                                                                                                                    Navigator.pop(context);
                                                                                                                  },
                                                                                                                  child: const Text('Edit'),
                                                                                                                );
                                                                                                              })
                                                                                                        ],
                                                                                                      ),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ],
                                                                                      );
                                                                                    },
                                                                                  );
                                                                                });
                                                                              },
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: const [
                                                                                  Icon(
                                                                                    Icons.edit,
                                                                                    color: Colors.black54,
                                                                                  ),
                                                                                  Text(
                                                                                    "Edit",
                                                                                    textAlign: TextAlign.start,
                                                                                    style: TextStyle(
                                                                                      color: Colors.black54,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Mutation(
                                                                                options: MutationOptions(
                                                                                    document: gql(deleteSubComment),
                                                                                    onCompleted: (dynamic resultData) {
                                                                                      if (resultData != null) {
                                                                                        setState(() {});
                                                                                        refetch!();
                                                                                      }
                                                                                    }),
                                                                                builder: (runMutation, result) {
                                                                                  return ElevatedButton(
                                                                                    style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, elevation: 0),
                                                                                    onPressed: () {
                                                                                      showDialog(
                                                                                        context: context,
                                                                                        builder: (context) {
                                                                                          return AlertDialog(
                                                                                            actionsAlignment: MainAxisAlignment.end,
                                                                                            actions: [
                                                                                              ElevatedButton(
                                                                                                  onPressed: () {
                                                                                                    Navigator.pop(context);
                                                                                                  },
                                                                                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, elevation: 0),
                                                                                                  child: const Text(
                                                                                                    "Cancel",
                                                                                                  )),
                                                                                              ElevatedButton(
                                                                                                onPressed: () {
                                                                                                  setState(() {});
                                                                                                  runMutation({"id": k["id"]});
                                                                                                  refetch!();
                                                                                                  Navigator.pop(context);
                                                                                                },
                                                                                                style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, elevation: 0),
                                                                                                child: Column(
                                                                                                  children: const [
                                                                                                    Text(
                                                                                                      "Delete",
                                                                                                      style: TextStyle(
                                                                                                        color: Colors.red,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                              )
                                                                                            ],
                                                                                            content: SizedBox(
                                                                                              height: 57,
                                                                                              child: Row(
                                                                                                children: [
                                                                                                  const Icon(
                                                                                                    Icons.question_mark,
                                                                                                    color: Colors.amber,
                                                                                                  ),
                                                                                                  Column(
                                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                    children: const [
                                                                                                      Text(
                                                                                                        "Delete Confirmation",
                                                                                                        style: TextStyle(fontWeight: FontWeight.bold),
                                                                                                      ),
                                                                                                      Text(
                                                                                                        "are you sure delete this\ncomment?",
                                                                                                        maxLines: 2,
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          );
                                                                                        },
                                                                                      );
                                                                                    },
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                      children: const [
                                                                                        Icon(
                                                                                          Icons.delete,
                                                                                          color: Colors.black54,
                                                                                        ),
                                                                                        Text(
                                                                                          "Delete",
                                                                                          textAlign: TextAlign.center,
                                                                                          style: TextStyle(
                                                                                            color: Colors.black54,
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  );
                                                                                }),
                                                                          ],
                                                                        ))
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                              k["text"] ?? "",
                                                            ),
                                                          ],
                                                        ));
                                                  })
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  })
                                ],
                              ),
                            ),
                          ),
                        ]
                      ],
                    ));
                  });
            }),
      ),
    );
  }
}
