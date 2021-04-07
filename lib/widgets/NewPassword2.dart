import 'package:flutter/material.dart';
import 'package:last_national_bank/widgets/NewPassword.dart';
import 'package:last_national_bank/widgets/NewPassword2.dart';

class PasswordInput2 extends StatefulWidget {
  @override
  PasswordInput2State createState() => PasswordInput2State();
}

class PasswordInput2State extends State<PasswordInput2> {
  bool _hasInputError = false; //error control variable
  String _password2 = "";//password variable
  String password1 = PasswordInputState().getPassword(); // this is the first password from the first password input
  bool hasInputErrors(String password){
    if (password.length < 8 || password.length > 20){ //check if password length is correct
      return true;
    }
    if (password.length >= 8 && password.length <= 20){ //check if password contains uppercase, lowercase letters, number, special characters
      String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
      RegExp regExp = new RegExp(pattern);
      return !regExp.hasMatch(password);
    }
    return false;
  }
  String returnpassword(){
  return _password2;
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
            _hasInputError = hasInputErrors(value);
            if (_hasInputError == false){ //check if password has errors
              _password2 = value; //assign password if no errors present
            }
            setState(() {});
          },
          style: TextStyle(
            color: Colors.white,
          ),
          obscureText: true,
          decoration: InputDecoration(
            errorText: _hasInputError ? "Invalid Second Password": null, //error text if password is invalid
            fillColor: Colors.transparent,
            hintText: 'Password confirmation',
            hintStyle: TextStyle(fontSize: 16.0, color: Colors.white),
            icon: Icon(Icons.lock_rounded, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
