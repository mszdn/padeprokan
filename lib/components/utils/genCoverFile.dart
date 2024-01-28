import 'dart:convert';

import 'package:padeprokan/components/utils/model/docsfiles/userFiles.dart';

String genCoverFile(String? fileType, UserFileModel? file) {
  if (fileType != null && fileType != "" && file != null) {
    Map fileT = json.decode(fileType);
    String ext = fileT["ext"];

    // return "ss";

    if (ext == "google-spreadsheets") {
      return "assets/images/docsFiles/google-spreadsheets.svg";
    } else if (ext == "google-document") {
      return "assets/images/docsFiles/google-docs.svg";
    } else if (ext == "google-drive") {
      return "assets/images/docsFiles/google-drive.svg";
    } else if (ext == "google-slide") {
      return "assets/images/docsFiles/google-slide.svg";
    } else if (ext == "txt") {
      return "assets/images/docsFiles/file-txt.svg";
    } else if (ext == "simpanan-embed") {
      return "assets/images/docsFiles/simpanan-embed.svg";
    } else if (ext == "png" || ext == "svg" || ext == "jpg" || ext == "jpeg") {
      // print(file.path);
      // return "";
      if (file.downloadUrl != null && file.downloadUrl != "") {
        dynamic fileName = file.path.split("/").removeLast();
        dynamic owncloudUrlBare =
            file.downloadUrl.split("/").sublist(0, 3).join("/");
        dynamic owncloudPublic = file.downloadUrl.split("/")[4];
        print(fileName);
        print(owncloudUrlBare);
        print(owncloudPublic);
        // return "";
        // dynamic owncloudUrlBare =
        //     file.downloadUrl.split("/").slice(0, 3).join("/");
        // dynamic owncloudPublic = file.downloadUrl.split("/")[4];

        return "$owncloudUrlBare/index.php/apps/files_sharing/ajax/publicpreview.php?x=150&y=150&a=true&file=$fileName&t=$owncloudPublic&scalingup=0";
      } else {
        return "";
      }
    } else if (ext == "mp4" || ext == "mkv" || ext == "webm") {
      return "assets/images/docsFiles/video-play.svg";
    } else {
      return "assets/images/docsFiles/default-file.svg";
    }
  }
  return "";
}
