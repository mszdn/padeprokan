import 'dart:convert';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:padeprokan/components/organisms/appBar/appbar_widget.dart';
import 'package:padeprokan/components/organisms/modal/preview_file_modal.dart';
import 'package:padeprokan/components/utils/genCoverFile.dart';
import 'package:padeprokan/components/utils/model/docsfiles/userFiles.dart';
import 'package:padeprokan/components/utils/model/docsfiles/userFolders.dart';
// import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:padeprokan/components/utils/theme_colors.dart';
import 'package:padeprokan/graphql/docsfiles/deleteFileFolder.dart';
import 'package:padeprokan/graphql/docsfiles/folder.dart';
import 'package:padeprokan/graphql/docsfiles/initDrive.dart';
import 'package:padeprokan/graphql/docsfiles/upload.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';
import 'dart:io';
import 'dart:async';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class _ModelDownload with ChangeNotifier {
  bool _loading = false;
  int _downloadProgress = 0;

  bool get loading => _loading;
  int get downloadProgress => _downloadProgress;

  void setLoading(bool isLoading) {
    _loading = isLoading;
    notifyListeners();
  }

  void setDowloadProgress(int progress) {
    _downloadProgress = progress;
    notifyListeners();
  }
}

class DocsFilesView extends StatefulWidget {
  final String spaceId;
  String? folderId;
  String? folderName;
  DocsFilesView(
      {Key? key, required this.spaceId, this.folderId, this.folderName})
      : super(key: key);

  @override
  State<DocsFilesView> createState() => _DocsFilesViewState();
}

class _DocsFilesViewState extends State<DocsFilesView> {
  File? imager;
  bool isLoading = false;
  late String _localPath;
  late bool _permissionReady;
  late TargetPlatform? platform;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      platform = TargetPlatform.android;
    } else {
      platform = TargetPlatform.iOS;
    }
  }

  Future<bool> _checkPermission() async {
    if (platform == TargetPlatform.android) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  Future<void> _prepareSaveDir() async {
    _localPath = (await _findLocalPath())!;

    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
  }

  Future<String?> _findLocalPath() async {
    if (platform == TargetPlatform.android) {
      return "/storage/emulated/0/Download";
    } else {
      var directory = await getApplicationDocumentsDirectory();
      return '${directory.path}${Platform.pathSeparator}Download';
    }
  }

  @override
  Widget build(BuildContext context) {
    Future getImage() async {
      final ImagePicker picker = ImagePicker();
      // Pick an image
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      // print(image!.path);
      setState(() {
        imager = File(image!.path);

        // print(multipartFile);
      });
    }

    return Query(
      options: QueryOptions(document: gql(getInitDrive), variables: {
        "spaceId": widget.spaceId,
        "parentFolder": widget.folderId
      }),
      builder: (result, {fetchMore, refetch}) {
        if (result.hasException) {
          return LoadingAnimationWidget.halfTriangleDot(
              color: Colors.black, size: 50);
        }
        return Scaffold(
          appBar: appBarWidget(context, "Docs & Files"),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                  dragStartBehavior: DragStartBehavior.start,
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              widget.folderName ?? "",
                              textAlign: TextAlign.left,
                              style: const TextStyle(fontSize: 20),
                            ),
                          )
                        ],
                      ))),
              // Padding(
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              //   child: Container(
              //     height: 35,
              //     width: double.infinity,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(5),
              //       color: Colors.white,
              //       border: Border.all(color: Colors.grey.shade200, width: 0.5),
              //     ),
              //     child: TextField(
              //       decoration: InputDecoration(
              //           contentPadding: const EdgeInsets.only(left: 20),
              //           hintText: "search file or folder",
              //           suffixIcon: const Icon(Icons.search),
              //           border: OutlineInputBorder(
              //               borderRadius: BorderRadius.circular(5))),
              //     ),
              // ),
              // ),
              if (result.data != null) ...[
                Builder(
                  builder: (context) {
                    List<UserFileModel> userFileModel = result
                        .data?["userFilesConnection"]?["data"]
                        .map<UserFileModel>(
                            (v) => userFileModelFromJson(json.encode(v)))
                        .toList();
                    List<UserFolderModel> userFolderModel = result
                        .data?["foldersConnection"]?["data"]
                        .map<UserFolderModel>(
                            (v) => userFolderModelFromJson(json.encode(v)))
                        .toList();
                    return Flexible(
                      child: GridView.count(
                          primary: false,
                          padding: const EdgeInsets.all(5),
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          crossAxisCount: 2,
                          childAspectRatio: 0.9,
                          children: [
                            // C:\Users\Gilang\Documents\GitHub\padeprokan-flutter\assets\images\folder.png
                            ...userFolderModel.map((folder) => Stack(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DocsFilesView(
                                                spaceId: widget.spaceId,
                                                folderId: folder.id,
                                                folderName: widget.folderName !=
                                                        null
                                                    ? "${widget.folderName}/" +
                                                        folder.title
                                                    : "" " / " + folder.title,
                                              ),
                                            ));
                                      },
                                      child: Ink(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 8, 0, 8),
                                          child: Container(
                                            clipBehavior: Clip.hardEdge,
                                            // padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: Colors.white,
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Colors.black26,
                                                    blurRadius: 1,
                                                    offset: Offset(1,
                                                        1), // Shadow position
                                                  ),
                                                ]),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                      width: double.infinity,
                                                      color: const Color(
                                                          0xFFDEE2E6),
                                                      child: Center(
                                                        child: Stack(
                                                          alignment:
                                                              Alignment.center,
                                                          children: [
                                                            Image.asset(
                                                                "assets/images/docsFiles/folder.png"),
                                                            Text(
                                                              folder.title,
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          20),
                                                            )
                                                          ],
                                                        ),
                                                      )),
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
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        right: -10,
                                        top: 0,
                                        child: Container(
                                          // color: Colors.red,
                                          // width: 100.0,
                                          // height: 80.0,
                                          child: PopupMenuButton(
                                            enabled: true,
                                            // Callback that sets the selected popup menu item.
                                            position: PopupMenuPosition.under,
                                            icon: const Icon(Icons.more_vert,
                                                color: Colors.white),
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(5),
                                              ),
                                            ),
                                            elevation: 1,
                                            itemBuilder:
                                                (BuildContext context) =>
                                                    <PopupMenuEntry>[
                                              PopupMenuItem(
                                                padding: EdgeInsets.zero,
                                                value: "delete",
                                                child: Mutation(
                                                    options: MutationOptions(
                                                      document:
                                                          gql(deleteFolder),
                                                      onCompleted:
                                                          (dynamic resultData) {
                                                        Navigator.pop(context);
                                                        Navigator.pop(context);
                                                        if (resultData !=
                                                            null) {
                                                          setState(() {
                                                            isLoading = false;
                                                            refetch!();
                                                          });
                                                        }
                                                      },
                                                    ),
                                                    builder: (
                                                      runMutation,
                                                      result,
                                                    ) {
                                                      return ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                elevation: 0),
                                                        onPressed: () async {
                                                          return showDialog(
                                                              context: context,
                                                              builder: (context) =>
                                                                  AlertDialog(
                                                                      contentPadding:
                                                                          EdgeInsets
                                                                              .zero,
                                                                      scrollable:
                                                                          true,
                                                                      actions: [
                                                                        ElevatedButton(
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.pop(context);
                                                                            },
                                                                            style:
                                                                                ElevatedButton.styleFrom(backgroundColor: Colors.transparent, elevation: 0),
                                                                            child: const Text(
                                                                              "Cancel",
                                                                            )),
                                                                        ElevatedButton(
                                                                            onPressed:
                                                                                () {
                                                                              isLoading = true;
                                                                              // print("object");
                                                                              runMutation({
                                                                                "id": folder.id
                                                                              });
                                                                            },
                                                                            style:
                                                                                ElevatedButton.styleFrom(backgroundColor: Colors.transparent, elevation: 0),
                                                                            child: (isLoading)
                                                                                ? const SizedBox(
                                                                                    width: 16,
                                                                                    height: 16,
                                                                                    child: CircularProgressIndicator(
                                                                                      color: Colors.black,
                                                                                    ),
                                                                                  )
                                                                                : const Text(
                                                                                    'Submit',
                                                                                    style: TextStyle(color: Colors.red),
                                                                                  ))
                                                                      ],
                                                                      content:
                                                                          const SizedBox(
                                                                        height:
                                                                            80,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text("Delete this folder?"),
                                                                        ),
                                                                      )));
                                                        },
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: const [
                                                            Icon(
                                                              Icons.delete,
                                                              color: Colors.red,
                                                            ),
                                                            Text(
                                                              "Delete",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    }),
                                              ),
                                            ],
                                          ),
                                        ))
                                  ],
                                )),
                            ...userFileModel.map((file) {
                              dynamic cover = genCoverFile(file.type, file);
                              return ChangeNotifierProvider(
                                  create: (context) => _ModelDownload(),
                                  child: Consumer<_ModelDownload>(
                                      builder:
                                          (context, modelDownload, _) => Stack(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      previewFileModal(context,
                                                          fileType: file.type,
                                                          file: file);
                                                    },
                                                    child: Ink(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                0, 8, 0, 8),
                                                        child: Container(
                                                          clipBehavior:
                                                              Clip.hardEdge,
                                                          // padding: const EdgeInsets.all(8),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              color:
                                                                  Colors.white,
                                                              boxShadow: const [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .black26,
                                                                  blurRadius: 1,
                                                                  offset: Offset(
                                                                      1,
                                                                      1), // Shadow position
                                                                ),
                                                              ]),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Expanded(
                                                                flex: 1,
                                                                child: Container(
                                                                    width: double.infinity,
                                                                    color: const Color(0xFFDEE2E6),
                                                                    child: Center(
                                                                      child: !cover.contains(
                                                                              "/index.php/apps/files_sharing/")
                                                                          ? SvgPicture.asset(
                                                                              cover)
                                                                          : CachedNetworkImage(
                                                                              imageUrl: cover,
                                                                              width: double.infinity,
                                                                            ),
                                                                    )),
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
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        8,
                                                                        8,
                                                                        8,
                                                                        8),
                                                                child: Text(
                                                                  file.title
                                                                      .toString(),
                                                                  maxLines: 1,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  modelDownload._loading
                                                      ? Positioned(
                                                          left: 5,
                                                          top: 10,
                                                          child: Row(
                                                            children: [
                                                              const SizedBox(
                                                                width: 20,
                                                                height: 20,
                                                                child:
                                                                    CircularProgressIndicator(),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            10.0),
                                                                child: Text(
                                                                    "${modelDownload._downloadProgress}%"),
                                                              )
                                                            ],
                                                          ))
                                                      : Container(),
                                                  Positioned(
                                                      right: -10,
                                                      top: 0,
                                                      child: Container(
                                                        // color: Colors.red,
                                                        // width: 100.0,
                                                        // height: 80.0,
                                                        child: PopupMenuButton(
                                                          enabled: true,
                                                          // Callback that sets the selected popup menu item.
                                                          position:
                                                              PopupMenuPosition
                                                                  .under,
                                                          icon: const Icon(
                                                              Icons.more_vert,
                                                              color:
                                                                  Colors.white),
                                                          shape:
                                                              const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  5),
                                                            ),
                                                          ),
                                                          elevation: 1,
                                                          itemBuilder: (BuildContext
                                                                  context) =>
                                                              <PopupMenuEntry>[
                                                            PopupMenuItem(
                                                              padding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              value: "delete",
                                                              child: Mutation(
                                                                  options:
                                                                      MutationOptions(
                                                                    document: gql(
                                                                        deleteFile),
                                                                    onCompleted:
                                                                        (dynamic
                                                                            resultData) {
                                                                      Navigator.pop(
                                                                          context);
                                                                      Navigator.pop(
                                                                          context);
                                                                      if (resultData !=
                                                                          null) {
                                                                        setState(
                                                                            () {
                                                                          isLoading =
                                                                              false;
                                                                          refetch!();
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
                                                                          backgroundColor: Colors
                                                                              .transparent,
                                                                          elevation:
                                                                              0),
                                                                      onPressed:
                                                                          () async {
                                                                        return showDialog(
                                                                            context:
                                                                                context,
                                                                            builder: (context) => AlertDialog(
                                                                                contentPadding: EdgeInsets.zero,
                                                                                scrollable: true,
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
                                                                                        isLoading = true;
                                                                                        // print("object");
                                                                                        runMutation({
                                                                                          "id": file.id
                                                                                        });
                                                                                      },
                                                                                      style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, elevation: 0),
                                                                                      child: (isLoading)
                                                                                          ? const SizedBox(
                                                                                              width: 16,
                                                                                              height: 16,
                                                                                              child: CircularProgressIndicator(
                                                                                                color: Colors.black,
                                                                                              ),
                                                                                            )
                                                                                          : const Text(
                                                                                              'Delete',
                                                                                              style: TextStyle(color: Colors.red),
                                                                                            ))
                                                                                ],
                                                                                content: const SizedBox(
                                                                                  height: 80,
                                                                                  child: Center(
                                                                                    child: Text("Delete this file?"),
                                                                                  ),
                                                                                )));
                                                                      },
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: const [
                                                                          Icon(
                                                                            Icons.delete,
                                                                            color:
                                                                                Colors.red,
                                                                          ),
                                                                          Text(
                                                                            "Delete",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.red,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  }),
                                                            ),
                                                            PopupMenuItem(
                                                                padding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                value:
                                                                    "download",
                                                                child:
                                                                    ElevatedButton(
                                                                  style: ElevatedButton.styleFrom(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .transparent,
                                                                      elevation:
                                                                          0),
                                                                  onPressed:
                                                                      () async {
                                                                    _permissionReady =
                                                                        await _checkPermission();
                                                                    if (_permissionReady) {
                                                                      await _prepareSaveDir();
                                                                      try {
                                                                        Navigator.pop(
                                                                            context);
                                                                        modelDownload
                                                                            .setLoading(true);
                                                                        await Dio().download(
                                                                            file
                                                                                .downloadUrl,
                                                                            "$_localPath/${file.title}.${json.decode(file.type)["ext"]}",
                                                                            onReceiveProgress:
                                                                                (rec, total) {
                                                                          int prog =
                                                                              (((rec / total) * 100).toInt());
                                                                          modelDownload
                                                                              .setDowloadProgress(prog);
                                                                        });
                                                                        ScaffoldMessenger.of(context)
                                                                            .showSnackBar(SnackBar(
                                                                          content:
                                                                              SizedBox(
                                                                            height:
                                                                                30,
                                                                            child:
                                                                                Column(
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Text("Downloaded:${file.title}"),
                                                                                // Text("Directory: $_localPath/${file.title}.${json.decode(file.type)["ext"]}")
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ));
                                                                        modelDownload
                                                                            .setLoading(false);
                                                                      } catch (e) {
                                                                        modelDownload
                                                                            .setLoading(false);
                                                                      }
                                                                    }
                                                                  },
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: const [
                                                                      Icon(
                                                                        Icons
                                                                            .download,
                                                                        color: Colors
                                                                            .orange,
                                                                      ),
                                                                      Text(
                                                                        "Download",
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.orange,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ))
                                                          ],
                                                        ),
                                                      ))
                                                ],
                                              )));
                            })
                          ]),
                    );
                  },
                )
              ],
              // const Getimage(),
            ],
          ),
          floatingActionButton: SpeedDial(
            speedDialChildren: <SpeedDialChild>[
              SpeedDialChild(
                onPressed: () {
                  TextEditingController fileName = TextEditingController();
                  TextEditingController embedLink = TextEditingController();
                  return showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      contentPadding: EdgeInsets.zero,
                      scrollable: true,
                      content: SingleChildScrollView(
                        child: Mutation(
                          options: MutationOptions(
                            document: gql(upload),
                            onCompleted: (dynamic resultData) {
                              Navigator.of(context).pop();
                              if (resultData != null) {
                                setState(() {
                                  isLoading = false;
                                  refetch!();
                                });
                              }
                            },
                          ),
                          builder: (runMutation, result,
                              {VoidCallback? refetch, FetchMore? fetchMore}) {
                            if (result!.hasException) {
                              // return Text(result.exception.toString());
                            }
                            // print(result?.data);
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                      'Embed Link From Google Drive or Simpanan'),
                                ),
                                const Divider(),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('File Name'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: fileName,
                                    autofocus: false,
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(width: 1))),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Embed Link'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: embedLink,
                                    autofocus: false,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(width: 1),
                                      ),
                                    ),
                                  ),
                                ),
                                const Divider(),
                                Row(
                                  children: [
                                    const Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white),
                                        onPressed: () {
                                          // Navigator.pop(context);
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  ColorStyle().PurpleButton),
                                          onPressed: () {
                                            isLoading = true;
                                            runMutation({
                                              "input": {
                                                "name": fileName.text,
                                                // "type": "file",
                                                "embedLink": embedLink.text,
                                                "spaceId": widget.spaceId,
                                                // "parentFolder": widget.folderId,
                                              },
                                            });
                                            // print(_fileName.text);
                                            // print(_embedLink.text);
                                          },
                                          child: (isLoading)
                                              ? const SizedBox(
                                                  width: 16,
                                                  height: 16,
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Colors.white,
                                                  ),
                                                )
                                              : const Text(
                                                  'Submit',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )),
                                    ),
                                  ],
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
                child: const Icon(
                  Icons.code,
                  color: Colors.white,
                ),
                label: "Embed Link",
              ),
              SpeedDialChild(
                  child: const Icon(
                    Icons.cloud_upload_outlined, color: Colors.white,
                    // size: ,
                  ),
                  label: "Upload File",
                  onPressed: () async {
                    // Directory findRoot(FileSystemEntity entity) {
                    //   final Directory parent = entity.parent;
                    //   if (parent.path == entity.path) return parent;
                    //   return findRoot(parent);
                    // }

                    // final Directory rootPath =
                    //     findRoot(await getApplicationDocumentsDirectory());
                    // print(rootPath.path);
                    // FilesystemPicker.openDialog(
                    //     context: context, rootDirectory: rootPath);

                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles();

                    if (result != null) {
                      File? fileUpload =
                          File(result.files.single.path.toString());
                      var byteData = fileUpload.readAsBytesSync();

                      var type = fileUpload.path
                          .split("/")
                          .removeLast()
                          .split(".")
                          .removeLast();

                      var multipartFile = http.MultipartFile.fromBytes(
                        'photo',
                        byteData,
                        filename: fileUpload.path.split("/").removeLast(),
                        contentType: MediaType("file", type),
                      );

                      if (multipartFile.length > 10000000) {
                        return showAlertDialog(
                            builder: (context, child) {
                              Future.delayed(const Duration(seconds: 2), () {
                                return Container();
                              });
                              return AlertDialog(
                                title: const Text(
                                  'Failed',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.red,
                                  ),
                                ),
                                content: const Text(
                                    'The uploaded file cannot be more than 10 MB'),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text("OK",
                                        style: TextStyle(color: Colors.red)),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                            context: context);
                        // print('tidak boleh up diatas 10 mb');
                      }

                      var fileType = {
                        "type": "file",
                        "ext": type,
                      };
                      return showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                contentPadding: EdgeInsets.zero,
                                scrollable: true,
                                content: SingleChildScrollView(
                                  child: Mutation(
                                      options: MutationOptions(
                                        document: gql(upload),
                                        onCompleted: (dynamic resultData) {
                                          Navigator.of(context).pop();
                                          if (resultData != null) {
                                            setState(() {
                                              isLoading = false;
                                              refetch!();
                                            });
                                          }
                                        },
                                      ),
                                      builder: (
                                        runMutation,
                                        result,
                                      ) {
                                        return SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              8,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SingleChildScrollView(
                                                  dragStartBehavior:
                                                      DragStartBehavior.start,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Stack(
                                                        children: [
                                                          SvgPicture.asset(
                                                            "assets/images/docsFiles/default-file.svg",
                                                            height: 60,
                                                          ),
                                                          Positioned(
                                                              bottom: 1,
                                                              right: 1,
                                                              child: Text(
                                                                ". $type",
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ))
                                                        ],
                                                      ),
                                                      Text(
                                                        fileUpload.path
                                                            .split("/")
                                                            .removeLast(),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    const Spacer(),
                                                    Column(
                                                      children: [
                                                        Container(
                                                          height: 40,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .black)),
                                                          child: TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: const Text(
                                                              'Cancel',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
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
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.purple,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              border:
                                                                  Border.all(
                                                                color: const Color
                                                                        .fromRGBO(
                                                                    173,
                                                                    120,
                                                                    211,
                                                                    1),
                                                              ),
                                                            ),
                                                            child: TextButton(
                                                                onPressed:
                                                                    () async {
                                                                  // '${DateTime.now().second}.jpg',
                                                                  isLoading =
                                                                      true;
                                                                  runMutation({
                                                                    "input": {
                                                                      "name": fileUpload
                                                                          .path
                                                                          .split(
                                                                              "/")
                                                                          .removeLast(),
                                                                      "url":
                                                                          multipartFile,
                                                                      "spaceId":
                                                                          widget
                                                                              .spaceId,
                                                                      "folderId":
                                                                          widget
                                                                              .folderId,
                                                                      "type": json
                                                                          .encode(
                                                                              fileType)
                                                                    }
                                                                  });
                                                                },
                                                                child: (isLoading)
                                                                    ? const SizedBox(
                                                                        width:
                                                                            16,
                                                                        height:
                                                                            16,
                                                                        child:
                                                                            CircularProgressIndicator(
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      )
                                                                    : const Text(
                                                                        'Submit',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                      )),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                ),
                              ));
                    } else {
                      // User canceled the picker
                      // final f = File("file");
                      // int sizeInBytes = f.lengthSync();
                      // double sizeInMb = sizeInBytes / (1024 * 1024);
                      // if (sizeInMb > 10) {
                      //   print('tidak boleh lebih dari 10 mb');
                      // }
                    }
                  }),
              SpeedDialChild(
                child: const Icon(
                  Icons.create_new_folder_outlined, color: Colors.white,
                  // size: ,
                ),
                label: 'Add Folder',
                onPressed: () {
                  TextEditingController nameFolder = TextEditingController();
                  showDialog(
                    context: context,
                    builder: (context) => Mutation(
                        options: MutationOptions(
                          document: gql(createFolder),
                          onCompleted: (dynamic resultData) {
                            Navigator.of(context).pop();
                            if (resultData != null) {
                              setState(() {
                                isLoading = false;
                                refetch!();
                              });
                            }
                          },
                        ),
                        builder: (runMutation, result) {
                          return AlertDialog(
                            title: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const Text("Add Folder"),
                                      const SizedBox(
                                        width: 240,
                                      ),
                                      IconButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        icon: const Icon(Icons.close),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: const [
                                      Text(
                                        "Folder Name",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(right: 300)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            content: SizedBox(
                              child: TextFormField(
                                controller: nameFolder,
                                cursorColor: Colors.black,
                                decoration: const InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.deepPurple),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.deepPurple)),
                                  hintText: "New Folder Name",
                                ),
                              ),
                            ),
                            actions: [
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
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: Colors.black)),
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
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                color: const Color.fromRGBO(
                                                    173, 120, 211, 1),
                                              ),
                                            ),
                                            child: TextButton(
                                                onPressed: () async {
                                                  isLoading = true;
                                                  runMutation({
                                                    "input": {
                                                      "name": nameFolder.text,
                                                      "parentFolder":
                                                          widget.folderId,
                                                      "spaceId": widget.spaceId
                                                    }
                                                  });
                                                },
                                                child: (isLoading)
                                                    ? const SizedBox(
                                                        width: 16,
                                                        height: 16,
                                                        child:
                                                            CircularProgressIndicator(
                                                          color: Colors.white,
                                                        ),
                                                      )
                                                    : const Text(
                                                        'Submit',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }),
                  );
                },
              ),
              // SpeedDialChild(
              //   child: const Icon(
              //     Icons.upload_file, color: Colors.white,
              //     // size: ,
              //   ),
              //   label: 'New File Txt',
              //   onPressed: () {
              //     showDialog(
              //       context: context,
              //       builder: (context) => AlertDialog(
              //         title: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             SizedBox(
              //               width: 350,
              //               child: Column(
              //                 children: [
              //                   DecoratedBox(
              //                     decoration: BoxDecoration(
              //                       border: Border.all(color: Colors.white),
              //                     ),
              //                     child: const TextField(
              //                       keyboardType: TextInputType.multiline,
              //                       maxLines: 1,
              //                       decoration: InputDecoration.collapsed(
              //                         border: InputBorder.none,
              //                         hintText: 'File Name',
              //                         hintStyle: TextStyle(
              //                             fontWeight: FontWeight.bold,
              //                             fontSize: 22),
              //                       ),
              //                     ),
              //                   ),
              //                   const Divider(
              //                     color: Colors.black,
              //                   )
              //                 ],
              //               ),
              //             ),
              //             const SizedBox(
              //               height: 10,
              //             ),
              //             SizedBox(
              //               height: 150,
              //               width: 350,
              //               child: Column(
              //                 children: [
              //                   DecoratedBox(
              //                     decoration: BoxDecoration(
              //                       border: Border.all(color: Colors.white),
              //                     ),
              //                     child: const TextField(
              //                       keyboardType: TextInputType.multiline,
              //                       maxLines: 7,
              //                       decoration: InputDecoration.collapsed(
              //                         border: InputBorder.none,
              //                         hintText: 'Write your document here',
              //                         hintStyle: TextStyle(),
              //                       ),
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //             Row(
              //               children: [
              //                 Padding(
              //                   padding:
              //                       const EdgeInsets.symmetric(horizontal: 20),
              //                   child: Container(
              //                     child: Column(
              //                       children: [
              //                         Container(
              //                           height: 40,
              //                           decoration: BoxDecoration(
              //                             color: Colors.white,
              //                             borderRadius:
              //                                 BorderRadius.circular(5),
              //                             border:
              //                                 Border.all(color: Colors.black),
              //                           ),
              //                           child: TextButton(
              //                             onPressed: () =>
              //                                 Navigator.of(context).pop(),
              //                             child: const Text(
              //                               "Cancel",
              //                               style:
              //                                   TextStyle(color: Colors.black),
              //                             ),
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //                 Container(
              //                   height: 40,
              //                   decoration: BoxDecoration(
              //                     color: Colors.green,
              //                     borderRadius: BorderRadius.circular(5),
              //                     border: Border.all(color: Colors.green),
              //                   ),
              //                   child: TextButton(
              //                     onPressed: () {},
              //                     child: Row(
              //                       children: const [
              //                         Icon(
              //                           Icons.file_copy,
              //                           color: Colors.white,
              //                           size: 15,
              //                         ),
              //                         SizedBox(
              //                           width: 5,
              //                         ),
              //                         Text(
              //                           "Save & Publish",
              //                           style: TextStyle(color: Colors.white),
              //                         )
              //                       ],
              //                     ),
              //                   ),
              //                 )
              //               ],
              //             )
              //           ],
              //         ),
              //       ),
              //     );
              //   },
              // ),
              SpeedDialChild(
                child: const Icon(
                  Icons.image_outlined, color: Colors.white,
                  // size: ,
                ),
                label: 'Upload Image',
                onPressed: () {
                  // File imager;
                  // final ImagePicker picker = ImagePicker();

                  // final XFile? image =
                  //     await picker.pickImage(source: ImageSource.gallery);

                  // imager = File(image!.path);
                  // print(imager);
                  getImage().then((value) {
                    if (imager != null) {
                      return showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                contentPadding: EdgeInsets.zero,
                                scrollable: true,
                                content: SingleChildScrollView(
                                  child: Mutation(
                                      options: MutationOptions(
                                        document: gql(upload),
                                        onCompleted: (dynamic resultData) {
                                          Navigator.of(context).pop();
                                          if (result.data != null) {
                                            setState(() {
                                              isLoading = false;
                                              refetch!();
                                            });
                                          }
                                        },
                                      ),
                                      builder: (
                                        runMutation,
                                        result,
                                      ) {
                                        return SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              8,
                                          child: Column(
                                            children: [
                                              Image.file(
                                                imager!,
                                                fit: BoxFit.cover,
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
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    const Spacer(),
                                                    Column(
                                                      children: [
                                                        Container(
                                                          height: 40,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .black)),
                                                          child: TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: const Text(
                                                              'Cancel',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
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
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.purple,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              border:
                                                                  Border.all(
                                                                color: const Color
                                                                        .fromRGBO(
                                                                    173,
                                                                    120,
                                                                    211,
                                                                    1),
                                                              ),
                                                            ),
                                                            child: TextButton(
                                                                onPressed:
                                                                    () async {
                                                                  isLoading =
                                                                      true;
                                                                  // '${DateTime.now().second}.jpg',
                                                                  var byteData =
                                                                      imager!
                                                                          .readAsBytesSync();
                                                                  var multipartFile =
                                                                      http.MultipartFile
                                                                          .fromBytes(
                                                                    'photo',
                                                                    byteData,
                                                                    filename: imager!
                                                                        .path
                                                                        .split(
                                                                            "/")
                                                                        .removeLast(),
                                                                    contentType: MediaType(
                                                                        "file",
                                                                        imager!
                                                                            .path
                                                                            .split("/")
                                                                            .removeLast()
                                                                            .split(".")
                                                                            .removeLast()),
                                                                  );

                                                                  var fileType =
                                                                      {
                                                                    "type":
                                                                        "file",
                                                                    "ext": imager!
                                                                        .path
                                                                        .split(
                                                                            "/")
                                                                        .removeLast()
                                                                        .split(
                                                                            ".")
                                                                        .removeLast(),
                                                                  };
                                                                  runMutation({
                                                                    "input": {
                                                                      "name": imager!
                                                                          .path
                                                                          .split(
                                                                              "/")
                                                                          .removeLast(),
                                                                      "url":
                                                                          multipartFile,
                                                                      "spaceId":
                                                                          widget
                                                                              .spaceId,
                                                                      "folderId":
                                                                          widget
                                                                              .folderId,
                                                                      "type": json
                                                                          .encode(
                                                                              fileType)
                                                                    }
                                                                  });
                                                                },
                                                                child: (isLoading)
                                                                    ? const SizedBox(
                                                                        width:
                                                                            16,
                                                                        height:
                                                                            16,
                                                                        child:
                                                                            CircularProgressIndicator(
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      )
                                                                    : const Text(
                                                                        'Submit',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                      )),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                ),
                              ));
                    }
                  });
                },
              ),
            ],
            closedForegroundColor: ColorStyle().yellowButton,
            openForegroundColor: ColorStyle().yellowButton,
            closedBackgroundColor: ColorStyle().yellowButton,
            openBackgroundColor: ColorStyle().yellowButton,
            labelsStyle: const TextStyle(color: Colors.white),
            labelsBackgroundColor: const Color.fromRGBO(0, 0, 0, 0.500),
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 30,
            ),
          ),
        );
      },
    );
  }
}

class Getimage extends StatefulWidget {
  const Getimage({super.key});

  @override
  State<Getimage> createState() => _GetimageState();
}

class _GetimageState extends State<Getimage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Image.asset(
            'assets/images/docsFiles/docs.png',
            width: MediaQuery.of(context).size.width / 2,
          ),
          const Text(
            "You don't have any file!",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 200,
                height: 40,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                    child: const Text(
                      'Upload your first file',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                            title: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  const Text(
                                    'Upload files',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 230,
                                  ),
                                  IconButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      icon: const Icon(Icons.close)),
                                ],
                              ),
                            ),
                            content: Container(
                              height: 150,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.purple),
                                  color: Colors.grey.shade200),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.close),
                                      Text(
                                        'Click or drag file to this area to upload',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        'Support for a singel or bulk upload. Strictly prohibit',
                                        style: TextStyle(
                                            fontSize: 13, color: Colors.grey),
                                      ),
                                      Text(
                                        'from uploading company data or other band files',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            actions: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Spacer(),
                                  Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: Colors.black)),
                                          child: TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context).pop(),
                                              child: const Text(
                                                'Cancel',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.purple,
                                        borderRadius: BorderRadius.circular(10),
                                        border:
                                            Border.all(color: Colors.purple)),
                                    child: TextButton(
                                      onPressed: () {},
                                      child: const Text('Upload',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                ],
                              )
                            ]),
                      );
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
