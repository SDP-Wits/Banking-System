// coverage:ignore-start
import 'package:flutter/material.dart';

import '../registration.functions.dart';

class NewSurname extends StatefulWidget {
  @override
  NewSurnameState createState() => NewSurnameState();
}

class NewSurnameState extends State<NewSurname> {
  bool _hasInputError = false; //input error control variable
  String _surname = ""; //surname variable

  String returnSurName() {
    return _surname;
  }

  //function to assign name
  void assignSurname(String surname) {
    if (hasInputErrorSurname(surname) == false) {
      _surname = surname;
    }
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
            _hasInputError = hasInputErrorSurname(
                value); //call validator to check for errors
            if (_hasInputError == false) {
              //if no errors, assign surname
              assignSurname(value);
              Data.surname = value;
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
                ? "Invalid Surname"
                : null, //display text if errors present
            fillColor: Colors.transparent,
            hintText: 'Last Name',
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
bool hasInputErrorSurname(String surname) {
  if (surname.length == 0) {
    return true;
  }
  return false;
}
