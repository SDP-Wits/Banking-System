import 'package:flutter/material.dart';

import '../registration.functions.dart';

class NewEmail extends StatefulWidget {
  @override
  NewEmailState createState() => NewEmailState();
}

class NewEmailState extends State<NewEmail> {
  bool _hasInputError = false; //error control variable
  String _email = ""; //email variable

  String returnEmail() {
    return _email;
  }

  //assign email if no errors present
  void assignEmail(String email) {
    if (hasInputErrorEmail(email) == false) {
      _email = email;
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
            _hasInputError =
                hasInputErrorEmail(value); //call validator to check for errors
            if (_hasInputError == false) {
              //if no errors, assign assign email
              assignEmail(value);
              Data.email = value;
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
                ? "Invalid Email Address"
                : null, //error text if email is invalid
            fillColor: Colors.transparent,
            hintText: 'Email',
            hintStyle: TextStyle(fontSize: 16.0, color: Colors.white),
            helperText: 'eg. JohnDoe@gmail.com',
            helperStyle: TextStyle(fontSize: 12.0, color: Colors.white),
            prefixIcon: Icon(Icons.email_rounded, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

//function to check if email is invalid
bool hasInputErrorEmail(String email) {
  if (email.length == 0) {
    return true;
  } else if (email.length > 0) {
    //Regular expression to check if email contains all necessary email components (@, .com, etc.)
    return !RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }
  return false;
}
