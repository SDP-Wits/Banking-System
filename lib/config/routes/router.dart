//import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:last_national_bank/classes/name.class.dart';
import 'package:last_national_bank/classes/user.class.dart';
import 'package:last_national_bank/core/account/accounts.dart';
import 'package:last_national_bank/core/bank_account_options/account_options.dart';
import '../../constants/route_constants.dart';
import '../../core/login/login.dart';
import '../../core/registration/admin_registration.dart';
import '../../core/registration/client_registration.dart';
import '../../core/registration/newuser.page.dart';
import '../../core/verification_list/admin_verification_list.dart';
import '../../core/verification_status/verification_status.dart';
import 'package:last_national_bank/core/verification_list/admin_verify_user.dart';
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

    // case AdminVerifyUser :
    //   return MaterialRouteWrap(VerifyUser());
    //If User, go to see your application status
    case VerificationStatusRoute:
      return MaterialRouteWrap(VerificationStatus());

    case NewUserRoute:
      return MaterialRouteWrap(NewUser());

    case CreateAccount:
      return MaterialRouteWrap(BankAccountOptions());

    case ViewAccount:
      return MaterialRouteWrap(Accounts());

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
  Navigator.popUntil(context, ModalRoute.withName(LoginRoute));
}

void goToClientRegistration(BuildContext context) {
  Navigator.pushNamed(context, ClientRegistrationRoute);
}

void goToAdminRegistration(BuildContext context) {
  Navigator.pushNamed(context, AdminRegistrationRoute);
}

void goToAdminVerificationList(BuildContext context) {
  Navigator.pushNamed(context, AdminVerificationListRoute);
}
void goToAdminVerifyUsers(BuildContext context, {required Name names}) {
  Navigator.pushNamed(context, AdminVerifyUser, arguments: names);
}
void goToAdminVerificationStatus(BuildContext context) {
  Navigator.pushNamed(context, VerificationStatusRoute);
}

void goToNewUser(BuildContext context) {
  Navigator.pushNamed(context, NewUserRoute);
}

void goToCreateAcc(BuildContext context) {
  Navigator.pushNamed(context, CreateAccount);
}

void goToViewAcc(BuildContext context) {
  Navigator.pushNamed(context, ViewAccount);
}

