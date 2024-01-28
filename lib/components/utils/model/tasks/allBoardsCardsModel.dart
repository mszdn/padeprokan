// To parse this JSON data, do
//
//     final allBoardsCardsModel = allBoardsCardsModelFromJson(jsonString);

import 'dart:convert';

AllBoardsCardsModel allBoardsCardsModelFromJson(String str) =>
    AllBoardsCardsModel.fromJson(json.decode(str));

String allBoardsCardsModelToJson(AllBoardsCardsModel data) =>
    json.encode(data.toJson());

class AllBoardsCardsModel {
  AllBoardsCardsModel({
    required this.id,
    this.name,
    this.index,
    this.background,
    required this.cards,
  });

  String id;
  dynamic name;
  dynamic index;
  dynamic background;
  List<Card> cards;

  factory AllBoardsCardsModel.fromJson(Map<String, dynamic> json) =>
      AllBoardsCardsModel(
        id: json["id"],
        name: json["name"],
        index: json["index"],
        background: json["background"],
        cards: List<Card>.from(json["cards"].map((x) => Card.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "index": index,
        "background": background,
        "cards": List<dynamic>.from(cards.map((x) => x.toJson())),
      };
}

class Card {
  Card({
    required this.id,
    this.name,
    this.duedate,
    required this.index,
    this.isDone,
    this.cover,
  });

  String id;
  dynamic name;
  dynamic duedate;
  int index;
  dynamic isDone;
  dynamic cover;

  factory Card.fromJson(Map<String, dynamic> json) => Card(
        id: json["id"] ?? "",
        name: json["name"] ?? "",
        duedate: json["duedate"] ?? "",
        index: json["index"] ?? "",
        isDone: json["isDone"] ?? "",
        cover: json["cover"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "duedate": duedate,
        "index": index,
        "isDone": isDone,
        "cover": cover,
      };
}
