// coverage:ignore-start
import 'package:flutter/material.dart';

import '../registration.functions.dart';

class NewName extends StatefulWidget {
  @override
  NewNameState createState() => NewNameState();
}

class NewNameState extends State<NewName> {
  bool _hasInputError = false; //input error control variable
  String _name = ""; //name variable

  //function to assign name
  void assignName(String name) {
    if (hasInputErrorName(name) == false) {
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
                hasInputErrorName(value); //call validator to check for errors
            if (_hasInputError == false) {
              //if no errors, assign name
              assignName(value);
              Data.name = value;
              setCheck(true);
            } else {
              setCheck(false);
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
            prefixIcon: Icon(Icons.person, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

// coverage:ignore-end
//function to check for invalid name
bool hasInputErrorName(String name) {
  if (name.length == 0) {
    return true;
  }
  return false;
}
