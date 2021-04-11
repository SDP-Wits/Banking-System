import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:last_national_bank/constants/route_constants.dart';
import 'package:last_national_bank/core/verification_status/verification_status.dart';
import 'package:last_national_bank/utils/helpers/helper.dart';

import 'config/routes/router.dart' as router;
import 'config/routes/router.helper.dart';
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
      home: WillPopScope(
        onWillPop: () => onPop(context),
        child: Scaffold(
          body: SafeArea(
            child: MyHomePage(),
          ),
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
    autoLogin(context);
    // LocalDatabaseHelper.instance
    //     .selectAddress()
    //     .then((value) => toastyPrint(value.toString()));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.blueAccent,
    ));
    return LoginPage();
  }
}
