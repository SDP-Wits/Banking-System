import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:last_national_bank/core/login/widgets/login_id.dart';
import '../../widgets/button.dart';
import '../../widgets/first.dart';
import '../../widgets/textLogin.dart';
import '../../widgets/verticalText.dart';
import './widgets/login_password.dart';
import 'login.functions.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blueGrey, Colors.lightBlueAccent]),
      ),
      child: Column(children: [
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
