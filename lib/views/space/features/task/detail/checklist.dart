import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:padeprokan/components/utils/model/myuser/user_sharedpref.dart';
import 'package:padeprokan/graphql/tasks/cecklist.dart';
import 'package:padeprokan/graphql/tasks/get_workspace_boards.dart';

class Checklist extends StatefulWidget {
  final String id;
  Checklist({
    super.key,
    required this.id,
  });

  @override
  State<Checklist> createState() => _ChecklistState();
}

class _ChecklistState extends State<Checklist> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<GetUserData>(
      future: getUserDataFromJson(),
      builder: (context, snapshot) {
        GetUserData? user = snapshot.data;
        return Query(
          options: QueryOptions(
              document: gql(getDetailTasks), variables: {"id": widget.id}),
          builder: (result, {fetchMore, refetch}) {
            if (result.isLoading) {
              Text("loading");
            }
            if (result.hasException) {
              Text("error");
            }
            if (result.data != null) {
              print("uhuh $result");
              dynamic checklist = result.data?["card"]?["checklists"];
              return Column(
                children: [
                  ...checklist.map((c) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.check_box_outlined),
                            Text(c["name"] ?? ""),
                            Spacer(),
                            IconButton(
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
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.black26,
                                                  elevation: 0),
                                              child: const Text(
                                                "Cancel",
                                              )),
                                          Mutation(
                                              options: MutationOptions(
                                                  document:
                                                      gql(deleteChecklist)),
                                              builder: (runMutation, result) {
                                                return ElevatedButton(
                                                  onPressed: () {
                                                    setState(() {});
                                                    runMutation({
                                                      "id": c["id"],
                                                    });
                                                    refetch!();
                                                    Navigator.pop(context);
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.red,
                                                          elevation: 0),
                                                  child: Column(
                                                    children: [
                                                      const Text(
                                                        "Delete",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              })
                                        ],
                                        content: SizedBox(
                                          height: 57,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Center(
                                                child: Text(
                                                  "Delete Checklist",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Text(
                                                "Deleting an checklist is permanent. There is no undo.",
                                                maxLines: 2,
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                icon: Icon(Icons.delete_outline_outlined)),
                          ],
                        ),
                        ...c["listChecklists"].map((v) {
                          return Column(
                            children: [
                              CheckboxListTile(
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  title: Text(v["title"] ?? ""),
                                  value: timeDilation != 1.0,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      timeDilation = value! ? 1.5 : 1.0;
                                    });
                                  },
                                  secondary: Mutation(
                                      options: MutationOptions(
                                          document: gql(deleteListChecklist)),
                                      builder: (runMutation, result) {
                                        return IconButton(
                                            onPressed: () {
                                              runMutation({"id": v["id"]});
                                              refetch!();
                                            },
                                            icon: Icon(
                                              Icons.delete_outline_rounded,
                                              color: Colors.red,
                                            ));
                                      })),
                            ],
                          );
                        }),
                      ],
                    );
                  })
                ],
              );
            }
            return Container();
          },
        );
      },
    );
  }
}
