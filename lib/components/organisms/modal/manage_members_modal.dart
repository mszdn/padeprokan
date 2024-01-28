import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:padeprokan/components/atoms/avatar/mini_avatar.dart';
import 'package:padeprokan/components/utils/model/myuser/user_sharedpref.dart';
import 'package:padeprokan/components/utils/model/students/manage_members.dart';
import 'package:padeprokan/graphql/space/space_members.dart';

Future<void> manageMembers(BuildContext context, String spaceId) {
  TextEditingController searchUsers = TextEditingController();
  int limit = 1;
  bool isSearch = false;
  dynamic refetchMember;

  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text(
        "Manage Member",
        style: TextStyle(
          fontSize: 16,
        ),
      ),
      content: StatefulBuilder(
        builder: (context, setState) => FutureBuilder<GetUserData>(
            future: getUserDataFromJson(),
            builder: (context, snapshot) {
              // print(snapshot.data);
              GetUserData? user = snapshot.data;

              return SizedBox(
                width: 400,
                height: MediaQuery.of(context).size.height * 0.8,
                child: Column(
                  children: [
                    Flexible(
                      child: SingleChildScrollView(
                        child: Query(
                          options: QueryOptions(
                              document: gql(getSpaceMembers),
                              variables: {"id": spaceId}),
                          builder: (result, {fetchMore, refetch}) {
                            refetchMember = refetch;
                            if (result.hasException) {
                              return const Text("error");
                            }
                            if (result.isLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (result.data != null) {
                              List<SpaceStudentsModel> spaceStudentsModel =
                                  result.data?["space"]?["students"]
                                      .map<SpaceStudentsModel>((v) =>
                                          spaceStudentsModelFromJson(
                                              json.encode(v)))
                                      .toList();

                              // print("${spaceStudentsModel.length.toString()} as");
                              // print(result.data?["space"]);
                              return Column(
                                children: [
                                  result.data?["space"]["createdBy"]["id"] !=
                                              null &&
                                          result.data?["space"]["createdBy"]
                                                  ["id"] ==
                                              user?.id
                                      ? Query(
                                          options: QueryOptions(
                                              document: gql(getSearchUsers),
                                              variables: {
                                                "where": {
                                                  "studentId_not": null,
                                                  "firstName_contains":
                                                      searchUsers.text
                                                },
                                                "skip": 0,
                                                "limit": limit
                                              }),
                                          builder: (result,
                                              {fetchMore, refetch}) {
                                            if (result.hasException) {
                                              return const Text("eror");
                                            }
                                            // if (result.isLoading) {
                                            //   return const Center(
                                            //     child:
                                            //         CircularProgressIndicator(),
                                            //   );
                                            // }
                                            return Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Flexible(
                                                      child: SizedBox(
                                                        height: 40,
                                                        child: TextFormField(
                                                          controller:
                                                              searchUsers,
                                                          cursorColor:
                                                              Colors.black,
                                                          decoration:
                                                              InputDecoration(
                                                            fillColor: const Color
                                                                    .fromRGBO(
                                                                173,
                                                                120,
                                                                211,
                                                                1),
                                                            hintStyle:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 14,
                                                            ),
                                                            hintText:
                                                                "Search Users Name",
                                                            border:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              borderSide:
                                                                  const BorderSide(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        173,
                                                                        120,
                                                                        211,
                                                                        1),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    SizedBox(
                                                      height: 40,
                                                      child: ElevatedButton(
                                                          child: const Text(
                                                            "Search",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          onPressed: () {
                                                            setState(() {
                                                              refetch;
                                                              limit = 3;
                                                              isSearch = true;
                                                            });
                                                          }),
                                                    )
                                                  ],
                                                ),
                                                if (result.data != null &&
                                                    result
                                                            .data?[
                                                                "usersConnection"]
                                                                ?["data"]
                                                            .length !=
                                                        0 &&
                                                    isSearch == true) ...[
                                                  Builder(
                                                    builder: (context) {
                                                      List<SpaceStudentsModelSearch>
                                                          spaceStudentsModelSearch =
                                                          result.data?[
                                                                  "usersConnection"]
                                                                  ?["data"]
                                                              .map<SpaceStudentsModelSearch>((v) =>
                                                                  spaceStudentsModelSearchFromJson(
                                                                      json.encode(
                                                                          v)))
                                                              .toList();

                                                      return Column(
                                                        children:
                                                            spaceStudentsModelSearch
                                                                .map(
                                                                  (studentSearch) =>
                                                                      Mutation(
                                                                    options:
                                                                        MutationOptions(
                                                                      document:
                                                                          gql(addMemberstoSpace),
                                                                      onCompleted:
                                                                          (dynamic
                                                                              resultData) {
                                                                        if (resultData !=
                                                                            null) {
                                                                          setState(
                                                                              () {
                                                                            refetchMember();
                                                                          });
                                                                        } else {
                                                                        }
                                                                      },
                                                                    ),
                                                                    builder: (
                                                                      runMutation,
                                                                      result,
                                                                    ) {
                                                                      return Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(5),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Flexible(
                                                                              child: Row(
                                                                                children: [
                                                                                  miniAvatar(avatarUrl: studentSearch.avatar, firstName: studentSearch.firstName, id: studentSearch.id),
                                                                                  Flexible(
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.only(left: 10),
                                                                                      child: Text(
                                                                                        studentSearch.firstName.toString(),
                                                                                        textAlign: TextAlign.left,
                                                                                        overflow: TextOverflow.ellipsis,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            IconButton(
                                                                                onPressed: () {
                                                                                  runMutation({
                                                                                    "studentId": studentSearch.studentId,
                                                                                    "spaceId": spaceId
                                                                                  });
                                                                                },
                                                                                icon: const Icon(
                                                                                  Icons.add,
                                                                                  color: Colors.blue,
                                                                                ))
                                                                          ],
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                                )
                                                                .toList(),
                                                      );
                                                    },
                                                  )
                                                ]
                                              ],
                                            );
                                          },
                                        )
                                      : Container(),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "List Members (${spaceStudentsModel.length.toString()} people)",
                                        style: const TextStyle(
                                            color: Colors.grey, fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Column(
                                    children: spaceStudentsModel
                                        .map(
                                          (student) => Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Flexible(
                                                  child: Row(
                                                    children: [
                                                      miniAvatar(
                                                          avatarUrl: student
                                                              .user.avatar,
                                                          firstName: student
                                                              .user.firstName,
                                                          id: student.id),
                                                      Flexible(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10),
                                                          child: Text(
                                                            student
                                                                .user.firstName
                                                                .toString(),
                                                            textAlign:
                                                                TextAlign.left,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                result.data?["space"][
                                                                    "createdBy"]
                                                                ["id"] !=
                                                            null &&
                                                        result.data?["space"][
                                                                    "createdBy"]
                                                                ["id"] ==
                                                            student.user.id
                                                    ? const Text(
                                                        "Admin",
                                                        style: TextStyle(
                                                            color: Colors.grey),
                                                      )
                                                    : Mutation(
                                                        options:
                                                            MutationOptions(
                                                          document: gql(
                                                              removeMemberstoSpace),
                                                          onCompleted: (dynamic
                                                              resultData) {
                                                            if (resultData !=
                                                                null) {
                                                              setState(() {
                                                                refetchMember();
                                                              });
                                                            } else {
                                                            }
                                                          },
                                                        ),
                                                        builder: (
                                                          runMutation,
                                                          result,
                                                        ) {
                                                          return IconButton(
                                                              onPressed: () {
                                                                runMutation({
                                                                  "studentId":
                                                                      student
                                                                          .id,
                                                                  "spaceId":
                                                                      spaceId
                                                                });
                                                              },
                                                              icon: const Icon(
                                                                Icons.delete,
                                                                color:
                                                                    Colors.red,
                                                              ));
                                                        })
                                              ],
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  )

                                  // Padding(
                                  //   padding: const EdgeInsets.only(top: 10),
                                  //   child: Row(
                                  //     children: [
                                  //       Row(
                                  //         children: [
                                  //           SizedBox(
                                  //             width: 136,
                                  //             child: OutlinedButton.icon(
                                  //               style: OutlinedButton.styleFrom(
                                  //                   side: const BorderSide(
                                  //                       color: Colors.transparent)),
                                  //               onPressed: () {},
                                  //               icon: const Icon(
                                  //                 Icons.delete_outlined,
                                  //                 size: 20,
                                  //                 color: Colors.red,
                                  //               ),
                                  //               label: const Text(
                                  //                 'Delete Space',
                                  //                 style: TextStyle(fontSize: 14, color: Colors.red),
                                  //               ),
                                  //             ),
                                  //           ),
                                  //           Column(
                                  //             children: [
                                  //               SizedBox(
                                  //                 width: 120,
                                  //                 child: OutlinedButton.icon(
                                  //                   style: OutlinedButton.styleFrom(
                                  //                       side: const BorderSide(
                                  //                           color: Color.fromARGB(0, 248, 34, 34))),
                                  //                   onPressed: () {},
                                  //                   icon: const Icon(
                                  //                     Icons.link_outlined,
                                  //                     size: 20,
                                  //                     color: Colors.purple,
                                  //                   ),
                                  //                   label: const Text(
                                  //                     'Copy link',
                                  //                     style: TextStyle(
                                  //                         fontSize: 14, color: Colors.purple),
                                  //                   ), // <-- Text
                                  //                 ),
                                  //               ),
                                  //             ],
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                ],
                              );
                            }
                            return Container();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    ),
  );
}

Text removeMember() {
  return const Text(
    "Remove",
    style: TextStyle(color: Colors.white),
  );
}
