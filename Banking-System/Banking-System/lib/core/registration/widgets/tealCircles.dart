// coverage:ignore-start
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:last_national_bank/utils/helpers/helper.dart';

class TealCircles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = getSize(context);

    return Stack(children: <Widget>[
      new Positioned(
        right: size.width / 1.15,
        bottom: size.height / 15 - 10,
        child: Container(
          width: size.height / 3,
          height: size.height / 2,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.teal,
          ),
        ),
      ),
      new Positioned(
        right: size.width / 1.1,
        bottom: size.height / 5,
        child: Container(
          width: size.height / 3,
          height: size.height / 2,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.teal,
          ),
        ),
      ),
    ]);
  }
}
// coverage:ignore-end