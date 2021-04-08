import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../widgets/button.dart';
import '../../widgets/first.dart';
import '../../widgets/textLogin.dart';
import '../../widgets/verticalText.dart';
import 'login.functions.dart';
import 'widgets/login_id.dart';
import 'widgets/login_password.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.blueAccent,
    ));
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blueGrey, Colors.lightBlueAccent]),
      ),
      child: ListView(children: [
        Row(children: <Widget>[
          VerticalText(),
          TextLogin(),
        ]),
        InputID(getIDController()),
        PasswordInput(getPasswordController()),
        ButtonLogin(() {
          loginProcedure(context);
        }),
        FirstTime(),
      ]),
    );
  }
}
