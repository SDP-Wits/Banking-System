import 'package:flutter/material.dart';

import '../registration.functions.dart';

class PasswordInput2 extends StatefulWidget {
  @override
  PasswordInput2State createState() => PasswordInput2State();
}

class PasswordInput2State extends State<PasswordInput2> {
  bool _hasInputError = false; //error control variable
  String _password2 = ""; //password variable
  // this is the first password from the first password input

  bool hasInputErrors(String passwordVal) {
    if (Data.password1 != passwordVal) {
      // Fluttertoast.showToast(
      //     msg: Data.p,
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.CENTER,
      //     timeInSecForIosWeb: 3,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.white,
      //     fontSize: 16.0);

      //check if password length is correct
      return true;
    }
    return false;
  }

  String returnpassword2() {
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
          onChanged: (value) {
            _hasInputError = hasInputErrors(value);
            if (_hasInputError == false) {
              //check if password has errors
              _password2 = value;
              Data.password2 = value; //assign password if no errors present
            }
            setState(() {});
          },
          style: TextStyle(
            color: Colors.white,
          ),
          obscureText: true,
          decoration: InputDecoration(
            errorText: _hasInputError
                ? "Passwords do not match"
                : null, //error text if password is invalid
            fillColor: Colors.transparent,
            hintText: 'Password confirmation',
            hintStyle: TextStyle(fontSize: 16.0, color: Colors.white),
            helperText:
                'Must contain: Minimum 1 Upper case, Minimum 1 lowercase, Minimum 1 Numeric Number, Minimum 1 Special Character',
            helperStyle: TextStyle(fontSize: 12.0, color: Colors.white),
            icon: Icon(Icons.lock_rounded, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
