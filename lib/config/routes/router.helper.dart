// coverage:ignore-start
import 'package:flutter/material.dart';

import '../../constants/route_constants.dart';

Route<dynamic> MaterialRouteWrap(Widget widget, RouteSettings settings) {
  return MaterialPageRoute(
    settings: settings,
    builder: (context) => WrapScaffold(widget),
  );
}

//Wrap Widget inside Scaffolding and SafeArea
class WrapScaffold extends StatelessWidget {
  final Widget widget;
  WrapScaffold(this.widget);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          body: SafeArea(
            child: widget,
          ),
        ),
        onWillPop: () async {
          return false;
        });
  }
}

String getCurrentRouteName(BuildContext context) {
  return ModalRoute.of(context)!.settings.name!;
}

Future<bool> onPop(BuildContext context) {
  if (ModalRoute.of(context)!.settings.name != LoginRoute) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context, true);
    }
  }
  return Future.value(false);
}
// coverage:ignore-end
