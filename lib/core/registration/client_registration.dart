import 'package:flutter/material.dart';

import '../../widgets/Logo.dart';
import '../../widgets/NewAge.dart';
import '../../widgets/NewIDnum.dart';
import '../../widgets/NewLoc.dart';
import '../../widgets/NewSurname.dart';
import '../../widgets/buttonNewUser.dart';
import '../../widgets/newEmail.dart';
import '../../widgets/newName.dart';
import '../../widgets/password.dart';
import '../../widgets/userOld.dart';

class ClientRegistrationPage extends StatefulWidget {
  @override
  _ClientRegistrationPageState createState() => _ClientRegistrationPageState();
}

class _ClientRegistrationPageState extends State<ClientRegistrationPage> {
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
                  ],
                ),
                NewName(),
                NewSurname(),
                NewAge(),
                NewEmail(),
                NewIDnum(),
                NewLoc(),
                PasswordInput(),
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

class ClientRegistrationPage extends StatefulWidget {
  @override
  _ClientRegistrationPageState createState() => _ClientRegistrationPageState();
}

class _ClientRegistrationPageState extends State<ClientRegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("I == ClientPage()"),
            RouteButtonCustom(
              goTo: () => goToLogin(context),
              text: "Login",
            ),
            RouteButtonCustom(
              goTo: () {
                goToAdminRegistration(context);
              },
              text: "Admin Registration",
            ),
          ],
        ),
      ),
    );
  }
}*/
