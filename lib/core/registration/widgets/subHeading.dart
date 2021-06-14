// coverage:ignore-start
import 'package:flutter/material.dart';
import 'package:last_national_bank/utils/helpers/style.dart';

class subHeading extends StatelessWidget {
  final String headingText;

  subHeading(this.headingText);

  @override
  Widget build(BuildContext context) {
    return Container(
    //  padding: EdgeInsets.all(16),
      alignment: Alignment.center,
      child: Text(
        headingText,
        style: TextStyle(
          color: Colors.white,
          fontFamily: fontMont,
          fontSize: fontSizeLarge,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
// coverage:ignore-end