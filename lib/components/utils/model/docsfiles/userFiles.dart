// To parse this JSON data, do
//
//     final userFileModel = userFileModelFromJson(jsonString);

import 'dart:convert';

UserFileModel userFileModelFromJson(String str) =>
    UserFileModel.fromJson(json.decode(str));

String userFileModelToJson(UserFileModel data) => json.encode(data.toJson());

class UserFileModel {
  UserFileModel({
    required this.id,
    this.title,
    this.type,
    this.url,
    this.owncloudUrl,
    this.embedLink,
    this.downloadUrl,
    this.path,
    required this.createdBy,
  });

  String id;
  dynamic title;
  dynamic type;
  dynamic url;
  dynamic owncloudUrl;
  dynamic embedLink;
  dynamic downloadUrl;
  dynamic path;
  CreatedBy createdBy;

  factory UserFileModel.fromJson(Map<String, dynamic> json) => UserFileModel(
        id: json["id"],
        title: json["title"],
        type: json["type"],
        url: json["url"],
        owncloudUrl: json["owncloudUrl"],
        embedLink: json["embedLink"],
        downloadUrl: json["downloadUrl"],
        path: json["path"],
        createdBy: CreatedBy.fromJson(json["createdBy"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "type": type,
        "url": url,
        "owncloudUrl": owncloudUrl,
        "embedLink": embedLink,
        "downloadUrl": downloadUrl,
        "path": path,
        "createdBy": createdBy.toJson(),
      };
}

class CreatedBy {
  CreatedBy({
    this.id,
  });

  dynamic id;

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
