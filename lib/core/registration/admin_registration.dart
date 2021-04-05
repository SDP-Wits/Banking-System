import 'package:flutter/material.dart';
import 'package:last_national_bank/widgets/NewAge.dart';
import 'package:last_national_bank/widgets/NewIDnum.dart';
import 'package:last_national_bank/widgets/NewSurname.dart';
import 'package:last_national_bank/widgets/NewLoc.dart';
import 'package:last_national_bank/widgets/Secret.dart';
import 'package:last_national_bank/widgets/buttonNewUser.dart';
import 'package:last_national_bank/widgets/newEmail.dart';
import 'package:last_national_bank/widgets/newName.dart';
import 'package:last_national_bank/widgets/password.dart';
import 'package:last_national_bank/widgets/Logo.dart';
import 'package:last_national_bank/widgets/textNew.dart';
import 'package:last_national_bank/widgets/userOld.dart';
import 'package:flutter/material.dart';
import 'package:last_national_bank/config/routes/router.dart';
import 'package:last_national_bank/widgets/routeButton.dart';

class AdminRegistrationPage extends StatefulWidget {
  @override
  _AdminRegistrationPage createState() => _AdminRegistrationPage();
}

class _AdminRegistrationPage extends State<AdminRegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blueGrey, Colors.teal]),
        ),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Logo(),
                    //TextNew(),
                  ],
                ),
                NewName(),
                NewSurname(),
                NewAge(),
                NewEmail(),
                NewIDnum(),
                NewLoc(),
                PasswordInput(),
                SecretKey(),
                ButtonNewUser(),
                UserOld(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/*import 'package:flutter/material.dart';
import 'package:last_national_bank/config/routes/router.dart';
import 'package:last_national_bank/widgets/routeButton.dart';

class AdminRegistrationPage extends StatefulWidget {
  @override
  AdminRegistrationPageState createState() => AdminRegistrationPageState();
}

class AdminRegistrationPageState extends State<AdminRegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("THIS IS, ADMIN PAGE!!!"),
            RouteButtonCustom(
              goTo: () => goToLogin(context),
              text: "Login",
            ),
            RouteButtonCustom(
              goTo: () {
                goToClientRegistration(context);
              },
              text: "Client Registration",
            ),
          ],
        ),
      ),
    );
  }
}*/
