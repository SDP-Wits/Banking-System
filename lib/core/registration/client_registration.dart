// coverage:ignore-start
import 'package:flutter/material.dart';
import 'package:last_national_bank/config/routes/router.dart';
import 'package:last_national_bank/constants/route_constants.dart';
import 'package:last_national_bank/utils/helpers/style.dart';

import 'widgets/buttonNewUser.dart';
import 'widgets/userOld.dart';
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
import 'package:last_national_bank/utils/helpers/back_button_helper.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';

class ClientRegistrationPage extends StatefulWidget {
  @override
  _ClientRegistrationPageState createState() => _ClientRegistrationPageState();
}

//builds the UI for clients to register and calls the relevant widgets to be displayed
class _ClientRegistrationPageState extends State<ClientRegistrationPage> {
  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    return helperInterceptor(
        context: context,
        currentRoute: ClientRegistrationRoute,
        goTo: goToLogin,
        info: info,
        stopDefaultButtonEvent: stopDefaultButtonEvent);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: backgroundGradient,
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
              NewPhone(),
              NewEmail(),
              NewIDnum(),
              NewLoc(),
              PasswordInput(),
              PasswordInput2(),
              ButtonNewUser(),
              UserOld(),
              Padding(padding: EdgeInsets.symmetric(vertical: 15)),
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
