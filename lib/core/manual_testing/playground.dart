// coverage:ignore-start
import 'package:flutter/material.dart';

import '../account/accounts.dart';

class PlaygroundTest extends StatefulWidget {
  @override
  _PlaygroundTestState createState() => _PlaygroundTestState();
}

class _PlaygroundTestState extends State<PlaygroundTest> {
  // String accountType = "Cheque";
  // String accountNumber = seperateCardNumber("9650178189411487");
  // String firstName = "Arneev";
  // String middleNames = "Mohan Joker";
  // String lastName = "Singh";
  // String cardType = "VISA";

  // int currAmount = 1200;

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   decoration: BoxDecoration(
    //     gradient: backgroundGradient,
    //   ),
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       Center(
    //         child: AccountCardInfo(
    //             accountType: accountType,
    //             accountNumber: accountNumber,
    //             firstName: firstName,
    //             middleNames: middleNames,
    //             lastName: lastName,
    //             cardType: cardType,
    //             currAmount: currAmount),
    //       ),
    //     ],
    //   ),
    // );
    return Accounts();
  }
}

// coverage:ignore-end
