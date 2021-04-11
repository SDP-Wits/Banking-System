import 'package:flutter/material.dart';

class Logo extends StatefulWidget {
  @override
  LogoState createState() => LogoState();
}

class LogoState extends State<Logo> {
  @override
  Widget build(BuildContext context) {
    return Image.asset('logo1.png');
  }
}
