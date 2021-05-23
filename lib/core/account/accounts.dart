import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:last_national_bank/config/routes/router.dart';
import 'package:last_national_bank/widgets/navigation.dart';

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

  //Intializing unique account details
  List<accountDetails> acc = [];
  int uniqueAccountTypes = 999;
  bool finishedGetData = false;

  @override
  void initState() {
    super.initState();

    //Getting unique account details
    LocalDatabaseHelper.instance.getUserAndAddress().then((userDB) {
      getAccountDetails(userDB!.idNumber).then((account) {
        getNumberOfAccounts().then((numberAccounts) {
          setState(() {
            uniqueAccountTypes = numberAccounts;
            user = userDB;
            acc = account;
          });

          if (acc.isEmpty) {
            Fluttertoast.showToast(
                msg: "Account Does Not Exist",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.teal,
                textColor: Colors.white,
                fontSize: 16.0);
            setState(() {
              finishedGetData = true;
            });
          }
        }); //End of future getting unique account types
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //Moved loading building page inside the build page
    return buildPage();
  }

  Widget buildPage() {
    final Size size = MediaQuery.of(context).size;
    final double verticalPadding = 45;
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    //Only show if account is not empty
    if ((acc.isNotEmpty)) {
      return Scaffold(
        key: _scaffoldKey,
        drawer: Navigation(
            clientName: user!.firstName, clientSurname: user!.lastName),
        body: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            gradient: backgroundGradient,
          ),
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(Icons.menu, color: Colors.white),
                    onPressed: () {
                      _scaffoldKey.currentState!.openDrawer();
                    },
                  ),
                ),
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
                // Spacing
                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Please swipe right to view that account's transaction history.",
                    style: new TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontFamily: fontMont),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  width: size.width * 0.9,
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      itemCount: acc.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: AccountCardInfo(
                            accountType: acc[index].accountType,
                            accountNumber: acc[index].accountNumber,
                            firstName: acc[index].fName,
                            middleNames: acc[index].mName,
                            lastName: acc[index].lName,
                            cardType: cardType,
                            currAmount: acc[index].currentBalance,
                            accountTypeId: acc[index].accountTypeId,
                            canSwipe: true,
                          ),
                        );
                      }),
                ),
                (acc.length < uniqueAccountTypes)
                    ? floatingCreateAccount(context)
                    : Container(width: 0, height: 0)
              ],
            ),
          ),
        ),
      );
    } else if (finishedGetData) {
      return _noAccount(context);
    } else {
      return _buildLoadingScreen();
    }
  }
}

// Loading screen
Widget _buildLoadingScreen() {
  return Center(
    child: Container(
      width: 50,
      height: 50,
      child: CircularProgressIndicator(),
    ),
  );
}

Widget floatingCreateAccount(BuildContext context) {
  return Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: FloatingActionButton(
            backgroundColor: Colors.white,
            child: Text(
              '+',
              style: TextStyle(
                color: Colors.teal,
                fontSize: 36,
                fontFamily: fontMont,
              ),
            ),
            onPressed: () {
              //When floating action button is pressed
              //this will go to 'create account' page
              goToCreateAccount(context);
            }),
      ),
    ],
  );
}

Widget _noAccount(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 90.0),
          child: Text(
            "No Accounts here...",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: fontMont,
              fontSize: 40,
              color: Colors.teal,
            ),
          ),
        ),
      ),
      floatingCreateAccount(context)
    ],
  );
}
