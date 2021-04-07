import 'package:flutter/material.dart';

import '../../widgets/button.dart';
import '../../widgets/first.dart';
import '../../widgets/inputEmail.dart';
import '../../widgets/NewPassword.dart';
import '../../widgets/textLogin.dart';
import '../../widgets/verticalText.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blueGrey, Colors.purple]),
      ),
      child: Column(
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
    );
  }
}
