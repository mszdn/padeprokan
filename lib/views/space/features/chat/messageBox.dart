import 'package:flutter/material.dart';
import 'package:padeprokan/model/messagesModel.dart';

class MessageBox extends StatefulWidget {
  final String message;
  final bool isMe;

  const MessageBox({super.key, required this.message, required this.isMe});

  @override
  State<MessageBox> createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  @override
  Widget build(BuildContext context) {
    if (widget.isMe) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 11,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 5, 1),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Icon(Icons.more_horiz),
                          IconButton(
                            icon: const Icon(Icons.more_horiz),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 125),
                          ),
                          Text(
                            widget.message,
                            style: const TextStyle(fontSize: 14),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  color: Colors.grey.shade200,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Icon(
                      //   Icons.more_horiz,
                      //   size: 18,
                      // ),
                      // Column(
                      //   children: [
                      //     IconButton(
                      //       icon: Icon(Icons.more_horiz),
                      //       onPressed: () {},
                      //     ),
                      //   ],
                      // ),
                      Text(
                        widget.message,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  color: Colors.grey.shade200,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Icon(
                      //   Icons.more_horiz,
                      //   size: 18,
                      // ),
                      // Column(
                      //   children: [
                      //     IconButton(
                      //       icon: Icon(Icons.more_horiz),
                      //       onPressed: () {},
                      //     ),
                      //   ],
                      // ),
                      Text(
                        widget.message,
                        style: const TextStyle(fontSize: 14),
                      ),
                      Text(
                        widget.message,
                        style: const TextStyle(fontSize: 14),
                      ),
                      Text(
                        widget.message,
                        style: const TextStyle(fontSize: 14),
                      ),
                      Text(
                        widget.message,
                        style: const TextStyle(fontSize: 14),
                      ),
                      Text(
                        widget.message,
                        style: const TextStyle(fontSize: 14),
                      ),
                      Text(
                        widget.message,
                        style: const TextStyle(fontSize: 14),
                      ),
                      Text(
                        widget.message,
                        style: const TextStyle(fontSize: 14),
                      ),
                      Text(
                        widget.message,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
