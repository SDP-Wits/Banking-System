import 'package:flutter/material.dart';

class VerifyUsersTitle extends StatefulWidget {
  @override
  VerifyUsersTitleState createState() => VerifyUsersTitleState();
}

class VerifyUsersTitleState extends State<VerifyUsersTitle> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, bottom: 20),
      child: RotatedBox(
          quarterTurns: -1,
          child: Text(
            'Verify Users',
            style: TextStyle(
              color: Colors.white,
              fontSize: 38,
              fontWeight: FontWeight.w900,
            ),
          )),
    );
  }
}