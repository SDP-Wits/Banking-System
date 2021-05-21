//import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:last_national_bank/classes/accountDetails.dart';
import 'package:last_national_bank/classes/name.class.dart';
import 'package:last_national_bank/core/account/accounts.dart';
import 'package:last_national_bank/core/bank_account_options/account_options.dart';
import 'package:last_national_bank/core/select_payment/select_payment.dart';
import 'package:last_national_bank/core/specific_account/specific_bank_account.dart';

import '../../constants/route_constants.dart';
import '../../core/login/login.dart';
import '../../core/registration/admin_registration.dart';
import '../../core/registration/client_registration.dart';
import '../../core/registration/newuser.page.dart';
import '../../core/verification_list/admin_verification_list.dart';
import '../../core/verification_status/verification_status.dart';
import '../../core/timeline/timeline.dart';
import 'router.helper.dart';
import 'undefined_page.dart';

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

    case SpecificAccount:
      //Whatever arguments that get passed will be converted into the
      //accountDetails object
      final args = settings.arguments as accountDetails;
      return MaterialRouteWrap(SpecificAccountPage(
        acc: args,
      ));

    case TimelineRoute:
      return MaterialRouteWrap(TimelinePage());

    case SelectPayment:
      return MaterialRouteWrap(SelectPaymentPage());

    //If page to go to is unknown, go to default home page, i.e. Login Page
    default:
      return MaterialRouteWrap(LoginPage());
  }
}

//When the app receives an unknown route name, do this
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

void goToCreateAccount(BuildContext context) {
  Navigator.pushNamed(context, CreateAccount);
}

void goToViewAccount(BuildContext context) {
  Navigator.pushNamed(context, ViewAccount);
}

void goToSpecificAccount(
    {required BuildContext context, required accountDetails acc}) {
  Navigator.pushNamed(context, SpecificAccount, arguments: acc);
}

void goToTimeline(BuildContext context) {
  Navigator.pushNamed(context, TimelineRoute);
}

void goToSelectPayment(BuildContext context) {
  Navigator.pushNamed(context, SelectPayment);
}
