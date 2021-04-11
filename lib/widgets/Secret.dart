import 'package:flutter/material.dart';
import 'package:last_national_bank/core/registration/registration.functions.dart';

class SecretKey extends StatefulWidget {
  @override
  _SecretKeyState createState() => _SecretKeyState();
}

class _SecretKeyState extends State<SecretKey> {
  @override
  String key = "";
  bool _haserrors = false;
  bool hasInputErrors(String skey) {
    if (skey.length == 0) {
      return true;
    } else {
      return false;
    }
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextField(
          onChanged: (value) {
            _haserrors = hasInputErrors(value);
            if (hasInputErrors(value) == false) {
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
