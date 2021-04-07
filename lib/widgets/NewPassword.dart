import 'package:flutter/material.dart';
import 'package:last_national_bank/widgets/NewPassword.dart';
import 'package:last_national_bank/widgets/NewPassword2.dart';


class PasswordInput extends StatefulWidget {
  @override
    PasswordInputState createState() => PasswordInputState();
}

class PasswordInputState extends State<PasswordInput> {
  bool _hasInputError = false; //error control variable
  String _password = "";//password variable
  String password2 = PasswordInput2State().returnpassword();
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

  String getPassword(){
  return _password;
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
              _password = value; //assign password if no errors present
            }
            setState(() {});
          },
          style: TextStyle(
            color: Colors.white,
          ),
          obscureText: true,
          decoration: InputDecoration(
            errorText: _hasInputError ? "Invalid Password": null, //text if password has errors
            fillColor: Colors.transparent,
            hintText: 'Password',
            hintStyle: TextStyle(fontSize: 16.0, color: Colors.white),
            icon: Icon(Icons.lock_rounded, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
