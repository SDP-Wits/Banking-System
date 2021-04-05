import 'package:flutter/material.dart';
import 'package:last_national_bank/widgets/NewAge.dart';
import 'package:last_national_bank/widgets/NewIDnum.dart';
import 'package:last_national_bank/widgets/NewSurname.dart';
import 'package:last_national_bank/widgets/NewLoc.dart';
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
