// coverage:ignore-start
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/cupertino.dart';
import 'package:last_national_bank/config/routes/router.helper.dart';

bool helperInterceptor(
    {required bool stopDefaultButtonEvent,
    required RouteInfo info,
    required BuildContext context,
    required Function(BuildContext) goTo,
    required String currentRoute}) {
  if (info.currentRoute(context)!.settings.name ==
      getCurrentRouteName(context)) {
    Future.delayed(Duration(milliseconds: 50)).then((value) {
      Navigator.pop(context);
      goTo(context);
    });
  } else {
    return true;
  }

  return false;
}
// coverage:ignore-end
