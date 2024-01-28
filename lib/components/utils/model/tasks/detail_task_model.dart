import 'dart:convert';

AllBoardsCardsModel allBoardsCardsModelFromJson(String str) => AllBoardsCardsModel.fromJson(json.decode(str));

String allBoardsCardsModelToJson(AllBoardsCardsModel data) => json.encode(data.toJson());

class AllBoardsCardsModel {
    AllBoardsCardsModel({
        this.card,
    });

    Card? card;

    factory AllBoardsCardsModel.fromJson(Map<String, dynamic> json) => AllBoardsCardsModel(
        card: json["card"] == null ? null : Card.fromJson(json["card"]),
    );

    Map<String, dynamic> toJson() => {
        "card": card?.toJson(),
    };
}

class Card {
    Card({
        this.id,
        this.name,
        this.description,
        this.isDone,
        this.duedate,
        this.cover,
        this.attachments,
        this.checklists,
        this.cardLabels,
        this.students,
        this.posts,
    });

    String? id;
    dynamic name;
    dynamic description;
    dynamic isDone;
    dynamic duedate;
    Cover? cover;
    List<Attachment>? attachments;
    List<Checklist>? checklists;
    List<CardLabel>? cardLabels;
    List<Student>? students;
    List<Post>? posts;

    factory Card.fromJson(Map<String, dynamic> json) => Card(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        isDone: json["isDone"],
        duedate: json["duedate"],
        cover: json["cover"] == null ? null : Cover.fromJson(json["cover"]),
        attachments: json["attachments"] == null ? [] : List<Attachment>.from(json["attachments"]!.map((x) => Attachment.fromJson(x))),
        checklists: json["checklists"] == null ? [] : List<Checklist>.from(json["checklists"]!.map((x) => Checklist.fromJson(x))),
        cardLabels: json["cardLabels"] == null ? [] : List<CardLabel>.from(json["cardLabels"]!.map((x) => CardLabel.fromJson(x))),
        students: json["students"] == null ? [] : List<Student>.from(json["students"]!.map((x) => Student.fromJson(x))),
        posts: json["posts"] == null ? [] : List<Post>.from(json["posts"]!.map((x) => Post.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "isDone": isDone,
        "duedate": duedate,
        "cover": cover?.toJson(),
        "attachments": attachments == null ? [] : List<dynamic>.from(attachments!.map((x) => x.toJson())),
        "checklists": checklists == null ? [] : List<dynamic>.from(checklists!.map((x) => x.toJson())),
        "cardLabels": cardLabels == null ? [] : List<dynamic>.from(cardLabels!.map((x) => x.toJson())),
        "students": students == null ? [] : List<dynamic>.from(students!.map((x) => x.toJson())),
        "posts": posts == null ? [] : List<dynamic>.from(posts!.map((x) => x.toJson())),
    };
}

class Attachment {
    Attachment({
        this.id,
        this.name,
        this.url,
        this.createdAt,
    });

    String? id;
    dynamic name;
    dynamic url;
    DateTime? createdAt;

    factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        id: json["id"],
        name: json["name"],
        url: json["url"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "url": url,
        "createdAt": createdAt?.toIso8601String(),
    };
}

class CardLabel {
    CardLabel({
        this.id,
        this.label,
    });

    String? id;
    Label? label;

    factory CardLabel.fromJson(Map<String, dynamic> json) => CardLabel(
        id: json["id"],
        label: json["label"] == null ? null : Label.fromJson(json["label"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "label": label?.toJson(),
    };
}

class Label {
    Label({
        this.id,
        this.color,
        this.title,
    });

    String? id;
    dynamic color;
    dynamic title;

    factory Label.fromJson(Map<String, dynamic> json) => Label(
        id: json["id"],
        color: json["color"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "color": color,
        "title": title,
    };
}

class Checklist {
    Checklist({
        this.id,
        this.name,
        this.listChecklists,
    });

    String? id;
    dynamic name;
    List<ListChecklist>? listChecklists;

    factory Checklist.fromJson(Map<String, dynamic> json) => Checklist(
        id: json["id"],
        name: json["name"],
        listChecklists: json["listChecklists"] == null ? [] : List<ListChecklist>.from(json["listChecklists"]!.map((x) => ListChecklist.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "listChecklists": listChecklists == null ? [] : List<dynamic>.from(listChecklists!.map((x) => x.toJson())),
    };
}

class ListChecklist {
    ListChecklist({
        this.id,
        this.title,
        this.status,
    });

    String? id;
    dynamic title;
    dynamic status;

    factory ListChecklist.fromJson(Map<String, dynamic> json) => ListChecklist(
        id: json["id"],
        title: json["title"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "status": status,
    };
}

class Cover {
    Cover({
        this.id,
        this.url,
    });

    String? id;
    dynamic url;

    factory Cover.fromJson(Map<String, dynamic> json) => Cover(
        id: json["id"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
    };
}

class Post {
    Post({
        this.id,
        this.text,
        this.createdAt,
        this.comments,
        this.createdBy,
    });

    String? id;
    dynamic text;
    DateTime? createdAt;
    List<Comment>? comments;
    CreatedBy? createdBy;

    factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        text: json["text"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        comments: json["comments"] == null ? [] : List<Comment>.from(json["comments"]!.map((x) => Comment.fromJson(x))),
        createdBy: json["createdBy"] == null ? null : CreatedBy.fromJson(json["createdBy"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "createdAt": createdAt?.toIso8601String(),
        "comments": comments == null ? [] : List<dynamic>.from(comments!.map((x) => x.toJson())),
        "createdBy": createdBy?.toJson(),
    };
}

class Comment {
    Comment({
        this.text,
        this.createdAt,
        this.createdBy,
    });

    dynamic text;
    DateTime? createdAt;
    CreatedBy? createdBy;

    factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        text: json["text"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        createdBy: json["createdBy"] == null ? null : CreatedBy.fromJson(json["createdBy"]),
    );

    Map<String, dynamic> toJson() => {
        "text": text,
        "createdAt": createdAt?.toIso8601String(),
        "createdBy": createdBy?.toJson(),
    };
}

class CreatedBy {
    CreatedBy({
        this.id,
        this.firstName,
        this.avatar,
    });

    String? id;
    dynamic firstName;
    dynamic avatar;

    factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
        id: json["id"],
        firstName: json["firstName"],
        avatar: json["avatar"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "avatar": avatar,
    };
}

class Student {
    Student({
        this.user,
    });

    CreatedBy? user;

    factory Student.fromJson(Map<String, dynamic> json) => Student(
        user: json["user"] == null ? null : CreatedBy.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
    };
}
