import 'package:flutter/material.dart';

class PasswordInput2 extends StatefulWidget {
  @override
  _PasswordInput2State createState() => _PasswordInput2State();
}

class _PasswordInput2State extends State<PasswordInput2> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextField(
          style: TextStyle(
            color: Colors.white,
          ),
          obscureText: true,
          decoration: InputDecoration(
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
