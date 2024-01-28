import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
import 'package:padeprokan/components/organisms/appBar/appbar_widget.dart';
import 'package:padeprokan/components/utils/genColor.dart';
import 'package:padeprokan/components/utils/model/myuser/user_sharedpref.dart';
import 'package:padeprokan/graphql/conference/activeConferences.dart';
import 'package:padeprokan/url.dart';
import 'package:padeprokan/components/utils/formatDate.dart';

// import 'package:jitsi_meet/jitsi_meet.dart';
// import 'package:padeprokan/views/space/features/conference/testing_conference.dart';

class ConferencePage extends StatefulWidget {
  final String spaceId;
  const ConferencePage({super.key, required this.spaceId});

  @override
  State<ConferencePage> createState() => _ConferencePageState();
}

class _ConferencePageState extends State<ConferencePage> {
  _joinConference(
      {required String roomName,
      required String id,
      String? firstName,
      required String email,
      String? userAvatar}) async {
    Map<FeatureFlag, Object> featureFlags = {};

    var option = JitsiMeetingOptions(
        serverUrl: urlConferenceJitsi,
        roomNameOrUrl: "${roomName}_$id",
        featureFlags: featureFlags,
        isAudioMuted: true,
        isVideoMuted: true,
        userAvatarUrl: userAvatar,
        userDisplayName: firstName ?? "Omnyangkopon",
        userEmail: email);
    debugPrint("JitsiMeetingOptions: $option");
    await JitsiMeetWrapper.joinMeeting(
      options: option,
      listener: JitsiMeetingListener(
        onOpened: () => debugPrint("onOpened"),
        onConferenceWillJoin: (url) {
          debugPrint("onConferenceWillJoin: url: $url");
        },
        onConferenceJoined: (url) {
          debugPrint("onConferenceJoined: url: $url");
        },
        onConferenceTerminated: (url, error) {
          debugPrint("onConferenceTerminated: url: $url, error: $error");
        },
        onAudioMutedChanged: (isMuted) {
          debugPrint("onAudioMutedChanged: isMuted: $isMuted");
        },
        onVideoMutedChanged: (isMuted) {
          debugPrint("onVideoMutedChanged: isMuted: $isMuted");
        },
        onScreenShareToggled: (participantId, isSharing) {
          debugPrint(
            "onScreenShareToggled: participantId: $participantId, "
            "isSharing: $isSharing",
          );
        },
        onParticipantJoined: (email, name, role, participantId) {
          debugPrint(
            "onParticipantJoined: email: $email, name: $name, role: $role, "
            "participantId: $participantId",
          );
        },
        onParticipantLeft: (participantId) {
          debugPrint("onParticipantLeft: participantId: $participantId");
        },
        onParticipantsInfoRetrieved: (participantsInfo, requestId) {
          debugPrint(
            "onParticipantsInfoRetrieved: participantsInfo: $participantsInfo, "
            "requestId: $requestId",
          );
        },
        onChatMessageReceived: (senderId, message, isPrivate) {
          debugPrint(
            "onChatMessageReceived: senderId: $senderId, message: $message, "
            "isPrivate: $isPrivate",
          );
        },
        onChatToggled: (isOpen) => debugPrint("onChatToggled: isOpen: $isOpen"),
        onClosed: () => debugPrint("onClosed"),
      ),
    );
  }

  // _joinMeeting() async {
  //   try {
  //   FeatureFlag featureFlag = FeatureFlag();
  //   featureFlag.welcomePageEnabled = false;
  //   featureFlag.resolution = FeatureFlagVideoResolution.MD_RESOLUTION; // Limit video resolution to 360p

  //     var options = JitsiMeetingOptions()
  //       room = "myroom" // Required, spaces will be trimmed
  //       serverURL = "https://someHost.com"
  //       subject = "Meeting with Gunschu"
  //       userDisplayName = "My Name"
  //       userEmail = "myemail@email.com"
  //       userAvatarURL = "https://someimageurl.com/image.jpg" // or .png
  //       audioOnly = true
  //       audioMuted = true
  //        = true
  //       featureFlag = featureFlag;

  //     await JitsiMeet.joinMeeting(options);
  //   } catch (error) {
  //     debugPrint("error: $error");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBarWidget(context, "Conference"),
        body: Column(
          children: [
            FutureBuilder<GetUserData>(
                future: getUserDataFromJson(),
                builder: (context, snapshot) {
                  GetUserData? user = snapshot.data;
                  return Flexible(
                    child: Column(
                      children: [
                        if (user != null) ...[
                          Query(
                            options: QueryOptions(
                                document: gql(getActiveConferences),
                                variables: {"idSpace": widget.spaceId}),
                            builder: (result, {fetchMore, refetch}) {
                              // print(
                              //     "---- ${DateTime.parse('1974-03-20 00:00:00.000')}");

                              if (result.hasException) {
                                return const Text("error");
                              }
                              if (result.isLoading) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              if (result.data != null &&
                                  result.data!["conferences"].length > 0) {
                                print("WWW ${result.data!["conferences"]}");
                                dynamic conference =
                                    result.data!["conferences"];
                                return SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      ...conference.map((v) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.25,
                                            color: genColor(v["id"]),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 20, 10, 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        "Room Name:",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        v["name"] +
                                                            "_" +
                                                            v["id"],
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        "Created: ${formatDate(date: v["createdAt"])}",
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      TextButton(
                                                          style: TextButton.styleFrom(
                                                              foregroundColor:
                                                                  Colors.white,
                                                              backgroundColor:
                                                                  const Color(
                                                                      0xffb20bf6b)),
                                                          onPressed: () {
                                                            _joinConference(
                                                                roomName:
                                                                    v["name"],
                                                                id: v["id"],
                                                                email:
                                                                    user.email,
                                                                firstName:
                                                                    user.email,
                                                                userAvatar: user
                                                                    .avatar);
                                                          },
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: const [
                                                              Text(
                                                                  "Join Conference"),
                                                            ],
                                                          )),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      })
                                      // ElevatedButton(
                                      //     onPressed: () {
                                      //       // dynamic join =
                                      //       //     result.data!["conferences"][0];
                                      //       // _joinConference(
                                      //       //     "${join["name"]}_${join["id"]}");
                                      //     },
                                      //     child: const Text("Joind")),
                                    ],
                                  ),
                                );
                              }

                              return SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.7,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "There's no available conference!",
                                      style: TextStyle(fontSize: 30),
                                      textAlign: TextAlign.center,
                                    ),
                                    Container(
                                      child: Center(
                                        child: TextButton(
                                            onPressed: () {
                                              refetch!();
                                            },
                                            child: const Text("Reload")),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          )
                        ]
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                        //   child: Card(
                        //     color: ColorStyle().scaffoldcolor,
                        //     child: Column(children: [
                        //       Padding(
                        //         padding: const EdgeInsets.all(8.0),
                        //         child: Align(
                        //             alignment: Alignment.topLeft,
                        //             child: Text(
                        //               'Create New Conference',
                        //               style: TextStyle(
                        //                 fontSize: 16,
                        //                 fontWeight: FontWeight.w400,
                        //               ),
                        //             )),
                        //       ),
                        //       Divider(
                        //         thickness: 1.5,
                        //       ),
                        //       SizedBox(
                        //         height: 10,
                        //       ),
                        //       Padding(
                        //         padding: const EdgeInsets.all(8.0),
                        //         child: Align(
                        //           alignment: Alignment.topLeft,
                        //           child: Text(
                        //             'Conference Name',
                        //             style: TextStyle(
                        //               fontSize: 12,
                        //               fontWeight: FontWeight.w400,
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //       Padding(
                        //         padding:
                        //             const EdgeInsets.only(left: 10, right: 10, bottom: 20),
                        //         child: TextFormField(
                        //           controller: roomNameOrURL,
                        //           keyboardType: TextInputType.text,
                        //           cursorColor: Colors.black,
                        //           decoration: new InputDecoration(
                        //               hintText: 'Enter the name of conference',
                        //               border: OutlineInputBorder(
                        //                   borderRadius: BorderRadius.circular(5.0))),
                        //         ),
                        //       ),
                        //       Padding(
                        //         padding: const EdgeInsets.only(right: 10),
                        //         child: Align(
                        //           alignment: Alignment.topRight,
                        //           child: ElevatedButton(
                        //             style: ElevatedButton.styleFrom(
                        //               backgroundColor: ColorStyle().PurpleButton,
                        //             ),
                        //             onPressed: () {
                        //               // Navigator.push(
                        //               //     context,
                        //               //     MaterialPageRoute(
                        //               //         builder: (BuildContext context) =>
                        //               //             Meeting()));
                        //               _joinConference();
                        //             },
                        //             child: Text(
                        //               'Create',
                        //               style: TextStyle(
                        //                 color: Colors.white,
                        //                 fontWeight: FontWeight.w500,
                        //                 fontSize: 13,
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     ]),
                        //     elevation: 2,
                        //   ),
                        // )
                      ],
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
