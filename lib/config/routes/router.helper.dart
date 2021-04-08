import 'package:flutter/material.dart';

Route<dynamic> MaterialRouteWrap(Widget widget) {
  return MaterialPageRoute(
    builder: (context) => WrapScaffold(widget),
  );
}

//Wrap Widget inside Scaffolding and SafeArea
class WrapScaffold extends StatelessWidget {
  final Widget widget;
  WrapScaffold(this.widget);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: widget,
      ),
    );
  }
}

String getCurrentRouteName(BuildContext context) {
  return ModalRoute.of(context)!.settings.name!;
}
