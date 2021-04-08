import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../widgets/button.dart';
import '../../widgets/first.dart';
import '../../widgets/inputEmail.dart';
import '../../widgets/textLogin.dart';
import '../../widgets/verticalText.dart';
import '../registration/widgets/NewPassword.dart';
import 'login.functions.dart';

class LoginPage extends StatelessWidget {
  String email = "";

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
            colors: [Colors.blueGrey, Colors.blueAccent]),
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
