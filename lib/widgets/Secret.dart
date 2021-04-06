import 'package:flutter/material.dart';

class SecretKey extends StatefulWidget {
  @override
  _SecretKeyState createState() => _SecretKeyState();
}

class _SecretKeyState extends State<SecretKey> {
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
            hintText: 'Secret Key',
            hintStyle: TextStyle(fontSize: 16.0, color: Colors.white),
            icon: Icon(Icons.vpn_key_rounded, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
