// coverage:ignore-start
import 'package:flutter/material.dart';
import 'package:last_national_bank/utils/helpers/helper.dart';

class CustomCircle extends StatelessWidget {
  final Color color;
  final double sizeFactor;

  CustomCircle({required this.color, this.sizeFactor = 0.1});

  @override
  Widget build(BuildContext context) {
    final size = getSize(context);
    return Container(
      width: size.height * sizeFactor,
      height: size.height * sizeFactor,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
// coverage:ignore-end