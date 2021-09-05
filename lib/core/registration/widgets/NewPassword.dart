// coverage:ignore-start
import 'package:flutter/material.dart';

import '../registration.functions.dart';

class PasswordInput extends StatefulWidget {
  final double width;

  PasswordInput(this.width);

  @override
  PasswordInputState createState() => PasswordInputState();
}

class PasswordInputState extends State<PasswordInput> {
  bool _isHidden = true;
  bool _hasInputError = false; //error control variable
  String _password = ""; //password variable
  //String password2 = PasswordInput2State().returnpassword();

  String getPassword() {
    return _password;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
      child: Container(
        height: 100,
        width: this.widget.width,
        child: TextField(
          onChanged: (value) {
            _hasInputError = hasInputErrorsPassword1(value);
            if (_hasInputError == false) {
              //check if password has errors
              _password = value; //assign
              Data.password1 = value;
              setCheck(true);
            } else {
              setCheck(false);
            }
            setState(() {});
          },
          style: TextStyle(
            color: Colors.white,
          ),
          obscureText: _isHidden,
          decoration: InputDecoration(
            errorText: _hasInputError
                ? "Invalid Password"
                : null, //text if password has errors
            fillColor: Colors.transparent,
            hintText: 'Password',
            hintStyle: TextStyle(fontSize: 16.0, color: Colors.white),
            helperText:
                'Password must contain:\nMin 1 Upper case,\nMin 1 lowercase,\nMin 1 Number,\nMin 1 Special Character',
            helperStyle: TextStyle(fontSize: 12.0, color: Colors.white),
            suffix: InkWell(
              onTap: _togglePasswordView,
              child: Icon(
                _isHidden ? Icons.visibility_off : Icons.visibility,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}

// coverage:ignore-end