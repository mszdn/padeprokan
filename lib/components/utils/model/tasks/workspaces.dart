import 'dart:convert';

WorkspacesModel workspacesModelFromJson(String str) =>
    WorkspacesModel.fromJson(json.decode(str));

String workspacesModelToJson(WorkspacesModel data) =>
    json.encode(data.toJson());

class WorkspacesModel {
  WorkspacesModel({
    required this.id,
    this.name,
    this.description,
    required this.boards,
    required this.students,
    required this.createdBy,
  });

  String id;
  dynamic name;
  dynamic description;
  List<Board> boards;
  List<Student> students;
  CreatedBy createdBy;

  factory WorkspacesModel.fromJson(Map<String, dynamic> json) =>
      WorkspacesModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        boards: List<Board>.from(json["boards"].map((x) => Board.fromJson(x))),
        students: List<Student>.from(
            json["students"].map((x) => Student.fromJson(x))),
        createdBy: CreatedBy.fromJson(json["createdBy"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "boards": List<dynamic>.from(boards.map((x) => x.toJson())),
        "students": List<dynamic>.from(students.map((x) => x.toJson())),
        "createdBy": createdBy.toJson(),
      };
}

class Board {
  Board({
    this.name,
    required this.id,
    this.background,
  });

  dynamic name;
  String id;
  dynamic background;

  factory Board.fromJson(Map<String, dynamic> json) => Board(
        name: json["name"] ?? "",
        id: json["id"] ?? "",
        background: json["background"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "background": background,
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
        id: json["id"] ?? "",
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user.toJson(),
      };
}

class User {
  User({
    this.avatar,
    required this.id,
    this.firstName,
  });

  dynamic avatar;
  String id;
  dynamic firstName;

  factory User.fromJson(Map<String, dynamic> json) => User(
        avatar: json["avatar"] ?? "",
        id: json["id"] ?? "",
        firstName: json["firstName"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "avatar": avatar,
        "id": id,
        "firstName": firstName,
      };
}
