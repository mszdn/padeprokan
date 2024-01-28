import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:padeprokan/components/utils/model/myuser/user_sharedpref.dart';
import 'package:padeprokan/views/space/features/task/detail/qumutaactiv.dart';

class activity extends StatefulWidget {
  final String Id;
  const activity({
    super.key,
    required this.Id,
  });

  @override
  State<activity> createState() => _activityState();
}

class _activityState extends State<activity> {
  final TextEditingController _Texteditcoment = TextEditingController();
  final TextEditingController _Textpostcoment = TextEditingController();
  List<String> posts = [];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<GetUserData>(
        future: getUserDataFromJson(),
        builder: (context, snapshot) {
          GetUserData? user = snapshot.data;
          print("${user?.id} wkwkw");
          return Query(
              options: QueryOptions(
                  document: gql(quactivity), variables: {"id": widget.Id}),
              builder: (result, {fetchMore, refetch}) {
                print("sa jjj" + widget.Id);
                if (result.isLoading) {
                  return Text("loading");
                }
                if (result.hasException) {
                  return Text(result.exception.toString());
                }
                if (result.data != null) {
                  dynamic postsqu = result.data?["card"]?["posts"];
                  print("asd ${postsqu}");
                  return Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.message_outlined),
                          Text(
                            "Activity",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // Mutation(
                      //     options: MutationOptions(
                      //       document: gql(postactiv),
                      //       onCompleted: (dynamic resultData) {
                      //         print("$resultData ijn");
                      //         if (resultData != null) {
                      //           setState(() {
                      //             refetch!();
                      //           });
                      //         }
                      //       },
                      //     ),
                      //     builder: (runMutation, result) {
                      //       print(result?.data);
                      //       return
                      TextFormField(
                        controller: _Textpostcoment,
                        decoration: InputDecoration(
                          hintText: "Post",
                          border: OutlineInputBorder(),
                          // suffixIcon: IconButton(
                          //     onPressed: () {
                          //       setState(() {
                          //         print("$result as");
                          //         // _Textcontroller.clear();
                          //         // _Textcontroller.notifyListeners();
                          //         posts.add(_Textpostcoment.text);
                          //         runMutation({
                          //           // "id": widget.Id,
                          //           "input": {
                          //             "cardId": widget.Id,
                          //             "text": _Textpostcoment.text,
                          //           },
                          //         });
                          //         setState(() {
                          //           refetch!();
                          //         });
                          //         _Textpostcoment.clear();
                          //       });
                          //     },
                          //     icon: Icon(Icons.send_rounded))
                        ),
                      ),
                      // }),
                      SizedBox(
                        height: 5,
                      ),
                      Mutation(
                          options: MutationOptions(
                            document: gql(postactiv),
                            onCompleted: (dynamic resultData) {
                              print("$resultData ++++");
                              if (resultData != null) {
                                setState(() {
                                  refetch!();
                                });
                              }
                            },
                          ),
                          builder: (runMutation, result) {
                            print(result?.data);
                            return Row(
                              children: [
                                ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Colors.green)),
                                    onPressed: () {
                                      setState(() {
                                        // _Textcontroller.clear();
                                        // _Textcontroller.notifyListeners();
                                        posts.add(_Textpostcoment.text);
                                        runMutation({
                                          "input": {
                                            "cardId": widget.Id,
                                            "text": _Textpostcoment.text
                                          }
                                        });
                                        setState(() {
                                          refetch!();
                                        });
                                        _Textpostcoment.clear();
                                      });
                                    },
                                    child: Text(
                                      "Post",
                                      style: TextStyle(color: Colors.white),
                                    ))
                              ],
                            );
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      ...postsqu.map((f) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    user!.avatar ??
                                        'https://via.placeholder.com/150',
                                  ),
                                ),
                                Column(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(user.firstName ?? ""),
                                    Card(
                                      color: Colors.white,
                                      child: Text(f["text"]),
                                    ),
                                    Row(
                                      children: [
                                        TextButton(
                                            onPressed: () {},
                                            child: Text(
                                              "Comment",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            )),
                                        TextButton(
                                            onPressed: () {
                                              setState(() {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text('Edit Post'),
                                                        ],
                                                      ),
                                                      actions: [
                                                        Column(
                                                          children: [
                                                            Card(
                                                              color:
                                                                  Colors.white,
                                                              child: Column(
                                                                children: [
                                                                  TextFormField(
                                                                    controller:
                                                                        _Texteditcoment,
                                                                    minLines: 2,
                                                                    maxLines: 2,
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .multiline,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      hintStyle:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .grey,
                                                                      ),
                                                                      border: UnderlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(2))),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Row(
                                                                      children: [
                                                                        ElevatedButton(
                                                                          style:
                                                                              ButtonStyle(
                                                                            backgroundColor:
                                                                                MaterialStatePropertyAll(Colors.white),
                                                                          ),
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              Text('Cancel'),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        Mutation(
                                                                            options:
                                                                                MutationOptions(document: gql(updateactiv)),
                                                                            builder: (runMutation, result) {
                                                                              print("${result?.data} hafff");
                                                                              return ElevatedButton(
                                                                                onPressed: () {
                                                                                  setState(() {
                                                                                    // posts[index] = text;
                                                                                    runMutation({
                                                                                      "id": f["id"],
                                                                                      "input": {
                                                                                        "text": _Texteditcoment.text,
                                                                                      },
                                                                                    });
                                                                                  });
                                                                                  refetch!();
                                                                                  Navigator.pop(context);
                                                                                  _Texteditcoment.clear();
                                                                                },
                                                                                child: Text('Edit'),
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
                                            child: Text(
                                              "Edit",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            )),
                                        Mutation(
                                            options: MutationOptions(
                                              document: gql(deleteactiv),
                                              onCompleted:
                                                  (dynamic resultData) {
                                                print("$resultData ++++");

                                                if (resultData != null) {
                                                  setState(() {});
                                                  refetch!();
                                                }
                                              },
                                            ),
                                            builder: (
                                              runMutation,
                                              result,
                                            ) {
                                              return TextButton(
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
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                style: ElevatedButton.styleFrom(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .transparent,
                                                                    elevation:
                                                                        0),
                                                                child:
                                                                    const Text(
                                                                  "Cancel",
                                                                )),
                                                            ElevatedButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  runMutation({
                                                                    "id":
                                                                        f["id"]
                                                                  });
                                                                });
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              style: ElevatedButton
                                                                  .styleFrom(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .transparent,
                                                                      elevation:
                                                                          0),
                                                              child: Column(
                                                                children: [
                                                                  const Text(
                                                                    "Delete",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .red,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                          content:
                                                              const SizedBox(
                                                            height: 80,
                                                            child: Center(
                                                              child: Text(
                                                                  "Deleting an comment is permanent \ There is no undo."),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: Text(
                                                    "Delete",
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ));
                                            }),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        );
                      })
                    ],
                  );
                }
                return Container();
              });
        });
  }
}
