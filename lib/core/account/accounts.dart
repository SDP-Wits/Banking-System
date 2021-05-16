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

  List<accountDetails> acc = [];
  int uniqueAccountTypes = 999;

  @override
  void initState() {
    super.initState();

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
            Navigator.pop(context);
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

    if ((acc.isNotEmpty)) {
      return Scaffold(
        key: _scaffoldKey,
        drawer: Navigation(
            clientName: user!.firstName, clientSurname: user!.lastName),
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Container(
            decoration: BoxDecoration(
              gradient: backgroundGradient,
            ),
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
                          ),
                        );
                      }),
                ),
                (acc.length < uniqueAccountTypes)
                    ? Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 16.0),
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
                                  goToCreateAccount(context);
                                }),
                          ),
                        ],
                      )
                    : Container(width: 0, height: 0)
              ],
            ),
          ),
        ),
      );
    } else {
      return _buildLoadingScreen();
    }
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
