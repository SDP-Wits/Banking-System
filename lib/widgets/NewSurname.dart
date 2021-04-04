import 'package:flutter/material.dart';

class NewSurname extends StatefulWidget {
  @override
  NewSurnameState createState() => NewSurnameState();
}

class NewSurnameState extends State<NewSurname> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextField(
          style: TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            fillColor: Colors.transparent,
            hintText: 'Last Name',
            hintStyle: TextStyle(fontSize: 16.0, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
