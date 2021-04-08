import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:last_national_bank/core/login/login.dart';
import 'package:last_national_bank/core/manual_testing/playground.dart';

import 'config/routes/router.dart' as router;
import 'constants/app_constants.dart';
import 'constants/route_constants.dart';
import 'core/registration/admin_registration.dart';
import 'utils/services/local_db.dart';

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
        primarySwatch: Colors.blueGrey,
      ),
      onGenerateRoute: router.generateRoute,
      onUnknownRoute: router.unknownRoute,
      // initialRoute: LoginRoute,
      //TODO: UNCOMMENT THIS OUT
      home: Scaffold(
        body: SafeArea(
          child: MyHomePage(),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    LocalDatabaseHelper.instance.isUser().then((isUser) {
      if (isUser) {
        LocalDatabaseHelper.instance.getUserAndAddress().then((user) {
          if (user!.isAdmin) {
            router.goToAdminVerificationList(context);
          } else {
            router.goToAdminVerificationStatus(context);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.blueAccent,
    ));
    return AdminRegistrationPage();
  }
}
