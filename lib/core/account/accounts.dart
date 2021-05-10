import 'package:flutter/material.dart';
import 'package:last_national_bank/classes/accountDetails.dart';
import 'package:last_national_bank/classes/currID.dart';
import 'package:last_national_bank/classes/user.class.dart';
import 'package:last_national_bank/core/account/widgets/card_info.dart';
import 'package:last_national_bank/core/registration/registration.functions.dart';
import 'package:last_national_bank/utils/helpers/helper.dart';
import 'package:last_national_bank/utils/helpers/style.dart';
import 'package:last_national_bank/utils/services/local_db.dart';
import 'package:last_national_bank/utils/services/online_db.dart';
import 'package:last_national_bank/classes/currID.dart';

class Accounts extends StatefulWidget {
  @override
  _AccountsState createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  User? user;

  //TODO: Change once you got the data from db
  String accountType = "Cheque";
  String accountNumber = seperateCardNumber("1478944153785494");
  String firstName = "Arneev";
  String middleNames = "Mohan Joker";
  String lastName = "Singh";

  String cardType = "VISA"; // There is no field in the db for this
  //There shouldn't be one coz it only applies to transactions account
  //So we can sort that out in the future, but for now hardcode it

  int currAmount = 420;

  List<accountDetails> acc = [];


  @override
  void initState() {
    super.initState();

    getAccountDetails(currID.id).then((account) {
      acc = account;
      if (acc.isEmpty) {
        Navigator.pop(context);
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    accountDetails account = acc[0];
    final Size size = MediaQuery.of(context).size;
    final double verticalPadding = 45;
    //TODO: Change this to 'user != null'
    return (acc.isNotEmpty)
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
                    accountType: account.accountType,
                    accountNumber: account.accountNumber,
                    firstName: account.fName,
                    middleNames: account.mName,
                    lastName: account.lName,
                    cardType: cardType,
                    currAmount: account.currentBalance)
              ],
            ),
          )
        : Container();
  }
}
