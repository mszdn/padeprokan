import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:padeprokan/components/utils/genEmbedFile.dart';
import 'package:padeprokan/components/utils/model/docsfiles/userFiles.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webviewx/webviewx.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Future<void> previewFileModal(BuildContext context,
    {required String fileType, required UserFileModel file}) {
  Map embed = genEmbedFile(
    fileType,
    file,
  );
  late WebViewXController webviewController;
  bool isLoading = true;
  late WebViewController webViewsController;

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        insetPadding: const EdgeInsets.all(8),
        clipBehavior: Clip.hardEdge,
        scrollable: true,
        content: StatefulBuilder(
          builder: (context, setState) {
            return SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Column(
                children: [
                  if (embed["type"] == "file") ...[
                    SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.85,
                      child: Stack(
                        clipBehavior: Clip.antiAlias,
                        alignment: Alignment.topCenter,
                        fit: StackFit.expand,
                        children: [
                          Positioned(
                            top: -0,
                            bottom: 50,
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: WebViewX(
                              initialContent:
                                  file.embedLink ?? file.owncloudUrl,
                              initialSourceType: SourceType.url,
                              onWebViewCreated: (controller) =>
                                  webviewController = controller,
                              width: double.infinity,
                              height:
                                  MediaQuery.of(context).size.height * 0.85 +
                                      173,
                              onPageFinished: (src) {
                                setState(() {
                                  isLoading = false;
                                });
                              },
                              onWebResourceError: (error) {
                                setState(() {
                                  isLoading = false;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    isLoading
                        ? Center(
                            child: LoadingAnimationWidget.halfTriangleDot(
                                color: Colors.black, size: 40),
                          )
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0)),
                            ),
                            onPressed: () {
                              setState(() {
                                webviewController.dispose();
                                Navigator.pop(context);
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ),
                                Text("Close",
                                    style: TextStyle(color: Colors.white))
                              ],
                            ),
                          )
                  ],
                  if (embed["type"] == "embed") ...[
                    SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.85,
                      child: Stack(
                        clipBehavior: Clip.antiAlias,
                        alignment: Alignment.topCenter,
                        fit: StackFit.expand,
                        children: [
                          Positioned(
                            top: -173,
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: WebViewX(
                              initialContent: file.embedLink,
                              initialSourceType: SourceType.url,
                              onWebViewCreated: (controller) =>
                                  webviewController = controller,
                              width: double.infinity,
                              height:
                                  MediaQuery.of(context).size.height * 0.85 +
                                      173,
                              onPageFinished: (src) {
                                setState(() {
                                  isLoading = false;
                                });
                              },
                              onWebResourceError: (error) {
                                setState(() {
                                  isLoading = false;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Text('gagal')
                  ],
                  if (embed["type"] == "image") ...[
                    CachedNetworkImage(
                      imageUrl: embed['url'],
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)),
                      ),
                      onPressed: () {
                        setState(() {
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                          Text("Close", style: TextStyle(color: Colors.white))
                        ],
                      ),
                    )
                  ]
                ],
              ),
            );
          },
        ),
      );
    },
  );
}
