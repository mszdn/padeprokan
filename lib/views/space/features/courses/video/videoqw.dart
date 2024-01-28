import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:padeprokan/components/organisms/appBar/appbar_widget.dart';

// import 'package:padeprokan/views/space/features/courses/slide.dart';
import 'package:webview_flutter/webview_flutter.dart';
// import 'package:webviewx/webviewx.dart';

class VideoQwPage extends StatefulWidget {
  final ValueNotifier<String> embed;
  late WebViewController? webViewController;
  // late WebViewXController? webviewController;
  VideoQwPage({super.key, required this.embed, this.webViewController});

  @override
  State<VideoQwPage> createState() => _VideoQwPageState();
}

class _VideoQwPageState extends State<VideoQwPage> {
  late WebViewController webViewController;
  String a = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.embed.addListener(() {
      a = widget.embed.value;
      setState(() {
        webViewController.loadUrl(a);
      });
      // setState(() {
      //   webviewController.loadContent(
      //     a,
      //     SourceType.url,
      //   );
      // });
    });
    widget.embed.addListener(() => print("ppe"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 205,
            width: MediaQuery.of(context).size.width,
            child: WebView(
              initialUrl: widget.embed.value,
              onWebViewCreated: (controller) => webViewController = controller,
              javascriptMode: JavascriptMode.unrestricted,
            ),
            //     WebViewX(
            //   initialContent: 'tekan tombol untuk memulai video',
            //   initialSourceType: SourceType.html,
            //   width: 100,
            //   height: 100,
            //   onWebViewCreated: (controller) => webviewController = controller,
            // ),
          ),
        ],
      ),
    );
  }
}
