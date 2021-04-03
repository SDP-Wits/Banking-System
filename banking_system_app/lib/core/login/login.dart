import 'package:flutter/material.dart';
import 'package:last_national_bank/widgets/button.dart';
import 'package:last_national_bank/widgets/first.dart';
import 'package:last_national_bank/widgets/inputEmail.dart';
import 'package:last_national_bank/widgets/password.dart';
import 'package:last_national_bank/widgets/textLogin.dart';
import 'package:last_national_bank/widgets/verticalText.dart';

class LoginPage extends StatelessWidget {
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
                Row(children: <Widget>[
                  VerticalText(),
                  TextLogin(),
                ]),
                InputEmail(),
                PasswordInput(),
                ButtonLogin(),
                FirstTime(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
