// coverage:ignore-start
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:last_national_bank/classes/accountDetails.dart';
import 'package:last_national_bank/utils/helpers/style.dart';
//import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ScrollAccount extends StatelessWidget {
  List<accountDetails> acc = [];
  final double itemSize;
  ScrollController controller; // controller used to control scroll function
  Function index;
  double
      width; // getIndex function from transfer.dart (used to set the current account chosen index)

  ScrollAccount(
      {required this.acc,
      required this.itemSize,
      required this.controller,
      required this.index,
      required this.width});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    int indexNo =
        0; // indexNo is used to change the index whenever up/down arrow is clicked

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Scroll up container
        Container(
          width: size.width * width,
          height: size.width * 0.1,

          alignment: Alignment.center,

          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
            ),
          ),

          // Set icon button
          child: IconButton(
            icon: new Icon(Icons.keyboard_arrow_up_rounded),
            alignment: Alignment.center,
            onPressed: () {
              // Scroll up
              // itemSize*35 is how much of the list scrolls up -
              // if number is smaller, then you can see information from two accounts in the little white block (hardcoded)
              controller.animateTo(controller.offset - itemSize * 35,
                  curve: Curves.linear, duration: Duration(milliseconds: 100));

              // Prevent negative index
              if (indexNo > 0) {
                indexNo--;
              }

              // Pass index number into getIndex function in transfer.dart
              index(indexNo);
            },
          ),
        ),

        // Center part with account information
        Container(
          width: size.width * width,
          height: size.width * 0.31,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: ListView.builder(
            // Use buttons to scroll, not fingers/mouse
            physics: NeverScrollableScrollPhysics(),
            controller: controller,
            itemCount: acc.length,

            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: __bankDetails(
                  accountType: this.acc[index].accountType,
                  accountNumber: this.acc[index].accountNumber,
                  amount: this.acc[index].currentBalance,
                ),
              );
            },
          ),
        ),

        // Scroll down container
        Container(
          width: size.width * width,
          height: size.width * 0.1,

          alignment: Alignment.center,

          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15.0),
              bottomRight: Radius.circular(15.0),
            ),
          ),

          // Set icon button
          child: IconButton(
            icon: new Icon(Icons.keyboard_arrow_down_rounded),

            // Scroll down
            // itemSize*35 is how much of the list scrolls up -
            // if number is smaller, then you can see information from two accounts in the little white block (hardcoded)
            onPressed: () {
              controller.animateTo(controller.offset + itemSize * 35,
                  curve: Curves.linear, duration: Duration(milliseconds: 100));

              // Prevent range out of index
              if (indexNo < itemSize - 1) {
                indexNo++;
              }

              // Pass index number into getIndex function in transfer.dart
              index(indexNo);
            },
          ),
        ),
      ],
    );
  }
}

class __bankDetails extends StatelessWidget {
  final String accountType;
  final String accountNumber;
  final double amount;

  __bankDetails({
    required this.accountType,
    required this.accountNumber,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        //Heading
        Text(
          accountType,
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
            color: Colors.black,
            fontSize: 15,
            fontFamily: fontMont,
          ),
        ),

        Text(
          accountNumber,
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontFamily: fontMont,
          ),
        ),

        Padding(
          padding: EdgeInsets.only(top: 10),
        ),

        Text(
          "Balance: ",
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontFamily: fontMont,
          ),
        ),

        Text(
          "R$amount",
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontFamily: fontMont,
          ),
        ),
      ]),
    );
  }
}
// coverage:ignore-end
