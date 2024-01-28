import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:padeprokan/components/atoms/avatar/mini_avatar.dart';
import 'package:padeprokan/components/utils/model/spaces/spaces.dart';
import 'package:padeprokan/graphql/spaces/delete_space.dart';
import 'package:padeprokan/views/space/space_index_view.dart';
import 'dart:math' as math;
import 'package:padeprokan/components/utils/genColor.dart';

class SpaceCard extends StatefulWidget {
  final SpacesModel space;
  final String userId;
  final dynamic refetchSpaces;
  const SpaceCard(
      {Key? key,
      required this.space,
      required this.userId,
      required this.refetchSpaces})
      : super(key: key);

  @override
  State<SpaceCard> createState() => _SpaceCardState();
}

class _SpaceCardState extends State<SpaceCard> {
  final rnd = math.Random();

  Color getRandomColor() => Color(rnd.nextInt(0xffffffff));
  @override
  Widget build(BuildContext context) {
    // dynamic hashCode(String str) {
    //   // print(str);
    //   var hash = 02343;
    //   print("${0.is}asaa");
    //   for (int i = 0; i < 24; i++) {
    //     // print(i);
    //     if(hash.leng)
    //     hash = str.codeUnitAt(i) - ((hash << 5) - hash);
    //   }
    //   // print("${hash}as");
    //   // hash = str.codeUnitAt(1) + ((hash << 5) - hash);
    //   // print("${str.codeUnitAt(1) + ((hash << 5) - hash)}akakak");
    //   // print("${((hash << 5) - hash)}as");
    //   return hash;
    // }

    // dynamic intToRGB(i) {
    //   var c = (i & 0x00ffffff).toString(16).toUpperCase();

    //   return "00000".substring;
    // }

    // dynamic randomColor() {
    //   // var hex = intToRGB(hashCode(widget.spacesList[0].id));
    //   // return `#${hex}`;
    //   print(hashCode(widget.spacesList[0].id));
    //   print(widget.spacesList[0].name);
    // }

    // print(randomColor());
    // print("${'ksk'.codeUnitAt(0)}ask");

    // print(widget.userId == space.createdBy.toString());
    // print(space.createdBy.id);
    return Stack(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              // List<SpaceStudentsModel> spaceStudentsModel = space.students.map((v) => spaceStudentsModelFromJson(json.encode(v))).toList();
              return SpaceIndexView(
                widget.space.spaceMenu, widget.space.id,
                widget.space.name,
                // space.idCourse,
                //space.createdBy.id
              );
            }));
          },
          child: Ink(
            child: Container(
              clipBehavior: Clip.hardEdge,
              // padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 1,
                      offset: Offset(1, 1), // Shadow position
                    ),
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: double.infinity,
                      color: genColor(widget.space.id),
                    ),
                  ),
                  // Row(
                  //   children: const [
                  //     Text(
                  //       "dattgt ytyt yty tyt yty yt yty a",
                  //       softWrap: false,
                  //       style: TextStyle(
                  //         fontSize: 20,
                  //         overflow: TextOverflow.fade,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: Text(
                      widget.space.name.toString(),
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 20,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    dragStartBehavior: DragStartBehavior.start,
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: widget.space.students
                              .map(
                                (user) => Padding(
                                  padding: const EdgeInsets.only(right: 2),
                                  child: Column(
                                    children: [
                                      // ClipOval(
                                      //   child: user.user.avatar !=
                                      //               null &&
                                      //           user.user.avatar != ""
                                      //       ? CachedNetworkImage(
                                      //           fit: BoxFit.cover,
                                      //           imageUrl: user
                                      //                   .user.avatar ??
                                      //               'https://via.placeholder.com/150',
                                      //           width: 40.0,
                                      //           height: 40.0,
                                      //         )
                                      //       : const Text("data"),
                                      // )
                                      miniAvatar(
                                          firstName:
                                              user.user.firstName.toString(),
                                          avatarUrl: user.user.avatar,
                                          id: user.user.id),
                                    ],
                                  ),
                                ),
                              )
                              .toList()),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        widget.userId == widget.space.createdBy.id.toString()
            ? Positioned(
                right: 0,
                top: 0,
                child: Container(
                  // color: Colors.red,
                  // width: 100.0,
                  // height: 80.0,
                  child: PopupMenuButton(
                    enabled: true,
                    // Callback that sets the selected popup menu item.
                    position: PopupMenuPosition.under,
                    icon: const Icon(Icons.more_vert, color: Colors.white),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    elevation: 1,
                    itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                      PopupMenuItem(
                          padding: EdgeInsets.zero,
                          value: "delete",
                          child: Mutation(
                              options: MutationOptions(
                                document: gql(deleteSpace),
                                onCompleted: (dynamic resultData) {
                                  print("$resultData ------");
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  if (resultData != null) {
                                    setState(() {
                                      widget.refetchSpaces();
                                    });
                                  }
                                },
                              ),
                              builder: (
                                runMutation,
                                result,
                              ) {
                                return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      elevation: 0),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          actionsAlignment:
                                              MainAxisAlignment.end,
                                          actions: [
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    elevation: 0),
                                                child: const Text(
                                                  "Cancel",
                                                )),
                                            ElevatedButton(
                                              onPressed: () {
                                                // print("object");
                                                runMutation({
                                                  "spaceId": widget.space.id
                                                });
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  elevation: 0),
                                              child: const Text(
                                                "Delete",
                                                style: TextStyle(
                                                  color: Colors.red,
                                                ),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                );
                              }))
                    ],
                  ),
                ))
            : Container(),
      ],
    );
  }
}
