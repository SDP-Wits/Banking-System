// coverage:ignore-start

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:last_national_bank/utils/helpers/style.dart';

import '../registration/widgets/Logo.dart';
import '../registration/widgets/button.dart';
import '../registration/widgets/first.dart';
import 'login.functions.dart';
import 'widgets/login_id.dart';
import 'widgets/login_password.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.blueAccent,
    ));
    return Container(
      decoration: BoxDecoration(
        gradient: backgroundGradient,
      ),
      child: SingleChildScrollView(
        child: Container(
          height: size.height,
          child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              //mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Logo(),
                      //VerticalText(),
                      //TextLogin(),
                    ]),
                InputID(getIDController()),
                PasswordInput(getPasswordController()),
                ButtonLogin(() {
                  loginProcedure(context);
                }),
                FirstTime()
              ]),
        ),
      ),
    );
  }
}

// coverage:ignore-end
