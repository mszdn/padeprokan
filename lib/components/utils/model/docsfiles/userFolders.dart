// To parse this JSON data, do
//
//     final userFolderModel = userFolderModelFromJson(jsonString);

import 'dart:convert';

UserFolderModel userFolderModelFromJson(String str) =>
    UserFolderModel.fromJson(json.decode(str));

String userFolderModelToJson(UserFolderModel data) =>
    json.encode(data.toJson());

class UserFolderModel {
  UserFolderModel({
    required this.id,
    this.title,
    required this.userFiles,
  });

  String id;
  dynamic title;
  List<UserFile> userFiles;

  factory UserFolderModel.fromJson(Map<String, dynamic> json) =>
      UserFolderModel(
        id: json["id"],
        title: json["title"],
        userFiles: List<UserFile>.from(
            json["userFiles"].map((x) => UserFile.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "userFiles": List<dynamic>.from(userFiles.map((x) => x.toJson())),
      };
}

class UserFile {
  UserFile({
    this.url,
    this.title,
    this.type,
    this.owncloudUrl,
    this.embedLink,
    this.downloadUrl,
    this.path,
  });

  dynamic url;
  dynamic title;
  dynamic type;
  dynamic owncloudUrl;
  dynamic embedLink;
  dynamic downloadUrl;
  dynamic path;

  factory UserFile.fromJson(Map<String, dynamic> json) => UserFile(
        url: json["url"],
        title: json["title"],
        type: json["type"],
        owncloudUrl: json["owncloudUrl"],
        embedLink: json["embedLink"],
        downloadUrl: json["downloadUrl"],
        path: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "title": title,
        "type": type,
        "owncloudUrl": owncloudUrl,
        "embedLink": embedLink,
        "downloadUrl": downloadUrl,
        "path": path,
      };
}
