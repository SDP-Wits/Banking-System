import 'package:flutter/material.dart';
import 'package:last_national_bank/core/registration/admin_registration.dart';

import 'core/registration/admin_registration.dart';
import 'config/routes/router.dart' as router;
import 'constants/app_constants.dart';
import 'constants/route_constants.dart';
import 'core/login/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      onGenerateRoute: router.generateRoute,
      onUnknownRoute: router.unknownRoute,
      initialRoute: LoginRoute,
      home: Scaffold(
        body: SafeArea(
          child: MyHomePage(),
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoginPage();
  }
}
