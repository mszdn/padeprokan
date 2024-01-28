import 'dart:async';
import 'dart:convert';

import 'package:padeprokan/components/utils/model/chat/space_message_model.dart';

class ChatStream {
  List<SpaceMessageModel> _messages = <SpaceMessageModel>[];

  ChatStream() {
    messageStreamController.sink.add(_messages);
  }

  final StreamController<List<SpaceMessageModel>> messageStreamController =
      StreamController<List<SpaceMessageModel>>();

  Stream<List<SpaceMessageModel>> get messageStream =>
      messageStreamController.stream;

  void fetchMore(List data) {
    for (var element in data) {
      _messages.add(spaceMessageModelFromJson(json.encode(element)));
    }

    _messages = _messages
        .map((item) => jsonEncode(item))
        .toList()
        .toSet()
        .toList()
        .map<SpaceMessageModel>((item) => spaceMessageModelFromJson(item))
        .toList();
        _messages.sort((m1, m2) => m2.createdAt
                                          .toString()
                                          .compareTo(m1.createdAt.toString()));
    messageStreamController.sink.add(_messages);
  }

  void fetchMessageAdded(data) {
    _messages.insert(0, spaceMessageModelFromJson(json.encode(data)));

    _messages = _messages
        .map((item) => jsonEncode(item))
        .toList()
        .toSet()
        .toList()
        .map<SpaceMessageModel>((item) => spaceMessageModelFromJson(item))
        .toList();
        _messages.sort((m1, m2) => m2.createdAt
                                          .toString()
                                          .compareTo(m1.createdAt.toString()));
    messageStreamController.sink.add(_messages);
  }

  void closeStream() {
    messageStreamController.close();
  }
}
