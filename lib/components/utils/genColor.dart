import 'package:flutter/material.dart';

Color genColor(str) {
  int hex = intToRGB(hashCode(str));

  return Color(hex);
}

dynamic hashCode(str) {
  var hash = 0;
  for (var i = 0; i < str.length; i++) {
    hash = str.codeUnitAt(i) + ((hash << 5) - hash);
  }
  return hash;
}

dynamic intToRGB(i) {
  String c = (i & 0x00FFFFFF).toRadixString(16).toUpperCase();
  double multiplier = .5;
  int d = (multiplier * c.length).round();
  String a = "${"00000".substring(0, 6 - d)}$c";

  return int.parse("0xffb${a.substring(a.length - 6)}");
}
