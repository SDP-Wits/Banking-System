import 'package:flutter/material.dart';

import '../registration.functions.dart';

class NewIDnum extends StatefulWidget {
  @override
  NewIDnumState createState() => NewIDnumState();
}

class NewIDnumState extends State<NewIDnum> {
  bool _hasInputError = false; //error control variable
  String _idNum = ""; //id number variable

  bool hasInputError(String idNum) {
    if (idNum.length != 13) {
      //checks if id num is of length 13
      return true;
    }
    bool hasLetters = double.tryParse(idNum) !=
        null; //checks if id number contains any letters
    return !hasLetters;
  }

  String returnID() {
    return _idNum;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextField(
          onChanged: (value) {
            _hasInputError = hasInputError(value);
            if (_hasInputError == false) {
              //check if id number is valid
              _idNum = value; //assign id number if valid
              Data.idnum = value;
            }
            setState(() {});
          },
          style: TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            errorText: _hasInputError
                ? "Invalid ID Number"
                : null, //error text if errors present
            fillColor: Colors.transparent,
            hintText: 'ID number',
            hintStyle: TextStyle(fontSize: 16.0, color: Colors.white),
          ),
        ),
      ),
    );
  }
}