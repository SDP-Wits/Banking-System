// coverage:ignore-start
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:last_national_bank/classes/accountDetails.dart';
import 'package:last_national_bank/classes/name.class.dart';
import 'package:last_national_bank/core/account/accounts.dart';
import 'package:last_national_bank/core/create_account/create_account.dart';
import 'package:last_national_bank/core/payments/payment.dart';
import 'package:last_national_bank/core/select_payment/select_payment.dart';
import 'package:last_national_bank/core/specific_account/specific_bank_account.dart';
import 'package:last_national_bank/core/transfer/transfer.dart';
import 'package:last_national_bank/core/verification_list/admin_verify_user.dart';

import '../../constants/route_constants.dart';
import '../../core/login/login.dart';
import '../../core/registration/admin_registration.dart';
import '../../core/registration/client_registration.dart';
import '../../core/registration/newuser.page.dart';
import '../../core/timeline/timeline.dart';
import '../../core/verification_list/admin_verification_list.dart';
import '../../core/profile/profile.dart';
import 'router.helper.dart';
import 'undefined_page.dart';

/*
Routing for the app, this will handle the movement from one 
widget/page to another widget/page
*/
Route<dynamic> generateRoute(RouteSettings settings) {
  //Getting page to go to (settings.name)
  switch (settings.name) {

    //If page to go to equals "login"
    case LoginRoute:
      return MaterialRouteWrap(LoginPage(), settings, null);

    //If page to go to equals "admin-registration"
    case AdminRegistrationRoute:
      return MaterialRouteWrap(AdminRegistrationPage(), settings, goToLogin);

    //If page to go to equals "client-registration"
    case ClientRegistrationRoute:
      return MaterialRouteWrap(ClientRegistrationPage(), settings, goToLogin);

    //If page to go to equals "admin-verification-list"
    case AdminVerificationListRoute:
      return MaterialRouteWrap(
          AdminVerificationListPage(), settings, goToLogin);

    // case AdminVerifyUser :
    //   return MaterialRouteWrap(VerifyUser());
    //If User, go to see your application status
    case ProfileRoute:
      return MaterialRouteWrap(Profile(), settings, goToLogin);

    case NewUserRoute:
      return MaterialRouteWrap(NewUser(), settings, goToLogin);

    case CreateAccountRoute:
      return MaterialRouteWrap(CreateAccount(), settings, goToProfilePage);

    case ViewAccountRoute:
      return MaterialRouteWrap(Accounts(), settings, goToProfilePage);

    case SpecificAccountRoute:
      //Whatever arguments that get passed will be converted into the
      //accountDetails object
      final args = settings.arguments as accountDetails;
      return MaterialRouteWrap(
          SpecificAccountPage(
            acc: args,
          ),
          settings,
          goToViewAccount);

    case TimelineRoute:
      return MaterialRouteWrap(TimelinePage(), settings, goToProfilePage);

    case SelectPaymentRoute:
      return MaterialRouteWrap(SelectPaymentPage(), settings, goToProfilePage);

    case TransferRoute:
      return MaterialRouteWrap(Transfers(), settings, goToSelectPayment);

    case PaymentRoute:
      return MaterialRouteWrap(Payments(), settings, goToSelectPayment);

    case VerifyUserRoute:
      final args = settings.arguments as String;
      return MaterialRouteWrap(
          VerifyUser(args), settings, goToAdminVerificationList);

    //If page to go to is unknown, go to default home page, i.e. Login Page
    default:
      return MaterialRouteWrap(LoginPage(), settings, null);
  }
}

//When the app receives an unknown route name, do this
Route<dynamic> unknownRoute(RouteSettings settings) {
  return MaterialRouteWrap(
      UndefinedPage(name: settings.name!), settings, goToLogin);
}

void goToLogin(BuildContext context) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (context) => WrapScaffold(widget: LoginPage())),
      (route) => route.isFirst);
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

void goToProfilePage(BuildContext context) {
  Navigator.pushNamed(context, ProfileRoute);
}

void goToNewUser(BuildContext context) {
  Navigator.pushNamed(context, NewUserRoute);
}

void goToCreateAccount(BuildContext context) {
  Navigator.pushNamed(context, CreateAccountRoute);
}

void goToViewAccount(BuildContext context) {
  Navigator.pushNamed(context, ViewAccountRoute);
}

void goToVerifyUser({required BuildContext context, required String idNumber}) {
  Navigator.pushNamed(context, VerifyUserRoute, arguments: idNumber);
}

void goToSpecificAccount(
    {required BuildContext context, required accountDetails acc}) {
  Navigator.pushNamed(context, SpecificAccountRoute, arguments: acc);
}

void goToTimeline(BuildContext context) {
  Navigator.pushNamed(context, TimelineRoute);
}

void goToSelectPayment(BuildContext context) {
  Navigator.pushNamed(context, SelectPaymentRoute);
}

void goToTransfers(BuildContext context) {
  Navigator.pushNamed(context, TransferRoute);
}

void goToPayments(BuildContext context) {
  Navigator.pushNamed(context, PaymentRoute);
}
// coverage:ignore-end
