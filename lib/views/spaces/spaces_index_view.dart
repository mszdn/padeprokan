import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:padeprokan/blocs/login_bloc.dart';
import 'package:padeprokan/components/organisms/another_spaces/space_card.dart';
import 'package:padeprokan/components/organisms/appBar/appbar_widget.dart';
import 'package:padeprokan/components/utils/model/myuser/user_sharedpref.dart';
import 'package:padeprokan/components/utils/model/spaces/spaces.dart';
import 'package:padeprokan/components/utils/theme_colors.dart';
import 'package:padeprokan/graphql/auth/myuser.dart';
import 'package:padeprokan/graphql/spaces/get_spaces.dart';
import 'package:padeprokan/url.dart';
import 'package:padeprokan/views/profile/profilview.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth/login_view.dart';

class SpacesIndexView extends StatefulWidget {
  const SpacesIndexView({Key? key}) : super(key: key);

  @override
  State<SpacesIndexView> createState() => _SpacesIndexViewState();
}

class _SpacesIndexViewState extends State<SpacesIndexView> {
  TextEditingController searchControler = TextEditingController();
  FocusNode searchFocus = FocusNode();
  @override
  void dispose() {
    searchControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    LoginBloc loginBloc = BlocProvider.of<LoginBloc>(context);
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    List<SpacesModel> spacesList = [];

    dynamic refetchSpaces;

    final RefreshController refreshController =
        RefreshController(initialRefresh: false);

    int spacesLimit = 20;
    int spacesSkip = 0;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Center(child: Text('Spaces')),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.person),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => profilview()));
                      },
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.red,
                            radius: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Query(
                              options: QueryOptions(
                                document: gql(simpleMyUser),
                              ),
                              builder: (result, {fetchMore, refetch}) {
                                return Text(
                                    "${result.data?['user']['firstName']}"
                                        .toString());
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      onPressed: () async {
                        final sharedPref =
                            await SharedPreferences.getInstance();
                        sharedPref.remove("token");
                        loginBloc.generateToken("");
                        // print("object");
                        Timer(
                            const Duration(milliseconds: 500),
                            () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginView())));
                      },
                      child: const Text(
                        "Logout",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          searchFocus.unfocus();
          _createNewSpaces(context, refetchSpaces);
        },
        label: const Text(
          'New Spaces',
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(
          Icons.add_circle,
          color: Colors.white,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder<GetUserData>(
            future: getUserDataFromJson(),
            builder: (context, snapshot) {
              GetUserData? user = snapshot.data;
              return Flexible(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: TextField(
                                onTap: () {
                                  searchFocus.requestFocus();
                                },
                                cursorColor: Colors.black,
                                focusNode: searchFocus,
                                controller: searchControler,
                                decoration: InputDecoration(
                                    hintText: "All Spaces",
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2, color: Colors.black26),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2,
                                          color: ColorStyle().purpleColor),
                                    ),
                                    suffixIcon: ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          foregroundColor: Colors.black,
                                          elevation: 0),
                                      onPressed: () {
                                        setState(() {});
                                        refetchSpaces();
                                      },
                                      icon: const Icon(
                                        Icons.search,
                                        size: 24.0,
                                      ),
                                      label: const Text('Search'),
                                    ))),
                          ),
                        ],
                      ),
                    ),
                    if (user != null) ...[
                      StatefulBuilder(
                          builder: (BuildContext context, setState) {
                        return Query(
                          options: QueryOptions(
                              document: gql(getSpaces),
                              variables: {
                                "where": {
                                  "studentsId": user.studentId,
                                  "name_contains": searchControler.text,
                                },
                                "queryConference": const {
                                  "conferenceStatus": "ONAIR",
                                },
                                "limit": spacesLimit,
                                "skip": spacesSkip
                              }),
                          builder: (result, {fetchMore, refetch}) {
                            refetchSpaces = refetch;
                            if (result.hasException) {
                              return Center(
                                child: LoadingAnimationWidget.halfTriangleDot(
                                  color: Colors.black,
                                  size: 50,
                                ),
                              );
                            }
                            if (result.isLoading) {
                              // return const Center(
                              //     child: CircularProgressIndicator());
                            }
                            if (result.data?["spacesConnection"]?["data"] ==
                                    null ||
                                result.data?["spacesConnection"]?["data"]
                                        .length ==
                                    0) {
                              // return Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: const [
                              //     Text(
                              //       'No Spaces',
                              //       textAlign: TextAlign.center,
                              //     ),
                              //   ],
                              // );
                              refreshController.loadNoData();
                              refreshController.loadComplete();
                              refreshController.refreshCompleted();
                              // setState(
                              //   () {},
                              // );
                            } else {
                              spacesList.addAll(result.data?["spacesConnection"]
                                      ?["data"]
                                  .map<SpacesModel>((v) =>
                                      spacesModelFromJson(json.encode(v)))
                                  .toList());
                            }
                            print(result.data?["spacesConnection"]?["data"]);
                            List<SpacesModel> spacesSet = spacesList
                                .map((item) => jsonEncode(item))
                                .toList()
                                .toSet()
                                .toList()
                                .map<SpacesModel>(
                                    (item) => spacesModelFromJson(item))
                                .toList();

                            refreshController.loadComplete();
                            refreshController.refreshCompleted();
                            return Flexible(
                              child: Column(
                                children: [
                                  Flexible(
                                      child: SmartRefresher(
                                          controller: refreshController,
                                          enablePullDown: true,
                                          enablePullUp: true,
                                          onLoading: () async {
                                            await Future.delayed(const Duration(
                                                milliseconds: 1000));
                                            spacesLimit = 20;
                                            spacesSkip = spacesSet.length;

                                            setState(() {});
                                            refetch!();
                                            refreshController.loadComplete();
                                          },
                                          onRefresh: () async {
                                            await Future.delayed(const Duration(
                                                milliseconds: 1000));
                                            spacesLimit = 20;
                                            spacesSkip = 0;
                                            spacesList.clear();
                                            setState(
                                              () {},
                                            );
                                            await refetch!();
                                            refreshController
                                                .refreshCompleted();
                                          },
                                          child: GridView.count(
                                              primary: false,
                                              padding: const EdgeInsets.all(5),
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 20,
                                              crossAxisCount: 2,
                                              childAspectRatio: 0.75,
                                              children: spacesSet.map((space) {
                                                return SpaceCard(
                                                  space: space,
                                                  userId: user.id,
                                                  refetchSpaces: refetchSpaces,
                                                );
                                              }).toList())))
                                ],
                              ),
                            );
                          },
                        );
                      })
                    ] else ...[
                      Container()
                    ]
                  ],
                ),
              );
              // if (user != null) {
              //   // print(user.id);
              //   return Query(
              //     options: QueryOptions(document: gql(getSpaces), variables: {
              //       "where": {
              //         "studentsId": user.studentId,
              //       },
              //       "queryConference": const {
              //         "conferenceStatus": "ONAIR",
              //       },
              //     }),
              //     builder: (result, {fetchMore, refetch}) {
              //       List<SpacesModel> spacesList = result
              //           .data!["spacesConnection"]["data"]
              //           .map<SpacesModel>(
              //               (v) => spacesModelFromJson(json.encode(v)))
              //           .toList();
              //       // // spacesModelFromJson(json.encode(
              //       // //     result.data!["spacesConnection"]["data"].map[0]))
              //       // print(test[0].name);
              //       return SpacesCard(
              //         spacesList: spacesList,
              //         userId: user.id,
              //       );
              //     },
              //   );
              // } else {
              //   return Container();
              // }
            },
          ),
        ],
      ),
    );
  }
}

class _ModelselectedFeatures with ChangeNotifier {
  final TextEditingController _nameSpaceController = TextEditingController();

  final Map _selectedFeatures = {
    "videoConverence": false,
    "courses": false,
    "docsFiles": false,
    "schedule": false,
    "automaticCheckins": false,
    "gorupChat": false,
    "infoBoard": false,
    "tasks": false
  };

  final List menus = [
    {
      "key": "videoConverence",
      "title": "Video Conference",
      "thumbnail": "assets/images/conference.png",
      "description": "Meet your team online",
      "color": "yellow",
    },
    {
      "key": "courses",
      "title": "Courses",
      "thumbnail": "assets/images/courses.png",
      "description":
          "Collection of our learning materials on any format such as Video, Ebook, Doc, etc",
      "color": "green",
    },
    {
      "key": "docsFiles",
      "title": "Docs & Files",
      "thumbnail": "assets/images/docs.png",
      "description": "Upload or Read your Docs & Files here",
      "color": "red",
    },
    {
      "key": "schedule",
      "title": "Schedule",
      "thumbnail": "assets/images/schedule.png",
      "description": "Schedule your work/activities timeline here",
      "color": "purple",
    },
    {
      "key": "automaticCheckins",
      "title": "Automatic Check-ins",
      "thumbnail": "assets/images/checkin.png",
      "description": "Daily Report to track your own/team progress",
      "color": "yellow",
    },
    {
      "key": "gorupChat",
      "title": "Group Chat",
      "thumbnail": "assets/images/groupchat.png",
      "description":
          "Chit Chat about your work progress, your daily acitivity, or just some random talk",
      "color": "red",
    },
    {
      "key": "infoBoard",
      "title": "Info Board",
      "thumbnail": "assets/images/infoboard.png",
      "description": "Get the latest information on your workplace/school",
      "color": "purple",
    },
    {
      "key": "tasks",
      "title": "Tasks",
      "thumbnail": "assets/images/tasks.png",
      "description": "Kanban Board to track your Task/Project",
      "color": "green",
    }
  ];

  Map get selectedFeatures => _selectedFeatures;
  TextEditingController get nameSpaceController => _nameSpaceController;

  void selectTheSelectFeature(key) {
    _selectedFeatures.update(key, ((value) => !value));
    notifyListeners();
  }

  void changeNameSpace() {
    notifyListeners();
  }
}

Future<void> _createNewSpaces(BuildContext context, dynamic refetchSpaces) {
  Future<http.Response> createSpace(String name, Map selectedFeatures) async {
    String token = await getUserToken();
    return http.post(
      Uri.parse("$urlEnvironmentFunction/spacemenu"),
      headers: <String, String>{
        'Accept': '*',
        'Content-Type': 'application/json; charset=utf-8',
        "Authorization": "Bearer $token"
      },
      body: jsonEncode(<String, dynamic>{
        "name": name,
        "conference": selectedFeatures["videoConverence"],
        "course": selectedFeatures["courses"],
        "docFile": selectedFeatures["docsFiles"],
        "schedule": selectedFeatures["schedule"],
        "autoCheckIn": selectedFeatures["automaticCheckins"],
        "groupChat": selectedFeatures["gorupChat"],
        "infoBoard": selectedFeatures["infoBoard"],
        "task": selectedFeatures["tasks"]
      }),
    );
  }

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Create New Space'),
        insetPadding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
        contentPadding: const EdgeInsets.all(10),
        content: StatefulBuilder(
          builder: (context, setState) => ChangeNotifierProvider(
            create: (context) => _ModelselectedFeatures(),
            child: Consumer<_ModelselectedFeatures>(
              builder: (context, modelselectedFeatures, _) => Column(
                children: [
                  Flexible(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: TextField(
                                    cursorColor: Colors.black,
                                    controller: modelselectedFeatures
                                        .nameSpaceController,
                                    onChanged: (value) {
                                      modelselectedFeatures.changeNameSpace();
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Space Name",
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2, color: Colors.black26),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2,
                                            color: ColorStyle().purpleColor),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                          Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(),
                            padding: const EdgeInsets.all(10),
                            child: const Text(
                              "Select Features",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Wrap(
                              spacing: 10,
                              runSpacing: 20,
                              children: modelselectedFeatures.menus
                                  .map(
                                    (menu) => InkWell(
                                      onTap: () {
                                        // print(selectedFeatures[menu["key"]]);
                                        // selectedFeatures.update(
                                        //     menu["key"], ((value) => !value));
                                        modelselectedFeatures
                                            .selectTheSelectFeature(
                                                menu["key"]);
                                        print(modelselectedFeatures
                                            ._selectedFeatures);
                                        // print(menu.keys["key"]);
                                        // print(selectedFeatures);
                                      },
                                      child: Ink(
                                        // ignore: sort_child_properties_last
                                        child: Stack(children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            // height: MediaQuery.of(context).size.height / 2.5,
                                            child: Card(
                                              color: Colors.white,
                                              elevation: 2.0,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0)),
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Image.asset(
                                                          menu["thumbnail"],
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.2),
                                                      const SizedBox(
                                                        height: 10.0,
                                                      ),
                                                      Text(
                                                        menu["title"],
                                                        // maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      const SizedBox(
                                                        height: 10.0,
                                                      ),
                                                      SizedBox(
                                                        height: 80,
                                                        child: Text(
                                                          menu["description"],
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: const TextStyle(
                                                              fontSize: 12,
                                                              overflow:
                                                                  TextOverflow
                                                                      .fade),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                            ),
                                          ),
                                          Positioned(
                                              right: 0,
                                              child: modelselectedFeatures
                                                          ._selectedFeatures[
                                                      menu["key"]]
                                                  ? const Icon(
                                                      Icons.check_box_outlined,
                                                      size: 30,
                                                      color: Colors.orange,
                                                    )
                                                  : Container())
                                        ]),
                                      ),
                                    ),
                                  )
                                  .toList()),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 36,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12),
                              borderRadius: BorderRadius.circular(5)),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              textStyle: Theme.of(context).textTheme.labelLarge,
                            ),
                            child: const Text(
                              "Cancel",
                              style: TextStyle(color: Colors.black54),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        ElevatedButton(
                          style: TextButton.styleFrom(
                            textStyle: Theme.of(context).textTheme.labelLarge,
                          ),
                          onPressed: modelselectedFeatures
                                          ._nameSpaceController.text
                                          .trim() !=
                                      "" &&
                                  modelselectedFeatures._selectedFeatures
                                      .containsValue(true)
                              ? () async {
                                  // print(modelselectedFeatures
                                  //         ._nameSpaceController.text
                                  //         .trim() +
                                  //     modelselectedFeatures._selectedFeatures
                                  //         .containsValue(true)
                                  //         .toString());
                                  // print(await getUserToken());
                                  http.Response response = await createSpace(
                                      modelselectedFeatures
                                          ._nameSpaceController.text
                                          .trim(),
                                      modelselectedFeatures._selectedFeatures);
                                  // print(json.decode(response.body)["error"]);
                                  Navigator.of(context).pop();
                                  setState(() {
                                    refetchSpaces();
                                  });
                                }
                              : null,
                          child: const Text(
                            'Create Spaces',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
