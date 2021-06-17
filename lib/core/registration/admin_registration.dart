// coverage:ignore-start
import 'package:flutter/material.dart';
import 'package:last_national_bank/config/routes/router.dart';
import 'package:last_national_bank/constants/route_constants.dart';
import 'package:last_national_bank/utils/helpers/style.dart';

import 'widgets/Logo.dart';
import 'widgets/NewAge.dart';
import 'widgets/NewIDnum.dart';
import 'widgets/NewLoc.dart';
import 'widgets/NewPassword.dart';
import 'widgets/NewPassword2.dart';
import 'widgets/NewPhone.dart';
import 'widgets/NewSurname.dart';
import 'widgets/Secret.dart';
import 'widgets/buttonNewUser.dart';
import 'widgets/newEmail.dart';
import 'widgets/newName.dart';
import 'widgets/userOld.dart';
import 'package:last_national_bank/utils/helpers/back_button_helper.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';

class AdminRegistrationPage extends StatefulWidget {
  @override
  _AdminRegistrationPage createState() => _AdminRegistrationPage();
}

//builds the UI for admin to register and calls the relevant widgets to be displayed
class _AdminRegistrationPage extends State<AdminRegistrationPage> {
  @override
  void initState() {
    super.initState();

    //Adding the back button listener
    BackButtonInterceptor.add(myInterceptor);
  }

  //When the back button is pressed, go to Login Page
  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    return helperInterceptor(
        context: context,
        currentRoute: AdminRegistrationRoute,
        goTo: goToLogin,
        info: info,
        stopDefaultButtonEvent: stopDefaultButtonEvent);
  }

  @override
  void dispose() {
    //Removing the back button listener
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  /*
  Builds the Admin Registration page, same as the client registration page,
  Contains different input fields for the user. 

  They can click on the submit button and the users details will get submitted
  to the PHP file which will be entered into Database.

  If successful it will take them back to the login page. 

  The difference is between the client registration pages is
  that the admin registration page has an input field for 
  the secret key which the admin must enter in order
  to register successfully.

  */
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
