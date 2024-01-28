import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:padeprokan/components/utils/model/chat/space_message_model.dart';

class ChatTree extends StatefulWidget {
  String userId;
  SpaceMessageModel data;
  ChatTree({super.key, required this.userId, required this.data});

  @override
  State<ChatTree> createState() => _ChatTreeState();
}

class _ChatTreeState extends State<ChatTree> {
  @override
  Widget build(BuildContext context) {
    SpaceMessageModel data = widget.data;
    final bg = widget.userId != data.user["id"]
        ? Colors.white
        : Colors.greenAccent.shade100;
    final align = widget.userId != data.user["id"]
        ? MainAxisAlignment.start
        : MainAxisAlignment.end;
    bool avatarMe = widget.userId == data.user["id"];
    final radius = widget.userId != data.user["id"]
        ? const BorderRadius.only(
            topRight: Radius.circular(5.0),
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(5.0),
          )
        : const BorderRadius.only(
            topLeft: Radius.circular(5.0),
            bottomLeft: Radius.circular(5.0),
            bottomRight: Radius.circular(10.0),
          );
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 8, 5, 8),
      child: Row(
        mainAxisAlignment: align,
        children: [
          avatarMe
              ? Container()
              : ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: data.user["avatar"] ?? "",
                    width: 35.0,
                    height: 35.0,
                    fit: BoxFit.cover,
                  ),
                ),
          Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width / 0.75),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: .5,
                    spreadRadius: 1.0,
                    color: Colors.black.withOpacity(.12))
              ],
              color: bg,
              borderRadius: radius,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: data.isDeleted
                  ? const Text(
                      "This message has been deleted",
                      style: TextStyle(
                          color: Colors.grey, fontStyle: FontStyle.italic),
                    )
                  : Text(data.text),
            ),
          )
        ],
      ),
    );
  }
}
