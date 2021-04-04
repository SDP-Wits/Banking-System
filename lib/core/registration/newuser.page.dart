import 'package:flutter/material.dart';
import 'package:last_national_bank/widgets/NewAge.dart';
import 'package:last_national_bank/widgets/NewIDnum.dart';
import 'package:last_national_bank/widgets/NewSurname.dart';
import 'package:last_national_bank/widgets/NewLoc.dart';
import 'package:last_national_bank/widgets/buttonNewUser.dart';
import 'package:last_national_bank/widgets/newEmail.dart';
import 'package:last_national_bank/widgets/newName.dart';
import 'package:last_national_bank/widgets/password.dart';
import 'package:last_national_bank/widgets/Logo.dart';
import 'package:last_national_bank/widgets/textNew.dart';
import 'package:last_national_bank/widgets/userOld.dart';

class NewUser extends StatefulWidget {
  @override
  _NewUserState createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blueGrey, Colors.lightBlueAccent]),
        ),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    //Logo(),
                    TextNew(),
                  ],
                ),
                NewName(),
                NewSurname(),
                NewAge(),
                NewEmail(),
                NewIDnum(),
                NewLoc(),
                PasswordInput(),
                ButtonNewUser(),
                UserOld(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
