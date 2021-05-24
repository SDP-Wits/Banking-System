// coverage:ignore-start
import 'package:flutter/material.dart';

import '../login.functions.dart';
import '../login.helpers.dart';

class PasswordInput extends StatefulWidget {
  @override
  PasswordInputState createState() => PasswordInputState();
  final TextEditingController passwordController;
  PasswordInput(this.passwordController);
}

class PasswordInputState extends State<PasswordInput> {
  bool _hasInputError = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextField(
          controller: passwordController,
          onChanged: (value) {
            setState(() {
              _hasInputError = hasInputErrorsPassword(value);
            });
          },
          style: TextStyle(
            color: Colors.white,
          ),
          obscureText: true,
          decoration: InputDecoration(
            /*focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black26, width: 2.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1.0),
            ),*/
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
// coverage:ignore-end
