// To parse this JSON data, do
//
//     final spaceMessageModel = spaceMessageModelFromJson(jsonString);

import 'dart:convert';

SpaceMessageModel spaceMessageModelFromJson(String str) =>
    SpaceMessageModel.fromJson(json.decode(str));

String spaceMessageModelToJson(SpaceMessageModel data) =>
    json.encode(data.toJson());

class SpaceMessageModel {
  SpaceMessageModel({
    this.id,
    this.text,
    this.parentMessage,
    this.type,
    this.createdAt,
    this.isDeleted,
    this.files,
    this.user,
  });

  dynamic id;
  dynamic text;
  dynamic parentMessage;
  dynamic type;
  dynamic createdAt;
  dynamic isDeleted;
  dynamic files;
  dynamic user;

  factory SpaceMessageModel.fromJson(Map<String, dynamic> json) =>
      SpaceMessageModel(
        id: json["id"],
        text: json["text"],
        parentMessage: json["parentMessage"],
        type: json["type"],
        createdAt: json["createdAt"],
        isDeleted: json["isDeleted"],
        files: json["files"],
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "parentMessage": parentMessage,
        "type": type,
        "createdAt": createdAt,
        "isDeleted": isDeleted,
        "files": files,
        "user": user,
      };
}
