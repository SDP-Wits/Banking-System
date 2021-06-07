// coverage:ignore-start

import 'package:flutter/material.dart';
import 'package:last_national_bank/config/routes/router.dart';

Future<void> goToTimelineDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Go To Timeline?'),
        content: Text("Do you want to go to the Timeline?"),
        actions: <Widget>[
          TextButton(
            child: const Text('Yes'),
            onPressed: () {
              Navigator.pop(context);
              goToTimeline(context);
            },
          ),
          TextButton(
            child: const Text('No'),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      );
    },
  );
}

// coverage:ignore-end
