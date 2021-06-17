// coverage:ignore-start
import 'package:flutter/material.dart';

/*
When there is a route that does NOT exist,
this widget will show up
*/
class UndefinedPage extends StatelessWidget {
  final String name;

  UndefinedPage({required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("There is no page called $name"),
      ),
    );
  }
}
// coverage:ignore-end
