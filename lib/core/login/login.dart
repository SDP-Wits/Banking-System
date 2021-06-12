// coverage:ignore-start

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:last_national_bank/utils/services/online_db.dart';

import '../../widgets/button.dart';
import '../../widgets/first.dart';
import '../registration/widgets/Logo.dart';
import 'login.functions.dart';
import 'widgets/login_id.dart';
import 'widgets/login_password.dart';

class LoginPage extends StatelessWidget {
  @override
  int test = 0;
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.blueAccent,
    ));
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blueGrey, Colors.teal]),
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
