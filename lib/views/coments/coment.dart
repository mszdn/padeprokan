import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:padeprokan/components/organisms/appBar/appbar_widget.dart';
import 'package:padeprokan/views/coments/mutaphoto.dart';
import 'package:padeprokan/views/coments/qsubcoment.dart';
// import 'package:padeprokan/views/coments/subinfoboard.dart';
import 'package:padeprokan/views/coments/qsubcoment.dart';

import '../../components/utils/model/myuser/user_sharedpref.dart';

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
  // final String id;
  final String spaceId;
  final String postId;
  coment({
    super.key,
    required this.spaceId,
    required this.postId,
    // required this.id
  });

  @override
  State<coment> createState() => _comentState();
}

class _comentState extends State<coment> {
  File? imager;
  bool isLoading = false;
  late String _localPath;
  late bool _permissionReady;
  late TargetPlatform? platform;
  final TextEditingController _Textcontroller = TextEditingController();
  final TextEditingController _Texteditsubcoment = TextEditingController();
  final TextEditingController _Textcontrollersub = TextEditingController();
  final TextEditingController _Texteditcoment = TextEditingController();
  List<String> posts = [];
  List<String> postssub = [];
  String text = "";
  List<String> posts1 = [];
  String text1 = "";
  dynamic refetchData;
  @override
  Widget build(BuildContext context) {
    Future getImage() async {
      final ImagePicker picker = ImagePicker();
      // Pick an image
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      // print(image!.path);
      if (image != null)
        setState(() {
          imager = File(image.path);
          print(imager);
        });
    }

    return Scaffold(
      appBar: appBarWidget(context, "Info Board"),
      body: SingleChildScrollView(
        child: FutureBuilder<GetUserData>(
            future: getUserDataFromJson(),
            builder: (context, snapshot) {
              GetUserData? user = snapshot.data;
              print("${user?.id} wkwkw");
              return Query(
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
                    if (result.data != null) {
                      dynamic postasas =
                          result.data!["postsConnection"]["data"];
                      print("tyty $postasas");
                      // return Query(
                      //     options: QueryOptions(
                      //         document: gql(querysubcom),
                      //         variables: {
                      //           "spaceId": widget.spaceId
                      //           // "id": widget.id,
                      //         }),
                      //     builder: (result, {fetchMore, refetch}) {
                      //       if (result.isLoading) {
                      //         return const Text("loading");
                      //       }
                      //       if (result.hasException) {
                      //         return const Text("error");
                      //       }
                      //       // print(result.data?["profiles"][0]["facebook"]);
                      //       if (result.data != null) {
                      //         // print(result.data);
                      //         dynamic postsub =
                      //             result.data!["commentsConnection"]["data"];
                      //         print("sub $postsub");
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 180,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: _Textcontroller,
                                    minLines: 2,
                                    maxLines: 2,
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                      icon: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 7.0),
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                              radius: 20,
                                              backgroundImage: NetworkImage(
                                                user?.avatar ??
                                                    'https://via.placeholder.com/150',
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            )
                                          ],
                                        ),
                                      ),
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      hintText: 'Enter A Message Here',
                                      hintStyle: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                      border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(2))),
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            const Spacer(),
                                            Mutation(
                                                options: MutationOptions(
                                                  document: gql(createPost),
                                                  onCompleted:
                                                      (dynamic resultData) {
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
                                                  return ElevatedButton(
                                                      onPressed: () {
                                                        // getImage();
                                                        setState(() {
                                                          // _Textcontroller.clear();
                                                          // _Textcontroller.notifyListeners();
                                                          posts.add(
                                                              _Textcontroller
                                                                  .text);
                                                          runMutation({
                                                            "spaceId":
                                                                widget.spaceId,
                                                            "text":
                                                                _Textcontroller
                                                                    .text
                                                          });
                                                          setState(() {
                                                            refetch!();
                                                          });
                                                          _Textcontroller
                                                              .clear();
                                                        });
                                                      },
                                                      child:
                                                          const Text('Post'));
                                                }),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ]),
                              ),
                            ),
                          ),
                          Mutation(
                              options: MutationOptions(
                                document: gql(deletePost),
                                onCompleted: (dynamic resultData) {
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
                                return Column(
                                  children: [
                                    ...postasas.map((v) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 20,
                                                      backgroundImage:
                                                          NetworkImage(
                                                        user?.avatar ??
                                                            'https://via.placeholder.com/150',
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 12,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          user?.firstName ?? "",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 20,
                                                          ),
                                                        ),
                                                        Text(v["createdAt"]),
                                                      ],
                                                    ),
                                                    Spacer(),
                                                    PopupMenuButton(
                                                      enabled: true,
                                                      // Callback that sets the selected popup menu item.
                                                      position:
                                                          PopupMenuPosition
                                                              .under,
                                                      icon: const Icon(
                                                          Icons.more_vert,
                                                          color: Colors.black),
                                                      // shape: const RoundedRectangleBorder(
                                                      //   borderRadius: BorderRadius.all(
                                                      //     Radius.circular(5),
                                                      //   ),
                                                      // ),
                                                      itemBuilder: (BuildContext
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
                                                                            title:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              children: [
                                                                                Text('Edit Post'),
                                                                              ],
                                                                            ),
                                                                            actions: [
                                                                              Column(
                                                                                children: [
                                                                                  Card(
                                                                                    color: Colors.white,
                                                                                    child: Column(
                                                                                      children: [
                                                                                        TextFormField(
                                                                                          controller: _Texteditcoment,
                                                                                          minLines: 2,
                                                                                          maxLines: 2,
                                                                                          keyboardType: TextInputType.multiline,
                                                                                          decoration: InputDecoration(
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
                                                                                                style: ButtonStyle(
                                                                                                  backgroundColor: MaterialStatePropertyAll(Colors.white),
                                                                                                ),
                                                                                                onPressed: () {
                                                                                                  Navigator.pop(context);
                                                                                                },
                                                                                                child: Text('Cancel'),
                                                                                              ),
                                                                                              SizedBox(
                                                                                                width: 10,
                                                                                              ),
                                                                                              Mutation(
                                                                                                  options: MutationOptions(document: gql(updatePost)),
                                                                                                  builder: (runMutation, result) {
                                                                                                    print("${result?.data} hahh?");
                                                                                                    return ElevatedButton(
                                                                                                      onPressed: () {
                                                                                                        setState(() {
                                                                                                          // posts[index] = text;
                                                                                                          runMutation({
                                                                                                            "id": v["id"],
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
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: const [
                                                                      Icon(
                                                                        Icons
                                                                            .edit,
                                                                        color: Colors
                                                                            .red,
                                                                      ),
                                                                      Text(
                                                                        "Edit",
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.red,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Mutation(
                                                                    options:
                                                                        MutationOptions(
                                                                      document:
                                                                          gql(deletePost),
                                                                      onCompleted:
                                                                          (dynamic
                                                                              resultData) {
                                                                        print(
                                                                            "$resultData ++++");

                                                                        if (resultData !=
                                                                            null) {
                                                                          setState(
                                                                              () {});
                                                                          refetch!();
                                                                        }
                                                                      },
                                                                    ),
                                                                    builder: (
                                                                      runMutation,
                                                                      result,
                                                                    ) {
                                                                      return Column(
                                                                        children: [
                                                                          ElevatedButton(
                                                                            style:
                                                                                ElevatedButton.styleFrom(backgroundColor: Colors.transparent, elevation: 0),
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
                                                                                          setState(() {
                                                                                            runMutation({
                                                                                              "id": v["id"]
                                                                                            });
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
                                                                            child:
                                                                                Row(
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
                                                                          )
                                                                        ],
                                                                      );
                                                                    }),
                                                              ],
                                                            ))
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      v["text"],
                                                      style: TextStyle(
                                                          fontSize: 25),
                                                    ),
                                                  ],
                                                ),
                                                ...v["attachments"].map((g) {
                                                  return Container(
                                                    height: 50,
                                                    width: 70,
                                                    child: CachedNetworkImage(
                                                        imageUrl: g["url"]),
                                                  );
                                                }),
                                                SizedBox(
                                                  height: 22,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.circle,
                                                      size: 30,
                                                    ),
                                                    Text('Reaction'),
                                                    // Stack(
                                                    //   children: [
                                                    //     FbReaction(),
                                                    //   ],
                                                    // ),
                                                    SizedBox(
                                                      width: 100,
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        getImage()
                                                            .then((value) {
                                                          if (imager != null) {
                                                            return showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) =>
                                                                        Container(
                                                                          height:
                                                                              500,
                                                                          width: MediaQuery.of(context)
                                                                              .size
                                                                              .width,
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              AlertDialog(
                                                                                contentPadding: EdgeInsets.zero,
                                                                                scrollable: true,
                                                                                content: SingleChildScrollView(
                                                                                  child: Column(
                                                                                    children: [
                                                                                      Column(
                                                                                        children: [
                                                                                          // ...post.map((g){
                                                                                          Container(
                                                                                            height: 400,
                                                                                            width: MediaQuery.of(context).size.width,
                                                                                            child: SingleChildScrollView(
                                                                                              child: Image.file(
                                                                                                imager!,
                                                                                                fit: BoxFit.cover,
                                                                                              ),
                                                                                            ),
                                                                                          ),

                                                                                          const SizedBox(
                                                                                            height: 30,
                                                                                          ),
                                                                                          const Divider(
                                                                                            color: Colors.black,
                                                                                            height: 1,
                                                                                          ),
                                                                                          const SizedBox(
                                                                                            height: 30,
                                                                                          ),
                                                                                          Padding(
                                                                                            padding: const EdgeInsets.all(10),
                                                                                            child: Row(
                                                                                              crossAxisAlignment: CrossAxisAlignment.end,
                                                                                              children: [
                                                                                                const Spacer(),
                                                                                                Column(
                                                                                                  children: [
                                                                                                    Container(
                                                                                                      height: 40,
                                                                                                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.black)),
                                                                                                      child: TextButton(
                                                                                                        onPressed: () {
                                                                                                          Navigator.of(context).pop();
                                                                                                        },
                                                                                                        child: const Text(
                                                                                                          'Cancel',
                                                                                                          style: TextStyle(
                                                                                                            color: Colors.black,
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                                const SizedBox(
                                                                                                  width: 20,
                                                                                                ),
                                                                                                Container(
                                                                                                  child: Column(
                                                                                                    children: [
                                                                                                      Container(
                                                                                                        height: 40,
                                                                                                        decoration: BoxDecoration(
                                                                                                          color: Colors.purple,
                                                                                                          borderRadius: BorderRadius.circular(5),
                                                                                                          border: Border.all(
                                                                                                            color: const Color.fromRGBO(173, 120, 211, 1),
                                                                                                          ),
                                                                                                        ),
                                                                                                        child: Mutation(
                                                                                                            options: MutationOptions(
                                                                                                              document: gql(postphoto123),
                                                                                                              onCompleted: (dynamic resultData) {
                                                                                                                print("$resultData asdf");
                                                                                                                Navigator.of(context).pop();
                                                                                                                if (result?.data != null) {
                                                                                                                  setState(() {
                                                                                                                    refetch!();
                                                                                                                  });
                                                                                                                }
                                                                                                              },
                                                                                                            ),
                                                                                                            builder: (
                                                                                                              runMutation,
                                                                                                              result,
                                                                                                            ) {
                                                                                                              return TextButton(
                                                                                                                onPressed: () {
                                                                                                                  var byteData = imager!.readAsBytesSync();
                                                                                                                  print(imager!.path.split("/").removeLast().split(".").removeLast());
                                                                                                                  var multipartFile = MultipartFile.fromBytes(
                                                                                                                    'photo',
                                                                                                                    byteData,
                                                                                                                    filename: '${DateTime.now().second}.jpg',
                                                                                                                    contentType: MediaType("file", imager!.path.split("/").removeLast().split(".").removeLast()),
                                                                                                                  );

                                                                                                                  var fileType = {
                                                                                                                    "type": "file",
                                                                                                                    "ext": imager!.path.split("/").removeLast().split(".").removeLast(),
                                                                                                                  };
                                                                                                                  print(widget.spaceId);
                                                                                                                  // print("AAA",multipartFile);
                                                                                                                  runMutation({
                                                                                                                    // "spaceId": widget.spaceId,
                                                                                                                    "input": {
                                                                                                                      // "postId": widget.spaceId,
                                                                                                                      "postId": v["id"],
                                                                                                                      // "id": widget.spaceId,
                                                                                                                      // "id": "6417f0e37b5f7300340e8f26",
                                                                                                                      // "id": post["postsConnection"]["id"],
                                                                                                                      "name": imager!.path.split("/").removeLast(),
                                                                                                                      "url": multipartFile,
                                                                                                                      // "spaceId": widget.spaceId,
                                                                                                                      // "folderId":
                                                                                                                      //     widget
                                                                                                                      //         .folderId,
                                                                                                                      // "type": json
                                                                                                                      //     .encode(
                                                                                                                      //         fileType)
                                                                                                                    }
                                                                                                                  });
                                                                                                                },
                                                                                                                child: const Text(
                                                                                                                  'Submit',
                                                                                                                  style: TextStyle(
                                                                                                                    color: Colors.white,
                                                                                                                  ),
                                                                                                                ),
                                                                                                              );
                                                                                                            }),
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          )
                                                                                          // })
                                                                                        ],
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ));
                                                          }
                                                        });
                                                      },
                                                      child: Row(
                                                        children: [
                                                          const Icon(Icons
                                                              .picture_in_picture_alt_outlined),
                                                          const SizedBox(
                                                            width: 3,
                                                          ),
                                                          const Text('Photos'),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 7,
                                                ),
                                                // subinfo(
                                                //     spaceId: widget.spaceId,
                                                //     id: v["id"]),
                                                // TextFormField(
                                                //   decoration: InputDecoration(
                                                //       suffixIcon: Mutation(
                                                //           options:
                                                //               MutationOptions(
                                                //             document: gql(
                                                //                 mutacreatesub),
                                                //             onCompleted: (dynamic
                                                //                 resultData) {
                                                //               print(
                                                //                   "$resultData fghj");
                                                //               Navigator.of(
                                                //                       context)
                                                //                   .pop();
                                                //               if (result
                                                //                       ?.data !=
                                                //                   null) {
                                                //                 setState(() {
                                                //                   refetch!();
                                                //                 });
                                                //               }
                                                //             },
                                                //           ),
                                                //           builder: (
                                                //             runMutation,
                                                //             result,
                                                //           ) {
                                                //             return IconButton(
                                                //                 onPressed: () {
                                                //                   setState(() {
                                                //                     // _Textcontroller.clear();
                                                //                     // _Textcontroller.notifyListeners();
                                                //                     postssub.add(
                                                //                         _Textcontrollersub
                                                //                             .text);
                                                //                     runMutation({
                                                //                       // "input": {
                                                //                       "id": v[
                                                //                           "id"],
                                                //                       "message":
                                                //                           _Textcontrollersub
                                                //                               .text
                                                //                       // }
                                                //                     });
                                                //                     setState(
                                                //                         () {
                                                //                       refetch!();
                                                //                     });
                                                //                     _Textcontrollersub
                                                //                         .clear();
                                                //                   });
                                                //                 },
                                                //                 icon: Icon(Icons
                                                //                     .send_rounded));
                                                //           }),
                                                //       hintText:
                                                //           "type your message here",
                                                //       border: OutlineInputBorder(
                                                //           borderRadius:
                                                //               BorderRadius.all(
                                                //                   Radius
                                                //                       .circular(
                                                //                           5)))),
                                                // ),
                                                // ...postsub.map((s) {
                                                //   print(
                                                //       "fgh${result!.data}");
                                                //   return Card(
                                                //     child: Column(
                                                //       children: [
                                                //         Row(
                                                //           children: [
                                                //             CircleAvatar(
                                                //               radius:
                                                //                   20,
                                                //               backgroundImage:
                                                //                   NetworkImage(
                                                //                 user?.avatar ??
                                                //                     'https://via.placeholder.com/150',
                                                //               ),
                                                //             ),
                                                //             Text(
                                                //               user?.firstName ??
                                                //                   "",
                                                //               style:
                                                //                   TextStyle(
                                                //                 fontWeight:
                                                //                     FontWeight.w400,
                                                //                 fontSize:
                                                //                     15,
                                                //               ),
                                                //             ),
                                                //           ],
                                                //         ),
                                                //         Text(
                                                //             s["message"] ??
                                                //                 "")
                                                //       ],
                                                //     ),
                                                //   );
                                                // })
                                                TextFormField(
                                                  controller:
                                                      _Textcontrollersub,
                                                  decoration: InputDecoration(
                                                      suffixIcon: Mutation(
                                                          options:
                                                              MutationOptions(
                                                            document: gql(
                                                                mutacreatesub),
                                                            // onCompleted: (dynamic resultData) {
                                                            //   print("$resultData fghj");
                                                            //   Navigator.of(context).pop();
                                                            //   if (result.data != null) {
                                                            //     setState(() {
                                                            //       refetch!();
                                                            //     });
                                                            // }
                                                            // }
                                                            // ,
                                                            onCompleted: (dynamic
                                                                resultData) {
                                                              print(
                                                                  "$resultData vo");

                                                              if (resultData !=
                                                                  null) {
                                                                setState(() {});
                                                                refetch!();
                                                              }
                                                            },
                                                          ),
                                                          builder: (
                                                            runMutation,
                                                            result,
                                                          ) {
                                                            return IconButton(
                                                                onPressed: () {
                                                                  setState(() {
                                                                    // _Textcontroller.clear();
                                                                    // _Textcontroller.notifyListeners();
                                                                    postssub.add(
                                                                        _Textcontrollersub
                                                                            .text);
                                                                    runMutation({
                                                                      "input": {
                                                                        "postId":
                                                                            v["id"],
                                                                        "text":
                                                                            _Textcontrollersub.text
                                                                      }
                                                                    });
                                                                    // runMutation({
                                                                    //   "input": {
                                                                    //     "id": widget.postId,
                                                                    //     "text": _Textcontrollersub.text
                                                                    //   }
                                                                    // });
                                                                    setState(
                                                                        () {
                                                                      refetch!();
                                                                    });
                                                                    _Textcontrollersub
                                                                        .clear();
                                                                  });
                                                                },
                                                                icon: Icon(Icons
                                                                    .send_rounded));
                                                          }),
                                                      hintText:
                                                          "type your message here",
                                                      border: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5)))),
                                                ),
                                                // subinfo(
                                                //     // "postId": v["id"],
                                                //     spaceId: "spaceId",
                                                //     postId: v["id"]),
                                                Query(
                                                    options: QueryOptions(
                                                        document:
                                                            gql(querysubcom),
                                                        variables: {
                                                          "postId": v["id"]
                                                          // "id": widget.id,
                                                        }),
                                                    builder: (result,
                                                        {fetchMore, refetch}) {
                                                      if (result.isLoading) {
                                                        return const Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                        Color>(
                                                                    Colors
                                                                        .orange),
                                                          ),
                                                        );
                                                      }
                                                      if (result.hasException) {
                                                        return const Text("");
                                                      }
                                                      // print(result.data?["profiles"][0]["facebook"]);
                                                      if (result.data != null) {
                                                        // print(result.data);
                                                        dynamic postsub = result
                                                                    .data![
                                                                "commentsConnection"]
                                                            ["data"];
                                                        print("sub $postsub");
                                                        return Column(
                                                          children: [
                                                            ...postsub.map((s) {
                                                              print(
                                                                  "fgh${result.data}");
                                                              return Card(
                                                                elevation: 0.3,
                                                                child: Column(
                                                                  children: [
                                                                    // TextFormField(
                                                                    //   controller: _Textcontrollersub,
                                                                    //   decoration: InputDecoration(
                                                                    //       suffixIcon: Mutation(
                                                                    //           options: MutationOptions(
                                                                    //             document: gql(mutacreatesub),
                                                                    //             // onCompleted: (dynamic resultData) {
                                                                    //             //   print("$resultData fghj");
                                                                    //             //   Navigator.of(context).pop();
                                                                    //             //   if (result.data != null) {
                                                                    //             //     setState(() {
                                                                    //             //       refetch!();
                                                                    //             //     });
                                                                    //             // }
                                                                    //             // }
                                                                    //             // ,
                                                                    //             onCompleted: (dynamic resultData) {
                                                                    //               print("$resultData vo");

                                                                    //               if (resultData != null) {
                                                                    //                 setState(() {});
                                                                    //                 refetch!();
                                                                    //               }
                                                                    //             },
                                                                    //           ),
                                                                    //           builder: (
                                                                    //             runMutation,
                                                                    //             result,
                                                                    //           ) {
                                                                    //             return IconButton(
                                                                    //                 onPressed: () {
                                                                    //                   setState(() {
                                                                    //                     // _Textcontroller.clear();
                                                                    //                     // _Textcontroller.notifyListeners();
                                                                    //                     postssub.add(
                                                                    //                         _Textcontrollersub.text);
                                                                    //                     runMutation({
                                                                    //                       "input": {
                                                                    //                         "postId": widget.postId,
                                                                    //                         "text": _Textcontrollersub
                                                                    //                             .text
                                                                    //                       }
                                                                    //                     });
                                                                    //                     // runMutation({
                                                                    //                     //   "input": {
                                                                    //                     //     "id": widget.postId,
                                                                    //                     //     "text": _Textcontrollersub.text
                                                                    //                     //   }
                                                                    //                     // });
                                                                    //                     setState(() {
                                                                    //                       refetch!();
                                                                    //                     });
                                                                    //                     _Textcontrollersub.clear();
                                                                    //                   });
                                                                    //                 },
                                                                    //                 icon: Icon(Icons.send_rounded));
                                                                    //           }),
                                                                    //       hintText: "type your message here",
                                                                    //       border: OutlineInputBorder(
                                                                    //           borderRadius: BorderRadius.all(
                                                                    //               Radius.circular(5)))),
                                                                    // ),
                                                                    Row(
                                                                      children: [
                                                                        CircleAvatar(
                                                                          radius:
                                                                              20,
                                                                          backgroundImage:
                                                                              NetworkImage(
                                                                            user?.avatar ??
                                                                                'https://via.placeholder.com/150',
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          user?.firstName ??
                                                                              "",
                                                                          style:
                                                                              TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            fontSize:
                                                                                15,
                                                                          ),
                                                                        ),
                                                                        Spacer(),
                                                                        PopupMenuButton(
                                                                          enabled:
                                                                              true,
                                                                          // Callback that sets the selected popup menu item.
                                                                          position:
                                                                              PopupMenuPosition.under,
                                                                          icon: const Icon(
                                                                              Icons.more_vert,
                                                                              size: 20,
                                                                              color: Colors.black),
                                                                          // shape: const RoundedRectangleBorder(
                                                                          //   borderRadius: BorderRadius.all(
                                                                          //     Radius.circular(5),
                                                                          //   ),
                                                                          // ),
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
                                                                                      style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, elevation: 0),
                                                                                      onPressed: () {
                                                                                        setState(() {
                                                                                          showDialog(
                                                                                            context: context,
                                                                                            builder: (context) {
                                                                                              return AlertDialog(
                                                                                                title: Row(
                                                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                                                  children: [
                                                                                                    Text('Edit Post'),
                                                                                                  ],
                                                                                                ),
                                                                                                actions: [
                                                                                                  Column(
                                                                                                    children: [
                                                                                                      Card(
                                                                                                        color: Colors.white,
                                                                                                        child: Column(
                                                                                                          children: [
                                                                                                            TextFormField(
                                                                                                              controller: _Texteditsubcoment,
                                                                                                              minLines: 2,
                                                                                                              maxLines: 2,
                                                                                                              keyboardType: TextInputType.multiline,
                                                                                                              decoration: InputDecoration(
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
                                                                                                                    style: ButtonStyle(
                                                                                                                      backgroundColor: MaterialStatePropertyAll(Colors.white),
                                                                                                                    ),
                                                                                                                    onPressed: () {
                                                                                                                      Navigator.pop(context);
                                                                                                                    },
                                                                                                                    child: Text('Cancel'),
                                                                                                                  ),
                                                                                                                  SizedBox(
                                                                                                                    width: 10,
                                                                                                                  ),
                                                                                                                  Mutation(
                                                                                                                      options: MutationOptions(document: gql(mutaupdatesub)),
                                                                                                                      builder: (runMutation, result) {
                                                                                                                        print("${result?.data} poi");
                                                                                                                        return ElevatedButton(
                                                                                                                          onPressed: () {
                                                                                                                            setState(() {
                                                                                                                              // posts[index] = text;
                                                                                                                              runMutation({
                                                                                                                                "id": s["id"],
                                                                                                                                "input": {
                                                                                                                                  "postId": v["id"],
                                                                                                                                  "text": _Texteditsubcoment.text,
                                                                                                                                },
                                                                                                                              });
                                                                                                                            });
                                                                                                                            refetch!();
                                                                                                                            Navigator.pop(context);
                                                                                                                            _Texteditsubcoment.clear();
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
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        children: const [
                                                                                          Icon(
                                                                                            Icons.edit,
                                                                                            color: Colors.red,
                                                                                          ),
                                                                                          Text(
                                                                                            "Edit",
                                                                                            textAlign: TextAlign.start,
                                                                                            style: TextStyle(
                                                                                              color: Colors.red,
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    Mutation(
                                                                                        options: MutationOptions(
                                                                                          document: gql(mutadeletesub),
                                                                                          onCompleted: (dynamic resultData) {
                                                                                            print("$resultData delet");

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
                                                                                          return Column(
                                                                                            children: [
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
                                                                                                              setState(() {
                                                                                                                runMutation({"id": s["id"]});
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
                                                                                              )
                                                                                            ],
                                                                                          );
                                                                                        }),
                                                                                  ],
                                                                                ))
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Text(s["message"] ??
                                                                              ""),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            })
                                                          ],
                                                        );
                                                      }
                                                      return Container();
                                                    }),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    })
                                  ],
                                );
                              }),
                        ],
                      );
                      //   }
                      //   return Container();
                      // });
                    }
                    return Container();
                  });
            }),
      ),
    );
  }
}
