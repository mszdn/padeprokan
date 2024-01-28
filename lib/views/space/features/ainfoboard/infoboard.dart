import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:padeprokan/components/organisms/appBar/appbar_widget.dart';
import 'package:padeprokan/components/utils/model/myuser/user_sharedpref.dart';
// import 'package:padeprokan/views/coments/reaction.dart';

String createPost = """
mutation(\$text:String!, \$spaceId:String!)  {
  createPost(input: {
    text: \$text
    spaceId: \$spaceId
  }) {
    id
    text
    space{
      id
    }
    attachments{
      id
      url
    }
  }
}
""";

String updatePost = """
mutation(\$id: String!, \$input: UpdatePostInput!) {
      updatePost(id: \$id, input: \$input) {
        id
        text
      }
    }
""";

String deletePost = """
mutation(\$id: String!) {
      deletePost(id: \$id) {
        id
      }
    }
""";

String comentq = """
query(\$spaceId: String, \$skip: Int) {
        postsConnection(
          orderBy: createdAt_DESC
          query: { spaceId: \$spaceId }
          limit: 10
          skip: \$skip
        ) {
          total
          data {
            id
            text
            createdAt
            attachments {
              id
              name
              url
            }
            sender: createdBy {
              id
              name: firstName
              avatar
            }
          }
        }
      }
""";

class coment extends StatefulWidget {
  final String spaceId;

  const coment(this.spaceId, {super.key});

  @override
  State<coment> createState() => _comentState();
}

class _comentState extends State<coment> {
  final TextEditingController _Textcontroller = TextEditingController();
  List<String> posts = [];
  String text = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBarWidget(context, 'Info Board'),
      body: SingleChildScrollView(
          child: FutureBuilder<GetUserData>(
              future: getUserDataFromJson(),
              builder: (context, snapshot) {
                GetUserData? user = snapshot.data;
                return Column(
                  children: [
                    Query(
                        options: QueryOptions(
                            document: gql(comentq),
                            variables: {"spaceId": widget.spaceId}),
                        builder: (result, {fetchMore, refetch}) {
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
                          // print(result.data?["profiles"][0]["facebook"]);
                          if (result.data != null) {
                            dynamic profile =
                                result.data?["postsConnection"][0];
                            return Mutation(
                                options:
                                    MutationOptions(document: gql(createPost)),
                                builder: (runMutation, result) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 150,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              color: Colors.white,
                                              child: Column(
                                                children: [
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  TextFormField(
                                                    controller: _Textcontroller,
                                                    minLines: 2,
                                                    maxLines: 2,
                                                    keyboardType:
                                                        TextInputType.multiline,
                                                    decoration: InputDecoration(
                                                      icon: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      7.0),
                                                          // child: Icon(
                                                          //   Icons.check_circle_sharp,
                                                          //   size: 40,
                                                          // ),
                                                          child: CircleAvatar(
                                                            radius: 20,
                                                            backgroundImage:
                                                                NetworkImage(
                                                              user?.avatar ??
                                                                  'https://via.placeholder.com/150',
                                                            ),
                                                          )),
                                                      focusedBorder:
                                                          InputBorder.none,
                                                      enabledBorder:
                                                          InputBorder.none,
                                                      hintText:
                                                          'Enter A Message Here',
                                                      hintStyle:
                                                          const TextStyle(
                                                        color: Colors.grey,
                                                      ),
                                                      border: const OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          2))),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      children: [
                                                        const Icon(Icons
                                                            .picture_in_picture_alt_outlined),
                                                        const SizedBox(
                                                          width: 3,
                                                        ),
                                                        const Text('Photos'),
                                                        // FbReaction(),
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              1.7,
                                                        ),
                                                        const Spacer(),
                                                        ElevatedButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                // _Textcontroller.clear();
                                                                // _Textcontroller.notifyListeners();
                                                                posts.add(
                                                                    _Textcontroller
                                                                        .text);
                                                                runMutation({
                                                                  "spaceId": widget
                                                                      .spaceId,
                                                                  "text":
                                                                      _Textcontroller
                                                                          .text
                                                                });
                                                                _Textcontroller
                                                                    .clear();
                                                              });
                                                            },
                                                            child: const Text(
                                                                'Post')),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      (posts.isEmpty)
                                          ? const Text('')
                                          : ListView.builder(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              reverse: true,
                                              shrinkWrap: true,
                                              itemCount: posts.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return SizedBox(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      height: 200,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: Colors.white,
                                                      ),
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                CircleAvatar(
                                                                  radius: 20,
                                                                  backgroundImage:
                                                                      NetworkImage(
                                                                    user?.avatar ??
                                                                        'https://via.placeholder.com/150',
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  width: 12,
                                                                ),
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      user?.firstName ??
                                                                          "",
                                                                      style:
                                                                          const TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        fontSize:
                                                                            20,
                                                                      ),
                                                                    ),
                                                                    const Text(
                                                                        '2 hours ago'),
                                                                  ],
                                                                ),
                                                                const Spacer(),
                                                                PopupMenuButton(
                                                                  enabled: true,
                                                                  // Callback that sets the selected popup menu item.
                                                                  position:
                                                                      PopupMenuPosition
                                                                          .under,
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .more_vert,
                                                                      color: Colors
                                                                          .black),
                                                                  // shape: const RoundedRectangleBorder(
                                                                  //   borderRadius: BorderRadius.all(
                                                                  //     Radius.circular(5),
                                                                  //   ),
                                                                  // ),
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
                                                                                      // return SimpleDialog(
                                                                                      //   children: [
                                                                                      //     TextField(
                                                                                      //       onChanged:
                                                                                      //           (value) {
                                                                                      //         setState(
                                                                                      //             () {
                                                                                      //           text =
                                                                                      //               value;
                                                                                      //         });
                                                                                      //       },
                                                                                      //     ),
                                                                                      //     ElevatedButton(
                                                                                      //       onPressed:
                                                                                      //           () {
                                                                                      //         setState(
                                                                                      //             () {
                                                                                      //           posts[index] =
                                                                                      //               text;
                                                                                      //         });
                                                                                      //         Navigator.pop(
                                                                                      //             context);
                                                                                      //       },
                                                                                      //       child: Text(
                                                                                      //           'Update'),
                                                                                      //     )
                                                                                      //   ],
                                                                                      // );
                                                                                      return AlertDialog(
                                                                                        title: Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                                                          children: [
                                                                                            const Text('Edit Post'),
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
                                                                                                      onChanged: (value) {
                                                                                                        setState(() {
                                                                                                          text = value;
                                                                                                        });
                                                                                                      },
                                                                                                      // controller:
                                                                                                      //     _Textcontroller,
                                                                                                      minLines: 2,
                                                                                                      maxLines: 2,
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
                                                                                                              options: MutationOptions(document: gql(deletePost)),
                                                                                                              builder: (runMutation, result) {
                                                                                                                return ElevatedButton(
                                                                                                                  onPressed: () {
                                                                                                                    setState(() {
                                                                                                                      posts[index] = text;
                                                                                                                      runMutation({
                                                                                                                        "id": "63846f522833fe00339da56a",
                                                                                                                        "text": posts[index] = text
                                                                                                                      });
                                                                                                                      // runMutation({
                                                                                                                      //   "spaceId": "63846f522833fe00339da56a",
                                                                                                                      //   "text": posts[index] = text
                                                                                                                      // });
                                                                                                                    });
                                                                                                                    Navigator.pop(context);
                                                                                                                  },
                                                                                                                  child: const Text('Edit'),
                                                                                                                );
                                                                                                              }),
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
                                                                                    color: Colors.red,
                                                                                  ),
                                                                                  Text(
                                                                                    "Edit",
                                                                                    textAlign: TextAlign.center,
                                                                                    style: TextStyle(
                                                                                      color: Colors.red,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            ElevatedButton(
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
                                                                                            // print("object");
                                                                                            // runMutation({
                                                                                            //   "spaceId": space.id
                                                                                            // });
                                                                                            setState(() {
                                                                                              posts.removeAt(index);
                                                                                            });
                                                                                            Navigator.pop(context);
                                                                                          },
                                                                                          style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, elevation: 0),
                                                                                          child: Column(
                                                                                            children: [
                                                                                              const Text(
                                                                                                "Delete",
                                                                                                style: TextStyle(
                                                                                                  color: Colors.red,
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        )
                                                                                      ],
                                                                                      content: const SizedBox(
                                                                                        height: 80,
                                                                                        child: Center(
                                                                                          child: Text("Delete this space?"),
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
                                                                                    color: Colors.red,
                                                                                  ),
                                                                                  Text(
                                                                                    "Delete",
                                                                                    textAlign: TextAlign.center,
                                                                                    style: TextStyle(
                                                                                      color: Colors.red,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ))
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 20,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  posts[index],
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        25,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 22,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                const Icon(
                                                                  Icons.circle,
                                                                  size: 30,
                                                                ),
                                                                const Text(
                                                                    'Reaction'),

                                                                // Stack(
                                                                //   children: [
                                                                //     FbReaction(),
                                                                //   ],
                                                                // ),
                                                                const SizedBox(
                                                                  width: 100,
                                                                ),
                                                                const Icon(
                                                                  Icons
                                                                      .mode_comment_outlined,
                                                                  size: 30,
                                                                ),
                                                                const Text(
                                                                    'Comment')
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                    ],
                                  );
                                });
                          }
                          return Container();
                        }),
                  ],
                );
              })),
    );
  }
}
