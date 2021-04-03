import 'package:flutter/material.dart';
import 'package:last_national_bank/utils/helpers/style.dart';

class RouteButtonCustom extends StatelessWidget {
  final String text;
  final Function goTo;

  RouteButtonCustom({required this.text, required this.goTo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(hPadding),
      color: Colors.grey[600],
      child: TextButton(
          onPressed: () => goTo(),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
            ),
          )),
    );
  }
}
