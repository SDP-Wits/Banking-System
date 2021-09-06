// coverage:ignore-start
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:last_national_bank/utils/helpers/helper.dart';

class OrangeCircles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = getSize(context);

    return Stack(children: <Widget>[
      new Positioned(
        left: size.width / 1.1,
        child: Container(
          width: size.height / 4,
          height: size.height / 5,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFffa781),
          ),
        ),
      ),
      new Positioned(
        left: size.width / 1.08,
        top: size.height / 3,
        child: Container(
          width: size.height / 3,
          height: size.height / 5,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFffa781),
          ),
        ),
      ),
      new Positioned(
        left: size.width / 1.1,
        top: size.height / 10,
        child: Container(
          width: size.height / 4,
          height: size.height / 3,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFffa781),
          ),
        ),
      ),
    ]);
  }
}
// coverage:ignore-end