// coverage:ignore-start
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:last_national_bank/config/routes/router.dart';
import 'package:last_national_bank/constants/route_constants.dart';
import 'package:last_national_bank/core/registration/widgets/orangeCircles.dart';
import 'package:last_national_bank/core/registration/widgets/tealCircles.dart';
import 'package:last_national_bank/utils/helpers/helper.dart';
import 'package:last_national_bank/utils/helpers/style.dart';
import 'package:last_national_bank/widgets/deviceLayout.dart';
import 'package:last_national_bank/widgets/heading.dart';

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
    return buildPage();
  }

  Widget buildPage() {
    return DeviceLayout(
      phoneLayout: phoneLayout(context),
      desktopWidget: desktopLayout(context),
    );
  }

  Widget desktopLayout(BuildContext context) {
    final size = getSize(context);

    return SingleChildScrollView(
        child: Container(
      width: size.width,
      height: size.height,
      child: Stack(
        children: <Widget>[
          TealCircles(),
          OrangeCircles(),
          new Align(
              alignment: Alignment.center,
              child: Container(
                width: size.width / 1.2,
                height: size.height / 1.1,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    //Gradient we use for page background
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.teal.withAlpha(128),
                      Color(0xFFffa781).withAlpha(128)
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25.0),
                    bottomRight: Radius.circular(25.0),
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Heading("Admin Registration"),
                        NewName(size.width / 4),
                        NewSurname(size.width / 4),
                        NewAge(size.width / 4),
                        NewPhone(size.width / 4),
                        NewEmail(size.width / 4),
                        NewIDnum(size.width / 4),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        NewLoc(size.width / 4),
                        PasswordInput(size.width / 4),
                        PasswordInput2(size.width / 4),
                        SecretKey(size.width / 4),
                      ],
                    )
                  ],
                ),
              )),
          new Positioned(
              left: size.width / 1.23,
              bottom: size.height / 15,
              child: ButtonNewUser(size.width / 10)),
        ],
      ),
    ));
  }

  Widget phoneLayout(BuildContext context) {
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
              NewName(MediaQuery.of(context).size.width),
              NewSurname(MediaQuery.of(context).size.width),
              NewAge(MediaQuery.of(context).size.width),
              NewPhone(MediaQuery.of(context).size.width),
              NewEmail(MediaQuery.of(context).size.width),
              NewIDnum(MediaQuery.of(context).size.width),
              NewLoc(MediaQuery.of(context).size.width),
              PasswordInput(MediaQuery.of(context).size.width),
              PasswordInput2(MediaQuery.of(context).size.width),
              SecretKey(MediaQuery.of(context).size.width),
              ButtonNewUser(MediaQuery.of(context).size.width / 2),
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
