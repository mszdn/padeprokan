
import 'package:flutter/material.dart';

Future<void> miniConfirmationModal(BuildContext context, handleConfirmation) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.transparent,
                side: const BorderSide(
                  color: Colors.grey,
                )),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              handleConfirmation;
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text("Ok", style: TextStyle(color: Colors.white)),
          )
        ],
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: const [
                Icon(
                  Icons.question_mark_rounded,
                  color: Colors.orange,
                ),
                Flexible(
                  child: Text(
                    "The action cannot be undo",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
