// coverage:ignore-start
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:last_national_bank/config/routes/router.helper.dart';

bool helperInterceptor(
    {required bool stopDefaultButtonEvent,
    required RouteInfo info,
    required BuildContext context,
    required Function(BuildContext) goTo,
    required String currentRoute}) {
  if (kIsWeb) {
    // Navigator.pop(context);
    goTo(context);
    return true;
  }

  if (info.currentRoute(context)!.settings.name ==
      getCurrentRouteName(context)) {
    Future.delayed(Duration(milliseconds: 100)).then((value) {
      Navigator.pop(context);
      goTo(context);
    });
  } else {
    return true;
  }

  return false;
}
// coverage:ignore-end
