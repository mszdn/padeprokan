import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<String> getUserToken() async {
  final pref = await SharedPreferences.getInstance();
  final token = pref.getString("token");
  return token ?? "";
}

Future<GetUserData> getUserDataFromJson() async {
  final pref = await SharedPreferences.getInstance();
  final body = pref.getString("user");
  return GetUserData.fromJson(json.decode(body ?? ""));
}

String getUserDataToJson(GetUserData data) => json.encode(data.toJson());

class GetUserData {
  GetUserData({
    this.address,
    required this.avatar,
    this.cardId,
    required this.email,
    required this.firstName,
    required this.id,
    this.phone,
    required this.role,
    required this.studentId,
    this.selfie,
  });

  dynamic address;
  dynamic avatar;
  dynamic cardId;
  String email;
  String firstName;
  String id;
  dynamic phone;
  String role;
  String studentId;
  dynamic selfie;

  factory GetUserData.fromJson(Map<String, dynamic> json) => GetUserData(
        address: json["address"],
        avatar: json["avatar"],
        cardId: json["cardId"],
        email: json["email"],
        firstName: json["firstName"],
        id: json["id"],
        phone: json["phone"],
        role: json["role"],
        studentId: json["studentId"].toString(),
        selfie: json["selfie"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "avatar": avatar,
        "cardId": cardId,
        "email": email,
        "firstName": firstName,
        "id": id,
        "phone": phone,
        "role": role,
        "studentId": studentId,
        "selfie": selfie,
      };
}
