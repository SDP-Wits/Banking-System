// coverage:ignore-start
import 'package:flutter/material.dart';

import '../registration.functions.dart';

class NewIDnum extends StatefulWidget {
  final double width;

  NewIDnum(this.width);

  @override
  NewIDnumState createState() => NewIDnumState();
}

class NewIDnumState extends State<NewIDnum> {
  bool _hasInputError = false; //error control variable
  String _idNum = ""; //id number variable

  String returnID() {
    return _idNum;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
      child: Container(
        height: 60,
        width: this.widget.width,
        child: TextField(
          maxLength: 13,
          onChanged: (value) {
            _hasInputError = hasInputErrorId(value);
            if (_hasInputError == false) {
              //check if id number is valid
              _idNum = value; //assign id number if valid
              Data.idnum = value;
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
                ? "Invalid ID Number"
                : null, //error text if errors present
            fillColor: Colors.transparent,
            hintText: 'ID number',
            hintStyle: TextStyle(fontSize: 16.0, color: Colors.white),
            prefixIcon: Icon(Icons.account_box_rounded, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

// coverage:ignore-end
