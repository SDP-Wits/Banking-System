import 'package:flutter/material.dart';

import '../../widgets/Logo.dart';
import '../../widgets/NewAge.dart';
import '../../widgets/NewIDnum.dart';
import '../../widgets/NewLoc.dart';
import '../../widgets/NewSurname.dart';
import '../../widgets/Secret.dart';
import '../../widgets/buttonNewUser.dart';
import '../../widgets/newEmail.dart';
import '../../widgets/newName.dart';
import '../../widgets/password.dart';
import '../../widgets/userOld.dart';

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
