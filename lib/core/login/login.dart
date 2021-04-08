import 'package:flutter/material.dart';

import '../../widgets/button.dart';
import '../../widgets/first.dart';
import '../../widgets/inputEmail.dart';
import '../../widgets/textLogin.dart';
import '../../widgets/verticalText.dart';
import '../registration/widgets/NewPassword.dart';
import 'login.functions.dart';

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
      child: Column(children: [
        Row(children: <Widget>[
          VerticalText(),
          TextLogin(),
        ]),
        InputEmail(),
        PasswordInput(),
        ButtonLogin(loginProcedure),
        FirstTime(),
      ]),
    );
  }
}
