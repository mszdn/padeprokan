// To parse this JSON data, do
//
//     final spacesModel = spacesModelFromJson(jsonString);

import 'dart:convert';

SpacesModel spacesModelFromJson(String str) =>
    SpacesModel.fromJson(json.decode(str));

String spacesModelToJson(SpacesModel data) => json.encode(data.toJson());

class SpacesModel {
  SpacesModel({
    required this.id,
    required this.name,
    this.needKyc,
    required this.students,
    required this.conferences,
    this.spaceMenu,
    required this.createdBy,
  });

  String id;
  String name;
  dynamic needKyc;
  List<Student> students;
  List<dynamic> conferences;
  dynamic spaceMenu;
  CreatedBy createdBy;

  factory SpacesModel.fromJson(Map<String, dynamic> json) => SpacesModel(
        id: json["id"],
        name: json["name"],
        needKyc: json["needKyc"],
        students: List<Student>.from(
            json["students"].map((x) => Student.fromJson(x))),
        conferences: List<dynamic>.from(json["conferences"].map((x) => x)),
        spaceMenu: json["spaceMenu"],
        createdBy: CreatedBy.fromJson(json["createdBy"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "needKyc": needKyc,
        "students": List<dynamic>.from(students.map((x) => x.toJson())),
        "conferences": List<dynamic>.from(conferences.map((x) => x)),
        "spaceMenu": spaceMenu,
        "createdBy": createdBy.toJson(),
      };
}

class CreatedBy {
  CreatedBy({
    required this.id,
  });

  String id;

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

class Student {
  Student({
    required this.id,
    required this.user,
  });

  String id;
  User user;

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        id: json["id"],
        // user: User.fromJson(json["user"]),
        user: User(firstName: json["firstName"] , id: json["id"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user.toJson(),
      };
}

class User {
  User({
    required this.firstName,
    required this.id,
    this.avatar,
  });

  String? firstName;
  String id;
  dynamic avatar;

  factory User.fromJson(Map<String, dynamic> json) => User(
        firstName: json["firstName"] ?? "",
        id: json["id"] ?? "",
        avatar: json["avatar"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "id": id,
        "avatar": avatar,
      };
}
