import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:padeprokan/components/organisms/appBar/appbar_widget.dart';
import 'package:padeprokan/blocs/streams/chat_stream.dart';
import 'package:padeprokan/components/organisms/chat/chat_tree.dart';
import 'package:padeprokan/components/utils/model/chat/space_message_model.dart';
import 'package:padeprokan/components/utils/model/myuser/user_sharedpref.dart';
import 'package:padeprokan/graphql/groupChat.dart/group_chat.dart';
import 'package:padeprokan/graphql/groupChat.dart/group_chat_subscription.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatIndexView extends StatefulWidget {
  final String spaceId;
  const ChatIndexView({super.key, required this.spaceId});

  @override
  State<ChatIndexView> createState() => _ChatIndexViewState();
}

class _ChatIndexViewState extends State<ChatIndexView> {
  ChatStream chatStream = ChatStream();
  ScrollController listViewController = ScrollController();
  int totalMessage = 0;
  Function? refetchChat;

  TextEditingController textMessage = TextEditingController();

  @override
  void initState() {
    super.initState();
    listViewController = ScrollController()
      ..addListener(() {
        if (listViewController.position.maxScrollExtent ==
            listViewController.position.pixels) {}
      });
  }

  @override
  void dispose() {
    chatStream.closeStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void scrollToBottom() {
      listViewController.animateTo(
        0.0,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
    }

    return Scaffold(
        appBar: appBarWidget(context, "Group Chat"),
        body: ChangeNotifierProvider(
            create: (context) => _ModelChat(),
            child: Consumer<_ModelChat>(builder: (context, modelChat, _) {
              return Query(
                options: QueryOptions(
                    document: gql(getSpaceChats),
                    fetchPolicy: FetchPolicy.noCache,
                    variables: {
                      "spaceId": widget.spaceId,
                      "limit": 50,
                      "skip": modelChat._totalMessage
                    }),
                builder: (result, {fetchMore, refetch}) {
                  refetchChat = refetch;
                  if (result.hasException) {}
                  // print("${result.data} 000");
                  if (result.data != null) {
                    // chatStream.
                    chatStream
                        .fetchMore(result.data!["messagesConnection"]["data"]!);
                  }
                  // refetchChat = refetch;

                  return FutureBuilder<GetUserData>(
                      future: getUserDataFromJson(),
                      builder: (context, snapshot) {
                        GetUserData? user = snapshot.data;
                        return Padding(
                          padding: const EdgeInsets.all(0),
                          child: Container(
                            color: Colors.blue.withOpacity(0.1),
                            child: Column(
                              children: [
                                StreamBuilder<List<SpaceMessageModel>>(
                                  stream: chatStream.messageStream,
                                  builder: (context, snapshot) {
                                    if (snapshot.data != null) {
                                      // print("aaiio ${snapshot.data![49].text} ");
                                      List<SpaceMessageModel> data =
                                          snapshot.data!.toList();

                                      totalMessage == data.length;
                                      // Future.delayed(Duration.zero, () async {
                                      // modelChat
                                      //     .changeTotalMessage(data.length);
                                      // });
                                      // List<SpaceMessageModel> dataResult = data
                                      //     .map((item) => jsonEncode(item))
                                      //     .toList()
                                      //     .toSet()
                                      //     .toList()
                                      //     .map<SpaceMessageModel>((item) =>
                                      //         spaceMessageModelFromJson(item))
                                      //     .toList();
                                      // data.sort((m1, m2) => m2.createdAt
                                      //     .toString()
                                      //     .compareTo(m1.createdAt.toString()));
                                      // setState(() {
                                      //   totalMessage = data.length;
                                      // });
                                      // print("000 0 ${dataResult.map<SpaceMessageModel>((e) => e.)}");

                                      // print("${dataResult[0].text} asdaa");
                                      return Expanded(
                                        flex: 1,
                                        child: ListView(
                                          padding:
                                              const EdgeInsets.only(bottom: 20),
                                          controller: listViewController,
                                          reverse: true,
                                          shrinkWrap: true,
                                          // children: [
                                          //   if (snapshot.data!.isNotEmpty) ...[
                                          //     ...snapshot.data!.reversed.map((i) {
                                          //       return ElevatedButton(
                                          //           onPressed: () {
                                          //             print(i);
                                          //             chatStream.fetchMore(
                                          //                 result.data!["messagesConnection"]
                                          //                     ["data"]!);

                                          //             // chatStream.testur(1);
                                          //           },
                                          //           child: Text(i["text"].toString()));
                                          //     })
                                          //   ]

                                          children: [
                                            ...List.generate(
                                              data.length,
                                              (index) {
                                                return Column(children: [
                                                  ChatTree(
                                                    data: data[index],
                                                    userId: user!.id,
                                                  )
                                                ]);
                                              },
                                            ),
                                            if (result.data != null) ...[
                                              result
                                                          .data![
                                                              "messagesConnection"]
                                                              ["data"]!
                                                          .length ==
                                                      50
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        TextButton(
                                                            onPressed: () {
                                                              modelChat
                                                                  .changeTotalMessage(
                                                                      modelChat
                                                                              .totalMessage +
                                                                          50);
                                                            },
                                                            child: const Text(
                                                                "Load More")),
                                                      ],
                                                    )
                                                  : Container(),
                                            ],
                                          ],

                                          // ]
                                        ),
                                      );
                                    }
                                    return Expanded(
                                      flex: 1,
                                      child: Container(),
                                    );
                                  },
                                ),
                                // const ChatTree(),
                                Subscription(
                                    onSubscriptionResult:
                                        (subscriptionResult, client) {},
                                    options: SubscriptionOptions(
                                        document: gql(messageAdded),
                                        variables: {
                                          "spaceId": widget.spaceId,
                                        }),
                                    builder: (result) {
                                      if (result.hasException) {
                                        // return Text(
                                        //     result.exception.toString());
                                      }

                                      // if (result.isLoading) {
                                      //   return const Center(
                                      //     child: CircularProgressIndicator(),
                                      //   );
                                      // }
                                      if (result.data != null) {
                                        chatStream.fetchMessageAdded(
                                            result.data!["messageAdded"]);
                                        scrollToBottom();
                                      }
                                      // print("${result.data!["messageAdded"]} sfdsfdf");
                                      // ResultAccumulator is a provided helper widget for collating subscription results.
                                      // careful though! It is stateful and will discard your results if the state is disposed
                                      return ResultAccumulator
                                          .appendUniqueEntries(
                                              latest: result.data,
                                              builder: (context, {results}) {
                                                return Container();
                                              });
                                    }),
                                SizedBox(
                                  height: 60,
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade200,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 12),
                                              child: TextField(
                                                cursorColor: Colors.black,
                                                controller: textMessage,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText:
                                                      "Type your message  here",
                                                  fillColor:
                                                      Colors.grey.shade200,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 30),
                                        Mutation(
                                          options: MutationOptions(
                                              document: gql(sendMessage)),
                                          builder: (runMutation, result) {
                                            return Container(
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.purple,
                                              ),
                                              child: IconButton(
                                                highlightColor: Colors.purple,
                                                color: Colors.purple,
                                                onPressed: () {
                                                  if (textMessage.text.trim() ==
                                                      "") {
                                                  } else {
                                                    runMutation({
                                                      "text": textMessage.text
                                                          .trim(),
                                                      "MessageType": "text",
                                                      "parentMessage": null,
                                                      "spaceId": widget.spaceId
                                                    });
                                                    textMessage.text = "";
                                                    scrollToBottom();
                                                  }
                                                },
                                                icon: const Icon(
                                                  FontAwesomeIcons
                                                      .solidPaperPlane,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            );
                                          },
                                        )

                                        // Container(
                                        //   padding: const EdgeInsets.only(right: 5),
                                        //   height: 40,
                                        //   width: 40,
                                        // decoration: const BoxDecoration(
                                        //   shape: BoxShape.circle,
                                        //   color: Colors.purple,
                                        // ),
                                        //   child: const Icon(
                                        //     FontAwesomeIcons.solidPaperPlane,
                                        //     color: Colors.white,
                                        //     size: 20,
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      });
                },
              );
            })));
  }
}

class _ModelChat extends ChangeNotifier {
  int _totalMessage = 0;

  int get totalMessage => _totalMessage;

  void changeTotalMessage(int total) {
    _totalMessage = total;
    notifyListeners();
  }
}
