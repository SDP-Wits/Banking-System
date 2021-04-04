import 'package:flutter/material.dart';
import 'package:last_national_bank/config/routes/router.dart' as router;
import 'package:last_national_bank/constants/route_constants.dart';
import 'package:last_national_bank/core/login/login.dart';
import 'constants/app_constants.dart';

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
        primarySwatch: Colors.blue,
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