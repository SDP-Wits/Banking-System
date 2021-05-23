// TODO:turn this page into selector for admin or customer registration //# nocov

import 'package:flutter/material.dart';//# nocov
import 'package:last_national_bank/core/registration/widgets/Logo.dart';//# nocov
import 'package:last_national_bank/core/registration/widgets/NewAge.dart';//# nocov
import 'package:last_national_bank/core/registration/widgets/NewIDnum.dart';//# nocov
import 'package:last_national_bank/core/registration/widgets/NewLoc.dart';//# nocov
import 'package:last_national_bank/core/registration/widgets/NewPassword.dart';//# nocov
import 'package:last_national_bank/core/registration/widgets/NewSurname.dart';//# nocov
import 'package:last_national_bank/core/registration/widgets/newEmail.dart';//# nocov
import 'package:last_national_bank/core/registration/widgets/newName.dart';//# nocov
import 'package:last_national_bank/widgets/Secret.dart';//# nocov
import 'package:last_national_bank/widgets/buttonNewUser.dart';//# nocov
import 'package:last_national_bank/widgets/userOld.dart';//# nocov

class NewUser extends StatefulWidget {//# nocov
  @override//# nocov
  _NewUserState createState() => _NewUserState();//# nocov
}//# nocov

class _NewUserState extends State<NewUser> {//# nocov
  @override//# nocov
  Widget build(BuildContext context) {//# nocov
    return Container(//# nocov
      decoration: BoxDecoration(//# nocov
        gradient: LinearGradient(//# nocov
            begin: Alignment.topCenter,//# nocov
            end: Alignment.bottomCenter,//# nocov
            colors: [Colors.blueGrey, Colors.teal]),//# nocov
      ),//# nocov
      child: ListView(//# nocov
        children: <Widget>[//# nocov
          Column(//# nocov
            children: <Widget>[//# nocov
              Row(//# nocov
                mainAxisAlignment: MainAxisAlignment.center,//# nocov
                children: <Widget>[//# nocov
                  Logo(),//# nocov
                  //TextNew(),//# nocov
                ],//# nocov
              ),//# nocov
              NewName(),//# nocov
              NewSurname(),//# nocov
              NewAge(),//# nocov
              NewEmail(),//# nocov
              NewIDnum(),//# nocov
              NewLoc(),//# nocov
              PasswordInput(),//# nocov
              SecretKey(),//# nocov
              ButtonNewUser(),//# nocov
              UserOld(),//# nocov
            ],//# nocov
          ),//# nocov
        ],//# nocov
      ),//# nocov
    );//# nocov
  }//# nocov
}//# nocov
