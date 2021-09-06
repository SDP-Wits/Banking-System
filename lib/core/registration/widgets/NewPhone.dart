// coverage:ignore-start
import 'package:flutter/material.dart';

import '../registration.functions.dart';

class NewPhone extends StatefulWidget {
  final double width;

  NewPhone(this.width);

  @override
  NewPhoneState createState() => NewPhoneState();
}

class NewPhoneState extends State<NewPhone> {
  bool _hasInputError = false; //error control variable
  String _phone = ""; //id number variable

  String returnPhone() {
    return _phone;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
      child: Container(
        height: 60,
        width: this.widget.width,
        child: TextField(
          onChanged: (value) {
            _hasInputError = hasInputErrorPhone(value);
            if (_hasInputError == false) {
              //check if phone number is valid
              _phone = value; //assign phone number if valid
              Data.phone = value;
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
                ? "Invalid Phone Number"
                : null, //error text if phone number is invalid
            fillColor: Colors.transparent,
            hintText: 'Phone Number',
            hintStyle: TextStyle(fontSize: 16.0, color: Colors.white),
            helperText: 'eg. 0123456789',
            helperStyle: TextStyle(fontSize: 12.0, color: Colors.white),
            prefixIcon: Icon(Icons.local_phone_rounded, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

// coverage:ignore-end