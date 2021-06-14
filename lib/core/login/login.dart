// coverage:ignore-start

import 'dart:io';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:last_national_bank/constants/route_constants.dart';
import 'package:last_national_bank/utils/helpers/style.dart';

import '../registration/widgets/Logo.dart';
import '../registration/widgets/button.dart';
import '../registration/widgets/first.dart';
import 'login.functions.dart';
import 'widgets/login_id.dart';
import 'widgets/login_password.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    // SystemChannels.platform.invokeMethod('SystemNavigator.pop');

    return false;
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

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
