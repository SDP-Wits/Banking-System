// coverage:ignore-start
import 'package:flutter/material.dart';

import '../../constants/route_constants.dart';

/*
Wrapping widgets with the MaterialRouteWrap to add some features
to all Widgets/Pages, such as disabling default back button action
*/

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
        //Disabling default back button action
        onWillPop: () async {
          return false;
        });
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
