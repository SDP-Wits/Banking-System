import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'config/routes/router.dart' as router;
import 'constants/app_constants.dart';
import 'core/login/login.dart';
import 'core/verification_list/admin_verification_list.dart';
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
    // autoLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.blueAccent,
    ));
    return LoginPage();
  }
}

void autoLogin(BuildContext context) {
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
