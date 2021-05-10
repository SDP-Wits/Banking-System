import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../classes/accountDetails.dart';
import '../../classes/user.class.dart';
import '../../utils/helpers/style.dart';
import '../../utils/services/local_db.dart';
import '../../utils/services/online_db.dart';
import 'widgets/card_info.dart';

class Accounts extends StatefulWidget {
  @override
  _AccountsState createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  User? user;

  String cardType = "VISA"; // There is no field in the db for this
  //There shouldn't be one coz it only applies to transactions account
  //So we can sort that out in the future, but for now hardcode it

  List<accountDetails> acc = [];

  @override
  void initState() {
    super.initState();

    LocalDatabaseHelper.instance.getUserAndAddress().then((userDB) {
      getAccountDetails(userDB!.idNumber).then((account) {
        setState(() {
          user = userDB;
          acc = account;

          if (acc.isEmpty) {
            Fluttertoast.showToast(
                msg: "Account Does Not Exist",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.teal,
                textColor: Colors.white,
                fontSize: 16.0);
            Navigator.pop(context);
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //Moved loading building page inside the build page
    return buildPage();
  }

  Widget buildPage() {
    accountDetails account = acc[0];
    final Size size = MediaQuery.of(context).size;
    final double verticalPadding = 45;

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
        : _buildLoadingScreen();
  }
}

Widget _buildLoadingScreen() {
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
