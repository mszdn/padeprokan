import 'package:padeprokan/components/utils/model/docsfiles/userFiles.dart';
import 'dart:convert';

Map genEmbedFile(String? fileType, UserFileModel? file) {
  if (fileType != null && fileType != "" && file != null) {
    dynamic fileTypeMG = json.decode(fileType);
    String ext = fileTypeMG["ext"];

    List imageLisType = ["jpg", "jpeg", "img", "png", "svg"];
    List videoListType = ["mp4", "webm", "mkv", "mov"];

    if (imageLisType.contains(ext)) {
      dynamic fileName = file.path.split("/").removeLast();
      dynamic owncloudUrlBare =
          file.downloadUrl.split("/").sublist(0, 3).join("/");
      dynamic owncloudPublic = file.downloadUrl.split("/")[4];

      return {
        "type": "image",
        "url":
            "$owncloudUrlBare/index.php/apps/files_sharing/ajax/publicpreview.php?x=10000&y=100000&a=true&file=$fileName&t=$owncloudPublic&scalingup=0"
      };
    } else if (videoListType.contains(ext)) {
      return {"type": "video", "videoType": ext};
    } else {
      return {"type": "file", "url": file.owncloudUrl};
    }
  }
  return {"type": "video", "url": "https://www.youtube.com/embed/2JxJvBUjKLE"};
}
