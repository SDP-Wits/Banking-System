// coverage:ignore-start
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:last_national_bank/classes/accountDetails.dart';
import 'package:last_national_bank/classes/name.class.dart';
import 'package:last_national_bank/core/account/accounts.dart';
import 'package:last_national_bank/core/bank_account_options/account_options.dart';
import 'package:last_national_bank/core/payments/payment.dart';
import 'package:last_national_bank/core/select_payment/select_payment.dart';
import 'package:last_national_bank/core/specific_account/specific_bank_account.dart';
import 'package:last_national_bank/core/transfer/transfer.dart';

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
      return MaterialRouteWrap(AdminVerificationListPage());

    // case AdminVerifyUser :
    //   return MaterialRouteWrap(VerifyUser());
    //If User, go to see your application status
    case ProfileRoute:
      return MaterialRouteWrap(Profile());

    case NewUserRoute:
      return MaterialRouteWrap(NewUser());

    case CreateAccountRoute:
      return MaterialRouteWrap(BankAccountOptions());

    case ViewAccountRoute:
      return MaterialRouteWrap(Accounts());

    case SpecificAccountRoute:
      //Whatever arguments that get passed will be converted into the
      //accountDetails object
      final args = settings.arguments as accountDetails;
      return MaterialRouteWrap(SpecificAccountPage(
        acc: args,
      ));

    case TimelineRoute:
      return MaterialRouteWrap(TimelinePage());

    case SelectPaymentRoute:
      return MaterialRouteWrap(SelectPaymentPage());

    case TransferRoute:
      return MaterialRouteWrap(Transfers());

    case PaymentRoute:
      return MaterialRouteWrap(Payments());

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
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => WrapScaffold(LoginPage())),
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

void goToAdminVerifyUsers(BuildContext context, {required Name names}) {
  //Removing outdated verficiation list
  Navigator.pop(context);
  Navigator.pushNamed(context, AdminVerifyUserRoute, arguments: names);
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
