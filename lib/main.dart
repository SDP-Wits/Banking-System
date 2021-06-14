import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'config/routes/router.dart' as router;
import 'config/routes/router.helper.dart';
import 'constants/app_constants.dart';
import 'core/login/login.dart';
import 'utils/helpers/ignore_helper.dart';

// coverage:ignore-start
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.teal,
    ));
    // return PlaygroundTest();
    return LoginPage();
  }
}
// coverage:ignore-end
