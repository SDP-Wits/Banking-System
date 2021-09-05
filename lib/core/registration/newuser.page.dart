// coverage:ignore-start

import 'package:flutter/material.dart';
import 'package:last_national_bank/core/registration/widgets/Logo.dart';
import 'package:last_national_bank/core/registration/widgets/NewAge.dart';
import 'package:last_national_bank/core/registration/widgets/NewIDnum.dart';
import 'package:last_national_bank/core/registration/widgets/NewLoc.dart';
import 'package:last_national_bank/core/registration/widgets/NewPassword.dart';
import 'package:last_national_bank/core/registration/widgets/NewSurname.dart';
import 'package:last_national_bank/core/registration/widgets/newEmail.dart';
import 'package:last_national_bank/core/registration/widgets/newName.dart';
import 'package:last_national_bank/utils/helpers/style.dart';
import 'package:last_national_bank/core/registration/widgets/Secret.dart';
import 'package:last_national_bank/core/registration/widgets/buttonNewUser.dart';
import 'package:last_national_bank/core/registration/widgets/userOld.dart';

/*
Contains some common input fields that the admin and 
client registration pages use.
*/
class NewUser extends StatefulWidget {
  @override
  _NewUserState createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: backgroundGradient,
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
              NewName(MediaQuery.of(context).size.width),
              NewSurname(MediaQuery.of(context).size.width),
              NewAge(MediaQuery.of(context).size.width),
              NewEmail(MediaQuery.of(context).size.width),
              NewIDnum(MediaQuery.of(context).size.width),
              NewLoc(MediaQuery.of(context).size.width),
              PasswordInput(MediaQuery.of(context).size.width),
              SecretKey(MediaQuery.of(context).size.width),
              ButtonNewUser(MediaQuery.of(context).size.width / 2),
              UserOld(),
            ],
          ),
        ],
      ),
    );
  }
}
// coverage:ignore-end
