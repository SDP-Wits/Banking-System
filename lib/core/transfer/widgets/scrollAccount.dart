// coverage:ignore-start
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:last_national_bank/classes/accountDetails.dart';
import 'package:last_national_bank/utils/helpers/style.dart';
//import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ScrollAccount extends StatefulWidget {
  List<accountDetails> acc = [];
  // final double itemSize;
  ScrollController controller; // controller used to control scroll function
  Function setIndex;
  // double width;

  ScrollAccount(
      {required this.acc, required this.controller, required this.setIndex});

  @override
  _ScrollAccountState createState() => _ScrollAccountState();
}

class _ScrollAccountState extends State<ScrollAccount> {
  int indexNo =
      0; // indexNo is used to change the index whenever up/down arrow is clicked
  accountDetails? accDetails;
  @override
  Widget build(BuildContext context) {
    final itemSize = this.widget.acc.length;
    final size = MediaQuery.of(context).size;

    if (itemSize != 0) {
      accDetails = this.widget.acc[indexNo];
    }

    final containerWidth = size.width * 0.9;

    return (itemSize == 0)
        ? buildLoadingScreen()
        : Container(
            width: containerWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Arrow(
                  onPressed: () {
                    // Prevent negative index
                    setState(() {
                      if (indexNo > 0) {
                        indexNo--;
                        accDetails = this.widget.acc[indexNo];
                      }
                    });

                    // Pass index number into getIndex function in transfer.dart
                    this.widget.setIndex(indexNo);
                  },
                  icon: new Icon(Icons.keyboard_arrow_up_rounded),
                  arrowDecoration: arrowDecorationUp,
                  width: containerWidth,
                ),
                // Scroll up container

                // Center part with account information
                Container(
                  width: containerWidth,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: _BankDetails(
                      accDetails: accDetails!,
                    ),
                  ),
                ),

                // Scroll down container
                Arrow(
                    onPressed: () {
                      // Prevent range out of index
                      setState(() {
                        if (indexNo < itemSize - 1) {
                          indexNo++;
                          accDetails = this.widget.acc[indexNo];
                        }
                      });

                      // Pass index number into getIndex function in transfer.dart
                      this.widget.setIndex(indexNo);
                    },
                    icon: new Icon(Icons.keyboard_arrow_down_rounded),
                    arrowDecoration: arrowDecorationDown,
                    width: containerWidth),
              ],
            ),
          );
  }
}

class _BankDetails extends StatelessWidget {
  final accountDetails accDetails;

  _BankDetails({required this.accDetails});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        //Heading
        Text(
          accDetails.accountType,
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.teal,
            fontSize: 15,
            fontFamily: fontMont,
            fontWeight: FontWeight.bold,
          ),
        ),

        Padding(
          padding: EdgeInsets.only(top: 10),
        ),

        Text(
          "Account Number:",
          textAlign: TextAlign.start,
          style: TextStyle(
            color: Colors.blueGrey,
            fontSize: 15,
            fontFamily: fontMont,
            fontWeight: FontWeight.w400,
          ),
        ),

        Text(
          accDetails.accountNumber,
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontFamily: fontMont,
            fontWeight: FontWeight.w500,
          ),
        ),

        Padding(
          padding: EdgeInsets.only(top: 10),
        ),

        Text(
          "Balance: ",
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.blueGrey,
            fontSize: 15,
            fontFamily: fontMont,
            fontWeight: FontWeight.w400,
          ),
        ),

        Text(
          "R ${accDetails.currentBalance}",
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontFamily: fontMont,
            fontWeight: FontWeight.w500,
          ),
        ),
      ]),
    );
  }
}

class Arrow extends StatelessWidget {
  final Function() onPressed;
  final icon;
  final arrowDecoration;
  final width;

  Arrow(
      {required this.onPressed,
      required this.icon,
      required this.arrowDecoration,
      required this.width});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      alignment: Alignment.center,
      width: width,
      decoration: arrowDecoration,

      // Set icon button
      child: IconButton(
        icon: icon,
        alignment: Alignment.center,
        onPressed: onPressed,
      ),
    );
  }
}

final arrowDecorationUp = BoxDecoration(
  color: Colors.white24,
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(15.0),
    topRight: Radius.circular(15.0),
  ),
);

final arrowDecorationDown = BoxDecoration(
  color: Colors.white24,
  borderRadius: BorderRadius.only(
    bottomLeft: Radius.circular(15.0),
    bottomRight: Radius.circular(15.0),
  ),
);

// coverage:ignore-end
