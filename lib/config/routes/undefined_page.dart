import 'package:flutter/material.dart';

class UndefinedPage extends StatelessWidget {
  //TODO: Testing
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
