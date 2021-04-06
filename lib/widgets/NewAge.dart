import 'package:flutter/material.dart';

class NewAge extends StatefulWidget {
  @override
  NewAgeState createState() => NewAgeState();
}

class NewAgeState extends State<NewAge> {
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
            hintText: 'Age',
            hintStyle: TextStyle(fontSize: 16.0, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
