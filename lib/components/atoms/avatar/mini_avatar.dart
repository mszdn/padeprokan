import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:padeprokan/components/utils/genColor.dart';

Widget miniAvatar({String firstName = "N N", String? id, String? avatarUrl}) {
  List<String> names = firstName != "" && firstName.isNotEmpty
      ? firstName.split(" ").length == 1
          ? [firstName]
          : firstName.split(" ")
      : ["N", "N"];
  String initials = "";
  int numWords = 1;

  for (var i = 0; i < (names.length >= 2 ? 2 : numWords); i++) {
    initials += names[i] == "" ? "" : names[i][0];
  }

  return ClipOval(
    child: avatarUrl != null && avatarUrl != ""
        ? CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: avatarUrl,
            width: 40.0,
            height: 40.0,
          )
        : Center(
            child: Container(
              height: 40,
              width: 40,
              color: genColor(id),
              child: Center(
                  child: Text(
                initials.toUpperCase(),
                style: const TextStyle(color: Colors.white),
              )),
            ),
          ),
  );
}
