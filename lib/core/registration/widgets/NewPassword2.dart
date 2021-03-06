// coverage:ignore-start
import 'package:flutter/material.dart';

import '../registration.functions.dart';

class PasswordInput2 extends StatefulWidget {
  final double width;

  PasswordInput2(this.width);

  @override
  PasswordInput2State createState() => PasswordInput2State();
}

class PasswordInput2State extends State<PasswordInput2> {
  bool _isHidden = true;
  bool _hasInputError = false; //error control variable
  String _password2 = ""; //password variable
  // this is the first password from the first password input

  String returnpassword2() {
    return _password2;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
      child: Container(
        height: 60,
        width: this.widget.width,
        child: TextField(
          obscureText: _isHidden,
          onChanged: (value) {
            _hasInputError = hasInputErrorsPassword2(value);
            if (_hasInputError == false) {
              //check if password has errors
              _password2 = value;
              Data.password2 = value;
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
                ? "Passwords do not match"
                : null, //error text if password is invalid
            fillColor: Colors.transparent,
            hintText: 'Password confirmation',
            hintStyle: TextStyle(fontSize: 16.0, color: Colors.white),
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
