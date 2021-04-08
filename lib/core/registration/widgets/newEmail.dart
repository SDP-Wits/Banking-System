import 'package:flutter/material.dart';

class NewEmail extends StatefulWidget {
  @override
  NewEmailState createState() => NewEmailState();
}

class NewEmailState extends State<NewEmail> {
  bool _hasInputError = false; //error control variable
  String _email = ""; //email variable

  //function to check if email is invalid
  bool hasInputError(String email){
    if (email.length == 0){
      return true;
    }
    else if(email.length > 0){
      //Regular expression to check if email contains all necessary email components (@, .com, etc.)
      return !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
    }
    return false;
  }
  String returnEmail(){
  return _email;
}
  //assign email if no errors present
  void assignEmail(String email){
    if (hasInputError(email) == false){
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
          onSubmitted: (value) {
            _hasInputError = hasInputError(value);  //call validator to check for errors
            if (_hasInputError == false){ //if no errors, assign assign email
              assignEmail(value);
            }
            setState(() {});
          },
          style: TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            errorText: _hasInputError ? "Invalid Email Address": null, //error text if email is invalid
            fillColor: Colors.transparent,
            hintText: 'Email',
            hintStyle: TextStyle(fontSize: 16.0, color: Colors.white),
            helperText: 'eg. JohnDoe@gmail.com',
            helperStyle: TextStyle(fontSize: 12.0, color: Colors.white),
            icon: Icon(Icons.email_rounded, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
