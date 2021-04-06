//We will have custom widgets that we make here,
//for example we will make a button
//that matches our theme here and then we will reuse it

import 'package:flutter/material.dart';

import '../utils/helpers/style.dart';

class CustomText extends StatelessWidget {
  late String text;
  //Sooo google something called null safety in flutter

  CustomText({required this.text});
  //The curly brackets allow us to do
  //CustomText customTextWidget = CustomText(text: "someTextHere");

  //Without curly brackets, (i.e. CustomText(this.text))
  //CustomText customTextWidget = CustomText("someTextHere")
  //the curly brackets allow us to be more explicit

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size.height * 0.5),
        color: secondaryCol,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontFamily: fontDefault,
          fontSize: fontSizeMedium,
        ),
      ),
    );
  }
}
