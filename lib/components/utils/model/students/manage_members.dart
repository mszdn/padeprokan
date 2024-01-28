// To parse this JSON data, do
//
//     final spaceStudentsModel = spaceStudentsModelFromJson(jsonString);

import 'dart:convert';

SpaceStudentsModel spaceStudentsModelFromJson(String str) =>
    SpaceStudentsModel.fromJson(json.decode(str));

String spaceStudentsModelToJson(SpaceStudentsModel data) =>
    json.encode(data.toJson());

class SpaceStudentsModel {
  SpaceStudentsModel({
    required this.id,
    required this.user,
  });

  String id;
  User user;

  factory SpaceStudentsModel.fromJson(Map<String, dynamic> json) =>
      SpaceStudentsModel(
        id: json["id"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user.toJson(),
      };
}

class User {
  User({
    this.firstName,
    this.lastName,
    required this.id,
    this.avatar,
    this.email
  });

  dynamic firstName;
  dynamic lastName;
  String id;
  dynamic avatar;
  dynamic email;

  factory User.fromJson(Map<String, dynamic> json) => User(
        firstName: json["firstName"],
        lastName: json["lastName"],
        id: json["id"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "id": id,
        "avatar": avatar,
      };
}

SpaceStudentsModelSearch spaceStudentsModelSearchFromJson(String str) =>
    SpaceStudentsModelSearch.fromJson(json.decode(str));

String spaceStudentsModelSearchToJson(SpaceStudentsModelSearch data) =>
    json.encode(data.toJson());

class SpaceStudentsModelSearch {
  SpaceStudentsModelSearch({
    this.id,
    this.firstName,
    this.email,
    this.avatar,
    this.studentId,
  });

  dynamic id;
  dynamic firstName;
  dynamic email;
  dynamic avatar;
  dynamic studentId;

  factory SpaceStudentsModelSearch.fromJson(Map<String, dynamic> json) =>
      SpaceStudentsModelSearch(
        id: json["id"],
        firstName: json["firstName"],
        email: json["email"],
        avatar: json["avatar"],
        studentId: json["studentId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "email": email,
        "avatar": avatar,
        "studentId": studentId,
      };
}
