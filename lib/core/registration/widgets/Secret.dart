// coverage:ignore-start

import 'package:flutter/material.dart';

import '../registration.functions.dart';

class SecretKey extends StatefulWidget {
  final double width;

  SecretKey(this.width);

  @override
  _SecretKeyState createState() => _SecretKeyState();
}

class _SecretKeyState extends State<SecretKey> {
  @override
  String key = "";
  bool _haserrors = true;

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
      child: Container(
        height: 60,
        width: this.widget.width,
        child: TextField(
          onChanged: (value) {
            _haserrors = hasInputErrorsSecret(value);
            if (hasInputErrorsSecret(value) == false) {
              //check if password has errors
              key = value;
              Data.secretKey = value; //assign password if no errors present
            }
            setState(() {});
          },
          style: TextStyle(
            color: Colors.white,
          ),
          obscureText: true,
          decoration: InputDecoration(
            errorText: _haserrors
                ? "Invalid Secret Key"
                : null, //error text if password is invalid
            fillColor: Colors.transparent,
            hintText: 'Secret Key',
            hintStyle: TextStyle(fontSize: 16.0, color: Colors.white),
            icon: Icon(Icons.vpn_key_rounded, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

bool hasInputErrorsSecret(String skey) {
  if (skey.trim().length == 0) {
    return true;
  } else {
    return false;
  }
}
// coverage:ignore-end
