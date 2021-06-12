// coverage:ignore-start
import 'package:flutter/material.dart';

class Logo extends StatefulWidget {
  @override
  LogoState createState() => LogoState();
}

class LogoState extends State<Logo> {
  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/images/logo1.png');
  }
}

// coverage:ignore-end
