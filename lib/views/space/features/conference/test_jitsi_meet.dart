import 'package:flutter/material.dart';
import 'package:padeprokan/components/organisms/appBar/appbar_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class MeetLauncher extends StatefulWidget {
  const MeetLauncher({super.key});

  @override
  State<MeetLauncher> createState() => _MeetLauncherState();
}

class _MeetLauncherState extends State<MeetLauncher> {

  var url = 'https://meet.jit.si/carakan';
  launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launch(url, forceWebView: true, enableJavaScript: true);
    } else {
      throw ' error launc $url';
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context, 'Conference'),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            launchUrl(url);
            // _launchMeeting(url: "$_url");
          },
          child: Text('Launc'),
        ),
      ),
    );
  }
}
