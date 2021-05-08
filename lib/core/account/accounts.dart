import 'package:flutter/material.dart';
import 'package:last_national_bank/classes/user.class.dart';
import 'package:last_national_bank/core/account/widgets/card_info.dart';
import 'package:last_national_bank/utils/helpers/helper.dart';
import 'package:last_national_bank/utils/helpers/style.dart';
import 'package:last_national_bank/utils/services/local_db.dart';

class Accounts extends StatefulWidget {
  @override
  _AccountsState createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  User? user;

  //TODO: Change once you got the data from db
  String accountType = "Cheque";
  String accountNumber = seperateCardNumber("1462789441537854");
  String firstName = "Arneev";
  String middleNames = "Mohan Joker";
  String lastName = "Singh";

  String cardType = "VISA"; // There is no field in the db for this
  //There shouldn't be one coz it only applies to transactions account
  //So we can sort that out in the future, but for now hardcode it

  int currAmount = 420;

  @override
  void initState() {
    // user = User();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double verticalPadding = 45;
    //TODO: Change this to 'user != null'
    return (user == null)
        ? Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              gradient: backgroundGradient,
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: verticalPadding),
                ),
                Text(
                  'Accounts',
                  style: new TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                Padding(
                  padding: EdgeInsets.only(top: verticalPadding),
                ),
                AccountCardInfo(
                    accountType: accountType,
                    accountNumber: accountNumber,
                    firstName: firstName,
                    middleNames: middleNames,
                    lastName: lastName,
                    cardType: cardType,
                    currAmount: currAmount)
              ],
            ),
          )
        : Container();
  }
}
