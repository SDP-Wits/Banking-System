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
    //Adding the back button listener
    BackButtonInterceptor.add(myInterceptor);
  }

  //When the back button is pressed, go to Login Page
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
    //Removing the back button listener
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  /*
  Builds the Client Registration page, same as the admin registration page,
  Contains different input fields for the user. 

  They can click on the submit button and the users details will get submitted
  to the PHP file which will be entered into Database.

  If successful it will take them back to the login page. 

  The difference is between the client registration pages is
  that the admin registration page has an input field for 
  the secret key which the admin must enter in order
  to register successfully.

  This page (client registation) does NOT have the secret key field

  */
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
