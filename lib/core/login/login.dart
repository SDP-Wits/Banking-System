// coverage:ignore-start

import 'dart:io';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:last_national_bank/config/routes/router.helper.dart';
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
    //Adding Back Button listener
    BackButtonInterceptor.add(myInterceptor);

    emptyTextLogin();
  }

  //What happens when you press the back button, exit the app
  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    //Exit the app
    if (info.currentRoute(context)!.settings.name ==
        getCurrentRouteName(context)) {
      Future.delayed(Duration(milliseconds: 50)).then((value) {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      });
    } else {
      return true;
    }

    return false;
  }

  @override
  void dispose() {
    //Removing Back Button listener
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  //Contains ID Number and Password for the login of the user
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
                  //What happens when the login button is clicked
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
