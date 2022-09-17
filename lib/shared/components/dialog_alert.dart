import 'package:flutter/material.dart';

Future<dynamic> alertMessage(
    BuildContext context, String title, Widget content, yesFun) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18.0,
        ),
      ),
      content: content,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(ctx).pop();
          },
          child: Text(
            'Cancel',
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
        ),
        TextButton(
          onPressed: yesFun,
          child: Text(
            'Yes',
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
        ),
      ],
    ),
  );
}
