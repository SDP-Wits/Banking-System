// coverage:ignore-start
import 'package:flutter/material.dart';
import 'package:last_national_bank/utils/helpers/helper.dart';
import 'package:last_national_bank/utils/helpers/style.dart';

class DeviceLayout extends StatelessWidget {
  late final Widget phoneLayout;
  late final Widget desktopLayout;
  late final Widget tabletLayout;

  DeviceLayout(
      {required this.phoneLayout,
      Widget? desktopWidget,
      Widget? tabletWidget}) {
    this.desktopLayout = desktopWidget ?? phoneLayout;

    this.tabletLayout = tabletWidget ?? phoneLayout;
  }

  @override
  Widget build(BuildContext context) {
    final size = getSize(context);

    if (size.width < phoneWidth) {
      return phoneLayout;
    } else if (size.width < tabletWidth) {
      return tabletLayout;
    } else {
      //Desktop
      return desktopLayout;
    }
  }
}
// coverage:ignore-end