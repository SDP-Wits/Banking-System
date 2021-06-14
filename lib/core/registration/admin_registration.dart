// coverage:ignore-start
import 'package:flutter/material.dart';
import 'package:last_national_bank/utils/helpers/style.dart';

import '../../widgets/Secret.dart';
import '../../widgets/buttonNewUser.dart';
import '../../widgets/userOld.dart';
import 'widgets/Logo.dart';
import 'widgets/NewAge.dart';
import 'widgets/NewIDnum.dart';
import 'widgets/NewLoc.dart';
import 'widgets/NewPassword.dart';
import 'widgets/NewPassword2.dart';
import 'widgets/NewPhone.dart';
import 'widgets/NewSurname.dart';
import 'widgets/newEmail.dart';
import 'widgets/newName.dart';

class AdminRegistrationPage extends StatefulWidget {
  @override
  _AdminRegistrationPage createState() => _AdminRegistrationPage();
}
//builds the UI for admin to register and calls the relevant widgets to be displayed
class _AdminRegistrationPage extends State<AdminRegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: backgroundGradient),
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
              NewPhone(),
              NewEmail(),
              NewIDnum(),
              NewLoc(),
              PasswordInput(),
              PasswordInput2(),
              SecretKey(),
              ButtonNewUser(),
              UserOld(),
            ],
          ),
        ],
      ),
    );
  }
}

// coverage:ignore-end

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
