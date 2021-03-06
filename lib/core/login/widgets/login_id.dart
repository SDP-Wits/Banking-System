// coverage:ignore-start
import 'package:flutter/material.dart';

import '../login.helpers.dart';

/*
Input Filed for the ID Number that takes in a TextEditingController to be user in
login.functions.dart this is purely just for UI.
*/
class InputID extends StatefulWidget {
  final TextEditingController idController;
  InputID(this.idController);
  @override
  _InputIDState createState() => _InputIDState();
}

String inputText = "";
bool _hasInputError = false;

class _InputIDState extends State<InputID> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextField(
          maxLength: 13,
          controller: this.widget.idController,
          onChanged: (String idNumb) {
            _hasInputError = hasInputErrorID(idNumb);
          },
          style: TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            /*focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black26, width: 2.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1.0),
            ),*/
            fillColor: Colors.lightBlueAccent,
            hintText: 'ID Number',
            hintStyle: TextStyle(fontSize: 16.0, color: Colors.white),
            icon: Icon(Icons.account_box_rounded, color: Colors.white),
            labelStyle: TextStyle(
              color: Colors.white70,
            ),
          ),
        ),
      ),
    );
  }
}
// coverage:ignore-end
