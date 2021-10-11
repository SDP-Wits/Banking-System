import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:last_national_bank/core/login/login.functions.dart';
import 'package:last_national_bank/utils/helpers/SHA-256_encryption.dart';
import 'package:last_national_bank/utils/services/online_db.dart';
import 'package:last_national_bank/widgets/desktopNav.dart';
import 'config/routes/router.dart' as router;
import 'config/routes/router.dart';
import 'constants/app_constants.dart';
import 'constants/database_constants.dart';
import 'core/login/login.dart';

// coverage:ignore-start
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // hrllo
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
    // TODO: Comment before final release
    // autoLogin(context);
    // autoLoginWeb("7899876543210", "Joker@123", true, context);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.teal,
    ));
    // return PlaygroundTest();
    return LoginPage();
    // if (kIsWeb) return LoginPageForWeb();
  }
}

Future autoLoginWeb(String userID, String password, bool isClientLogin,
    BuildContext context) async {
  //Encrypt password
  String encodePass = encode(password);

  //Try to send login details to database
  String response = await userLoginOnline(userID, encodePass, isClientLogin);

  if (response == dbSuccess) {
    if (!isClientLogin) {
      //If Admin, go to admin verification list
      goToAdminVerificationList(context);
    } else {
      //If client, go to profile page
      goToProfilePage(context);
    }
  }
}
// coverage:ignore-end
