// coverage:ignore-start
import 'package:flutter/material.dart';

final double phoneWidth = 500;
final double tabletWidth = 1000;

final String fontDefault = "";
final String fontFancy = "";

final double hPadding = 15.0; // Container padding

final double spacingPadding = 16.0;

final double fontSizeHeading = 40.0;
final double fontSizeLarge = 32.0;
final double fontSizeMedium = 26.0;
final double fontSizeSmall = 20.0;

final Color primaryCol = Colors.black;
final Color secondaryCol = Colors.red;

final String fontMont = "Montserrat"; //Montserrat Font

var backgroundGradient = LinearGradient(
  //Gradient we use for page background
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [Colors.teal, Color(0xFFffa781)],
);
// below is a loading screen which is used for pages that have to wait for data from the database
Widget buildLoadingScreen(BuildContext context) {
  return Column(
    children: [
      Expanded(
        flex: 1,
        child: Container(
          decoration: BoxDecoration(
            gradient: backgroundGradient,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 0,
                  height: 0,
                ),
                Container(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.only(top: 25),
                  alignment: Alignment.center,
                  child: Text(
                    "Loading...",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: fontMont,
                        fontSize: 22,
                        color: Colors.white,
                        decoration: TextDecoration.none),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

class MySpacing extends StatelessWidget {
  final double height;

  MySpacing(this.height);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height),
    );
  }
}

class MyHoriSpacing extends StatelessWidget {
  final double width;

  MyHoriSpacing(this.width);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width),
    );
  }
}
// coverage:ignore-end