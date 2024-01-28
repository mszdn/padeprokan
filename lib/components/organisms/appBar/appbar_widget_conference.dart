import 'package:flutter/material.dart';
import 'package:padeprokan/components/utils/theme_colors.dart';

AppBar AppbarConference() {
  return AppBar(
    backgroundColor: Colors.white,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () {
        
      },
    ),
    title: const Align(alignment: Alignment.center, child: Text('Conference')),
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.notifications),
      ),
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.person),
      ),
    ],
  );
}
