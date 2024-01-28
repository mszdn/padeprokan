import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:webviewx/webviewx.dart';

class ArticlePage extends StatefulWidget {
  final ValueNotifier<dynamic> article;

  const ArticlePage({super.key, required this.article});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  late WebViewXController webViewController;

  @override
  void initState() {
    super.initState();
    // print("${widget.article.value.toString()} asdsdsd");

    widget.article.addListener(() {
      // setState(() {
      webViewController.loadContent(
          widget.article.value["markdown"].toString(), SourceType.html);
      // });
    });
    // setState(() {
    //   Timer(const Duration(seconds: 1), () {
    // webViewController?.loadContent(
    //     widget.article["markdown"], SourceType.html);
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: widget.article.value["createdBy"]["avatar"]
                          .toString(),
                      imageBuilder: (context, imageProvider) => Container(
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    children: [
                      Text(
                        widget.article.value["createdBy"]["firstName"],
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                )
              ],
            ),
            Text(
              widget.article.value["title"].toString(),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            WebViewX(
              initialContent: widget.article.value["markdown"].toString(),
              initialSourceType: SourceType.html,
              height: 160,
              width: MediaQuery.of(context).size.width - 10,
              onWebViewCreated: (controller) => webViewController = controller,
            ),

            // if (result.data != null) ...[
            //   // Text(result.data!["course"][""]["title"] ?? ""),
            //   ...result.data!["course"]["sections"]!.map((v) {
            //     return Container(
            //       margin: const EdgeInsets.only(
            //         bottom: 20.0,
            //       ),
            //       width: MediaQuery.of(context).size.width,
            //       child: Column(
            //         children: [
            //           // Text(v["title"] ?? ""),
            //           ...v["lectures"].map((c) {
            //             return Container(
            //               width: double.infinity * 0.8,
            //               padding: const EdgeInsets.all(8),
            //               child: Column(
            //                 children: [
            //                   Row(
            //                     children: [
            //                       Text(
            //                         c["article"] != null
            //                             ? c["article"]["title"] ?? ""
            //                             : "",
            //                         style: const TextStyle(
            //                           fontSize: 20,
            //                           fontWeight: FontWeight.w500,
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                   const SizedBox(
            //                     height: 10,
            //                   ),
            //                   Row(
            //                     children: [
            //                       const CircleAvatar(
            //                         backgroundImage: NetworkImage(
            //                           // c["article"]!["createdBy"]["avatar"] ??
            //                           "",
            //                           // 'https://via.placeholder.com/150',
            //                         ),
            //                         // backgroundColor: Colors.red,
            //                       ),
            //                       const SizedBox(
            //                         width: 7,
            //                       ),
            //                       Row(
            //                         children: const [
            //                           // ...coba.map((ID) {
            //                           //   return Text(
            //                           //       ID['id'].toString());
            //                           // })
            //                           Text(
            //                             // c["article"]!["createdBy"]
            //                             //         ["firstName"] ??
            //                             "",
            //                             style: TextStyle(fontSize: 16),
            //                           ),
            //                         ],
            //                       ),
            //                     ],
            //                   ),
            //                   const SizedBox(
            //                     height: 7,
            //                   ),
            //                   const Text(
            //                     // c["article"]["markdown"]
            //                     //     .toString()
            //                     //     .replaceAll(exp, ""),
            //                     "",
            //                     style: TextStyle(fontSize: 15),
            //                   ),
            //                 ],
            //               ),
            //             );
            //           })
            //         ],
            //       ),
            //     );
            //   })
            // ]
          ],
        ),
      ),
    ));
  }
}
