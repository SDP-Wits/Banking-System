// coverage:ignore-start
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:last_national_bank/config/routes/router.dart';

import '../../constants/route_constants.dart';

/*
Wrapping widgets with the MaterialRouteWrap to add some features
to all Widgets/Pages, such as disabling default back button action
*/

Route<dynamic> MaterialRouteWrap(
    Widget widget, RouteSettings settings, Function(BuildContext)? goTo) {
  return MaterialPageRoute(
    settings: settings,
    builder: (context) => WrapScaffold(
      widget: widget,
      goTo: goTo,
    ),
  );
}

//Wrap Widget inside Scaffolding and SafeArea
class WrapScaffold extends StatelessWidget {
  final Widget widget;
  final Function(BuildContext)? goTo;
  // ignore: avoid_init_to_null
  WrapScaffold({required this.widget, this.goTo = null});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: SafeArea(
          child: widget,
        ),
      ),
      onWillPop: () async {
        if (kIsWeb && goTo != null) {
          goTo!(context);
          return true;
        }
        return false;
      },
    );
  }
}

//Gets name of the current route given a BuildContext
String getCurrentRouteName(BuildContext context) {
  return ModalRoute.of(context)!.settings.name!;
}

//Pop current route if possible
Future<bool> onPop(BuildContext context) {
  if (ModalRoute.of(context)!.settings.name != LoginRoute) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context, true);
    }
  }
  return Future.value(false);
}
// coverage:ignore-end
