// coverage:ignore-start

import 'package:flutter/foundation.dart';
import 'package:last_national_bank/utils/helpers/back_button_helper.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:last_national_bank/config/routes/router.dart';
import 'package:last_national_bank/constants/route_constants.dart';
import 'package:last_national_bank/widgets/desktopNav.dart';
import 'package:last_national_bank/widgets/heading.dart';
import 'package:last_national_bank/widgets/navigation.dart';
import 'package:last_national_bank/widgets/noAccounts.dart';

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

  String cardType = "VISA"; // Shows the card type to give it a
  //modern credit/debit card look

  //Intializing unique account details
  List<accountDetails> acc = [];
  int uniqueAccountTypes = 999;
  bool finishedGetData = false;

  @override
  void initState() {
    super.initState();

    //Adding Back Button Listener
    BackButtonInterceptor.add(myInterceptor);
    if (kIsWeb) {
      BackButtonInterceptor.removeAll();
    }

    //Getting unique account details and number of accounts and set it to variables
    LocalDatabaseHelper.instance.getUserAndAddress().then((userDB) {
      getAccountDetails(userDB!.idNumber).then((account) {
        getNumberOfAccounts().then((numberAccounts) {
          setState(() {
            uniqueAccountTypes = numberAccounts;
            user = userDB;
            acc = account;
          });

          //If account is empty show a toast
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
  void dispose() {
    //Removing Back Button Listener

    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  //When the Back Button is pressed this happens, go to Profile Page
  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    return helperInterceptor(
        context: context,
        currentRoute: ViewAccountRoute,
        goTo: goToProfilePage,
        info: info,
        stopDefaultButtonEvent: stopDefaultButtonEvent);
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
            clientName: user!.firstName,
            clientSurname: user!.lastName,
            context: context),
        body: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            gradient: backgroundGradient,
          ),
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Column(
                  children: [
                    if (size.width > tabletWidth) DesktopTabNavigator(),
                    if (MediaQuery.of(context).size.width <= tabletWidth)
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
                      padding: const EdgeInsets.only(top: 25.0),
                    ),

                    Heading("Accounts"),

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
                      width: (size.width > tabletWidth)
                          ? size.width * 0.5
                          : (size.width > phoneWidth)
                              ? size.width * 0.7
                              : size.width * 0.9,
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          itemCount: acc.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 24.0),
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
                  ],
                ),
              ),
              (acc.length < uniqueAccountTypes)
                  //If and only if, the number of accounts the user has is less than the number of
                  //unique accounts, show the + circle button. The user can click on this and it will
                  //take them to the create accounts screen
                  ? new Positioned(
                      left: size.width - 100,
                      top: size.height - 100,
                      child: floatingCreateAccount(context, "Add Account"))
                  : Container(width: 0, height: 0)
            ],
          ),
        ),
      );
    } else if (finishedGetData) {
      return NoAccount();
    } else {
      return buildLoadingScreen(context);
    }
  }
}

// coverage:ignore-end
