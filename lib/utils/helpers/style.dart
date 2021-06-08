// coverage:ignore-start
import 'package:flutter/material.dart';

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
    colors: [Colors.teal, Color(0xFFFFBB9D)]);

// PreferredSize appBar(BuildContext context) {
//   return new PreferredSize(
//     child: Container(
//       padding: new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
//       child: new Padding(
//         padding: const EdgeInsets.only(
//             left: 10.0, right: 30.0, top: 5.0, bottom: 10.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             Text(
//               'Timeline',
//               style: new TextStyle(
//                   fontSize: 30.0,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.white),
//             ),
//           ],
//         ),
//       ),
//       decoration: new BoxDecoration(
//           gradient: new LinearGradient(colors: [Colors.blueGrey, Colors.teal]),
//           boxShadow: [
//             new BoxShadow(
//               color: Colors.black,
//               blurRadius: 20.0,
//               spreadRadius: 1.0,
//             )
//           ]),
//     ),
//     preferredSize: new Size(MediaQuery.of(context).size.width, 150.0),
//   );
// }

Widget buildLoadingScreen() {
  return Center(
    child: Container(
      // decoration: BoxDecoration(
      //   gradient: LinearGradient(
      //       begin: Alignment.topRight,
      //       end: Alignment.bottomLeft,
      //       colors: [Colors.blueGrey, Colors.teal]),
      // ),
      width: 50,
      height: 50,
      child: CircularProgressIndicator(),
    ),
  );
}
// coverage:ignore-end
