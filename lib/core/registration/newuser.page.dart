// TODO:turn this page into selector for admin or customer registration

import 'package:flutter/material.dart';
import 'package:last_national_bank/core/registration/widgets/NewAge.dart';
import 'package:last_national_bank/core/registration/widgets/NewIDnum.dart';
import 'package:last_national_bank/core/registration/widgets/NewLoc.dart';
import 'package:last_national_bank/core/registration/widgets/NewPassword.dart';
import 'package:last_national_bank/core/registration/widgets/NewSurname.dart';
import 'package:last_national_bank/core/registration/widgets/newEmail.dart';
import 'package:last_national_bank/core/registration/widgets/newName.dart';
import 'package:last_national_bank/core/registration/widgets/Logo.dart';
import 'package:last_national_bank/widgets/Secret.dart';
import 'package:last_national_bank/widgets/buttonNewUser.dart';
import 'package:last_national_bank/widgets/userOld.dart';

class NewUser extends StatefulWidget {
  @override
  _NewUserState createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blueGrey, Colors.teal]),
      ),
      child: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Logo(),
                  //TextNew(),
                ],
              ),
              NewName(),
              NewSurname(),
              NewAge(),
              NewEmail(),
              NewIDnum(),
              NewLoc(),
              PasswordInput(),
              SecretKey(),
              ButtonNewUser(),
              UserOld(),
            ],
          ),
        ],
      ),
    );
  }
}
