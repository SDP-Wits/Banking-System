import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NewName extends StatefulWidget {
  @override
  NewNameState createState() => NewNameState();
}

class NewNameState extends State<NewName> {
  bool _hasInputError = false; //input error control variable
  String _name = ""; //name variable

  //function to check for invalid name
  bool hasInputError(String name) {
    if (name.length == 0) {
      return true;
    }
    return false;
  }

  //function to assign name
  void assignName(String name) {
    if (hasInputError(name) == false) {
      _name = name;
    }
  }

  String returnName() {
    return _name;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextField(
          onChanged: (value) {
            _hasInputError =
                hasInputError(value); //call validator to check for errors
            if (_hasInputError == false) {
              //if no errors, assign name
              assignName(value);
            }
            setState(() {});
          },
          style: TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            errorText: _hasInputError
                ? "Invalid Name"
                : null, //display text if errors present
            fillColor: Colors.transparent,
            hintText: 'First Name',
            hintStyle: TextStyle(fontSize: 16.0, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
