import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/route_constants.dart';
import '../../core/login/login.dart';
import '../../core/registration/admin_registration.dart';
import '../../core/registration/client_registration.dart';
import '../../core/registration/newuser.page.dart';
import '../../core/verification_list/admin_verification_list.dart';
import '../../core/verification_status/verification_status.dart';
import 'router.helper.dart';
import 'undefined_page.dart';

//TODO: Testing

//When the app changes route names, make this specific widget
Route<dynamic> generateRoute(RouteSettings settings) {
  //Getting page to go to (settings.name)
  switch (settings.name) {

    //If page to go to equals "login"
    case LoginRoute:
      return MaterialRouteWrap(LoginPage());

    //If page to go to equals "admin-registration"
    case AdminRegistrationRoute:
      return MaterialRouteWrap(AdminRegistrationPage());

    //If page to go to equals "client-registration"
    case ClientRegistrationRoute:
      return MaterialRouteWrap(ClientRegistrationPage());

    //If page to go to equals "admin-verification-list"
    case AdminVerificationListRoute:
      return MaterialRouteWrap(VerificationListPage());

    //If User, go to see your application status
    case VerificationStatusRoute:
      return MaterialRouteWrap(VerificationStatus());

    case NewUserRoute:
      return MaterialRouteWrap(NewUser());

    //If page to go to is unknown, go to default home page, i.e. Login Page
    default:
      return MaterialRouteWrap(LoginPage());
  }
}

//When the app recevies an unknown route name, do this
Route<dynamic> unknownRoute(RouteSettings settings) {
  return MaterialRouteWrap(
    UndefinedPage(name: settings.name!),
  );
}

void goToLogin(BuildContext context) {
  //TODO: Handle when starting screen is not login screen (i.e. When already have credientials)
  Navigator.popUntil(context, ModalRoute.withName("/login"));

  Navigator.pushNamed(context, LoginRoute);
}

void goToClientRegistration(BuildContext context) {
  Navigator.popUntil(context, ModalRoute.withName("/login"));

  Navigator.pushNamed(context, ClientRegistrationRoute);
}

void goToAdminRegistration(BuildContext context) {
  Navigator.popUntil(context, ModalRoute.withName("/login"));

  Navigator.pushNamed(context, AdminRegistrationRoute);
}

void goToAdminVerificationList(BuildContext context) {
  Navigator.popUntil(context, ModalRoute.withName("/login"));

  Navigator.pushNamed(context, AdminVerificationListRoute);
}

void goToAdminVerificationStatus(BuildContext context) {
  Navigator.popUntil(context, ModalRoute.withName("/login"));

  Navigator.pushNamed(context, VerificationStatusRoute);
}

void goToNewUser(BuildContext context) {
  Navigator.popUntil(context, ModalRoute.withName("/login"));

  Navigator.pushNamed(context, NewUserRoute);
}
