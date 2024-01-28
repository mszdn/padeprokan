import 'dart:async';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:padeprokan/components/organisms/appBar/appbar_widget.dart';
import 'package:padeprokan/components/utils/theme_colors.dart';
import 'package:padeprokan/graphql/automaticheckin/auto.dart';
import 'package:padeprokan/graphql/automaticheckin/chenkinroom.dart';
import 'package:padeprokan/graphql/automaticheckin/createCheckInRoom.dart';
import 'package:padeprokan/graphql/automaticheckin/update.dart';
import 'package:padeprokan/views/space/features/automaticCheckins/checkins_index.dart';
import '../../../../graphql/automaticheckin/deleteCheckInRoom.dart';

class AutomaticCheckinsScreen extends StatefulWidget {
  final String spaceId;
  final String id;
  final dynamic refetchSpaces;
  AutomaticCheckinsScreen(
      {super.key,
      required this.spaceId,
      required this.id,
      required this.refetchSpaces});

  @override
  State<AutomaticCheckinsScreen> createState() =>
      _AutomaticCheckinsScreenState();
}

class _AutomaticCheckinsScreenState extends State<AutomaticCheckinsScreen> {
  TextEditingController textquestion = TextEditingController();
  TextEditingController textedit = TextEditingController();
  TextEditingController timeinput = TextEditingController();

  List<String> posts = [];
  String text = "";
  @override
  Widget build(BuildContext context) {
    dynamic refetchAut;
    return Scaffold(
        backgroundColor: ColorStyle().scaffoldcolor,
        appBar: appBarWidget(context, 'Automatic Check-ins'),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Row(
                  children: [
                    const Text(
                      'Add Automatic Checkin',
                      style: TextStyle(fontSize: 16),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close))
                  ],
                ),
                actions: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Question',
                        style: TextStyle(fontSize: 16),
                      ),
                      TextFormField(
                        controller: textquestion,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorStyle().purpleColor)),
                            hintText: 'What did you did Yesterday?'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'time notify',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        width: 115,
                        child: TextField(
                          controller:
                              timeinput, //editing controller of this TextField
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ColorStyle().purpleColor)),
                              suffixIcon: Icon(Icons.timer),
                              hintText: "10:00" //label text of field
                              ),
                          readOnly:
                              true, //set it true, so that user will not able to edit text
                          onTap: () async {
                            TimeOfDay? pickedTime = await showTimePicker(
                              initialTime: TimeOfDay.now(),
                              context: context,
                            );

                            if (pickedTime != null) {
                              print(
                                  pickedTime.format(context)); //output 10:51 PM
                              setState(() {
                                timeinput.text = pickedTime.format(context);
                              });
                            } else {
                              print("Time is not selected");
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              style: const ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.white)),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel")),
                          SizedBox(
                            width: 12,
                          ),
                          Mutation(
                              options: MutationOptions(
                                document: gql(createCheckInRoom),
                                onCompleted: (dynamic resultData) {
                                  print("$resultData ------");
                                  if (resultData != null) {
                                    setState(() {});
                                    refetchAut!();
                                  }
                                },
                              ),
                              builder: (runMutation, result) {
                                return ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                ColorStyle().PurpleButton)),
                                    onPressed: () {
                                      // widget.refetchSpaces!();
                                      runMutation({
                                        "question": textquestion.text,
                                        "time": timeinput.text,
                                        "spaceId": widget.spaceId
                                      });
                                      setState(() {});
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      "OK",
                                      style: TextStyle(color: Colors.white),
                                    ));
                              })
                        ],
                      )
                    ],
                  )
                ],
              ),
            );
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: Query(
          options: QueryOptions(
              document: gql(checkInRooms),
              variables: {"spaceId": widget.spaceId}),
          builder: (result, {fetchMore, refetch}) {
            print(result);
            refetchAut = refetch;
            if (result.hasException) {
              return Center(
                child: Center(
                  child: LoadingAnimationWidget.halfTriangleDot(
                      color: Colors.black, size: 50),
                ),
              );
            }
            if (result.isLoading) {
              return Center(
                child: Center(
                  child: LoadingAnimationWidget.halfTriangleDot(
                      color: Colors.black, size: 50),
                ),
              );
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  if (result.data != null) ...[
                    ...result.data!["checkInRooms"].map((v) {
                      print("0000  ${v}");
                      return Container(
                        child: Column(
                          children: [
                            // ...v["space"]?["students"]!.map((c) {
                            //   CircleAvatar(
                            //     backgroundImage: NetworkImage(c["user"]
                            //             ["avatar"] ??
                            //         "https://via.placeholder.com/150"),
                            //   );
                            // }),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(12.0),
                                          child: Text(
                                              'Asking 1 people every day at'),
                                        ),
                                        Text(v["time"] ?? ""),
                                        const Spacer(),
                                        PopupMenuButton(
                                          child: const Icon(Icons.more_vert),
                                          itemBuilder: (BuildContext context) =>
                                              <PopupMenuEntry>[
                                            PopupMenuItem(
                                                value: 'Edit',
                                                // textStyle: TextStyle(
                                                //     color: Colors.black),
                                                child: Column(
                                                  children: [
                                                    //EDITTTTT
                                                    ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              elevation: 0),
                                                      onPressed: () {
                                                        setState(() {
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (context) =>
                                                                    AlertDialog(
                                                              title: Row(
                                                                children: [
                                                                  const Text(
                                                                    'Edit Automatic Checkin',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            16),
                                                                  ),
                                                                  const Spacer(),
                                                                  IconButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      icon: const Icon(
                                                                          Icons
                                                                              .close))
                                                                ],
                                                              ),
                                                              actions: [
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    const Text(
                                                                      'Question',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16),
                                                                    ),
                                                                    TextFormField(
                                                                      controller:
                                                                          textedit,
                                                                      cursorColor:
                                                                          Colors
                                                                              .black,
                                                                      decoration: InputDecoration(
                                                                          border:
                                                                              const OutlineInputBorder(),
                                                                          focusedBorder:
                                                                              OutlineInputBorder(borderSide: BorderSide(color: ColorStyle().purpleColor)),
                                                                          hintText: v["question"]),
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    const Text(
                                                                      'time notify',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16),
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          115,
                                                                      child:
                                                                          TextField(
                                                                        controller:
                                                                            timeinput, //editing controller of this TextField
                                                                        decoration: InputDecoration(
                                                                            border:
                                                                                OutlineInputBorder(),
                                                                            focusedBorder:
                                                                                OutlineInputBorder(borderSide: BorderSide(color: ColorStyle().purpleColor)),
                                                                            suffixIcon: Icon(Icons.timer),
                                                                            hintText: v["time"] //label text of field
                                                                            ),
                                                                        readOnly:
                                                                            true, //set it true, so that user will not able to edit text
                                                                        onTap:
                                                                            () async {
                                                                          TimeOfDay?
                                                                              pickedTime =
                                                                              await showTimePicker(
                                                                            initialTime:
                                                                                TimeOfDay.now(),
                                                                            context:
                                                                                context,
                                                                          );

                                                                          if (pickedTime !=
                                                                              null) {
                                                                            print(pickedTime.format(context)); //output 10:51 PM

                                                                            setState(() {
                                                                              timeinput.text = pickedTime.format(context);
                                                                            });
                                                                          } else {
                                                                            print("Time is not selected");
                                                                          }
                                                                        },
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        ElevatedButton(
                                                                            style:
                                                                                const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.white)),
                                                                            onPressed: () {
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child: const Text("Cancel")),
                                                                        const SizedBox(
                                                                          width:
                                                                              12,
                                                                        ),
                                                                        Mutation(
                                                                            options:
                                                                                MutationOptions(document: gql(updateCheckInRoom)),
                                                                            builder: (runMutation, result) {
                                                                              return ElevatedButton(
                                                                                  style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(ColorStyle().PurpleButton)),
                                                                                  onPressed: () {
                                                                                    runMutation({
                                                                                      "id": v["id"],
                                                                                      "input": {
                                                                                        "question": textedit.text,
                                                                                        "time": timeinput.text,
                                                                                        "spaceId": widget.spaceId
                                                                                      }
                                                                                    });
                                                                                    Navigator.pop(context);
                                                                                    refetch!();
                                                                                  },
                                                                                  child: const Text(
                                                                                    "OK",
                                                                                    style: TextStyle(color: Colors.white),
                                                                                  ));
                                                                            })
                                                                      ],
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          );
                                                        });
                                                      },
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: const [
                                                          Icon(
                                                            Icons.edit,
                                                            color:
                                                                Colors.black54,
                                                          ),
                                                          Text(
                                                            "Edit",
                                                            textAlign:
                                                                TextAlign.right,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black54),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              elevation: 0),
                                                      onPressed: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                              actionsAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              actions: [
                                                                ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    style: ElevatedButton.styleFrom(
                                                                        backgroundColor:
                                                                            Colors
                                                                                .transparent,
                                                                        elevation:
                                                                            0),
                                                                    child: Text(
                                                                      "Cancel",
                                                                    )),
                                                                Mutation(
                                                                    options: MutationOptions(
                                                                        document:
                                                                            gql(
                                                                                deleteCheckInRoom)),
                                                                    builder:
                                                                        (runMutation,
                                                                            result) {
                                                                      print(result
                                                                          ?.data);
                                                                      return ElevatedButton(
                                                                        onPressed:
                                                                            () {
                                                                          runMutation({
                                                                            "id":
                                                                                v["id"]
                                                                          });
                                                                          refetch!();
                                                                          setState(
                                                                              () {});
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        style: ElevatedButton.styleFrom(
                                                                            backgroundColor:
                                                                                Colors.transparent,
                                                                            elevation: 0),
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            const Text(
                                                                              "Delete",
                                                                              style: TextStyle(
                                                                                color: Colors.red,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      );
                                                                    })
                                                              ],
                                                              content:
                                                                  const SizedBox(
                                                                height: 80,
                                                                child: Center(
                                                                  child: Text(
                                                                      "Are you sure to delete this ?"),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: const [
                                                          Icon(
                                                            Icons.delete,
                                                            color:
                                                                Colors.black54,
                                                          ),
                                                          Text(
                                                            "Delete",
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black54),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ))
                                          ],
                                        )
                                      ],
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CheckinsPage(
                                                      id: v["id"],
                                                      spaceId: "",
                                                    )));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            // v["question"],
                                            v["question"] ?? "",
                                            // v["question"],
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Container(),
                                            const Spacer(),
                                            Row(
                                              children: [
                                                ...v["space"]?["students"]
                                                    .map((c) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 4),
                                                    child: Column(
                                                      children: [
                                                        CircleAvatar(
                                                          backgroundImage:
                                                              NetworkImage(c[
                                                                          "user"]
                                                                      [
                                                                      "avatar"] ??
                                                                  "https://via.placeholder.com/150"),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    })
                  ]
                ],
              ),
            );
          },
        ));
  }

  // Future<void> selectTime() async {
  //   TimeOfDay? picked = await showTimePicker(
  //     context: context,
  //     initialTime: _timeOfDay,
  //     initialEntryMode: TimePickerEntryMode.inputOnly,
  //   );
  //   if (picked != null) {
  //     setState(() {
  //       _timeOfDay = picked;
  //     });
  //   }
  // }
}
