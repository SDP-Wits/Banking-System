import 'package:flutter/material.dart';

class NewPhone extends StatefulWidget {
  @override
  _NewPhoneState createState() => _NewPhoneState();
}

class _NewPhoneState extends State<NewPhone> {
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
          decoration: InputDecoration(
            fillColor: Colors.transparent,
            hintText: 'Phone Number',
            hintStyle: TextStyle(fontSize: 16.0, color: Colors.white),
            helperText: 'eg. 012 345 6789',
            helperStyle: TextStyle(fontSize: 12.0, color: Colors.white),
            icon: Icon(Icons.email_rounded, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
