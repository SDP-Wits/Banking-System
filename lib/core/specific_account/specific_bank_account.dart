// coverage:ignore-start
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hovering/hovering.dart';
import 'package:last_national_bank/classes/accountTypes.dart';
import 'package:last_national_bank/core/specific_account/widgets/listTransactions.dart';
import 'package:last_national_bank/core/statements/statements.function.dart';
import 'package:last_national_bank/utils/helpers/back_button_helper.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:last_national_bank/classes/accountDetails.dart';
import 'package:last_national_bank/classes/specificAccount.dart';
import 'package:last_national_bank/classes/user.class.dart';
import 'package:last_national_bank/config/routes/router.dart';
import 'package:last_national_bank/constants/app_constants.dart';
import 'package:last_national_bank/constants/route_constants.dart';
import 'package:last_national_bank/core/account/widgets/card_info.dart';
import 'package:last_national_bank/utils/helpers/helper.dart';
import 'package:last_national_bank/utils/helpers/style.dart';
import 'package:last_national_bank/utils/services/local_db.dart';
import 'package:last_national_bank/utils/services/online_db.dart';
import 'package:last_national_bank/widgets/desktopNav.dart';
import 'package:last_national_bank/widgets/deviceLayout.dart';
import 'package:last_national_bank/widgets/heading.dart';
import 'package:last_national_bank/widgets/navigation.dart';
import 'package:last_national_bank/utils/helpers/icons.dart';

/*
The SpecificAccountPage class allows for clients to view a apecific account that the client swiped
on in the previous UI (Accounts class). This UI displays the card widget that shows the account details,
and a swipe widget which displays all the relevant transactions for the specific account.

FRONT END
==========================================================================================
There is no need for any input data but the front end includes displaying data:
  - The card widget displays ther user's account details (account number, account current
    amount, account holder name)
  - A swipe up widget which displays all transaction details per transaction (transaction date,
    transaction reference number, transaction reference name)

BACK END
==========================================================================================
In the previous UI, when all user's accounts are retrieved, when a user swipes on a card widget
the account details for that specific account that the client swiped on is sent to this UI.

All transactions (logs) are retireved using a php file and http request for the specific account
chosen.
*/

//these vriables need to be accssed in two places that aren't in the same widget so they are global
List<String> months = [];
List<specificAccount> transactionsForAccount = [];

class SpecificAccountPage extends StatefulWidget {
  // Account details for specific account is retrieved from the previous UI (Accounts)
  accountDetails acc;
  SpecificAccountPage({required this.acc});

  @override
  _SpecificAccountPageState createState() => _SpecificAccountPageState();
}

class _SpecificAccountPageState extends State<SpecificAccountPage>
    with TickerProviderStateMixin {
  // User details
  User? user;
  bool finishLoad = false;

  // All transactions (logs) are retrieved for the specific account
  List<specificAccount>? logs;

  // Variables for transaction history scroll widget
  double radiusSize = 30.0;
  bool swipedUp = false;

  // Animation controllers and animation for scroll widget drawer going up and down
  AnimationController? animationController;
  Animation? yOffsetAnimation;

  // _scaffoldKey is the key used for the navigation drawer
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    //Get Months
    LocalDatabaseHelper.instance.getUserAndAddress().then((user) {
      //Get transaction history for this

      getRecentTransactions((user!.idNumber).toString())
          .then((specificAccounts) {
        for (specificAccount specificAcc in specificAccounts) {
          if (specificAcc.accountNumber == this.widget.acc.accountNumber ||
              specificAcc.accountTo == this.widget.acc.accountNumber ||
              specificAcc.accountFrom == this.widget.acc.accountNumber) {
            DateTime date = DateTime(
              int.parse(specificAcc.timeStamp.substring(0, 4)),
              int.parse(specificAcc.timeStamp.substring(5, 7)),
            );

            String _month = getMonthFromDate(date);

            if (!months.contains(_month)) {
              months.add(_month);
            }

            transactionsForAccount.add(specificAcc);
          }
        }

        setState(() {
          transactionsForAccount = [...transactionsForAccount];
          months = [...months];
          finishLoad = true;
        });
      });
    });

    //End of Get Months

    // For the system back button
    BackButtonInterceptor.add(myInterceptor);
    if (kIsWeb) {
      BackButtonInterceptor.removeAll();
    }

    // Intialization of animation controller and animation
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    );

    animationController!.addListener(() {
      setState(() {});
    });

    // Gets user details and transaction history log
    LocalDatabaseHelper.instance.getUserAndAddress().then((userDB) {
      setState(() {
        user = userDB;
      });
      getSpecificAccount(this.widget.acc.accountNumber).then((logsIn) {
        setState(() {
          logs = logsIn;
          logs = logs!.reversed.toList();
        });
      });
    });
  }

  @override
  void dispose() {
    // Dispose of BackButtonInterceptor
    BackButtonInterceptor.remove(myInterceptor);

    // Dispose of animationController from RAM once done with it
    animationController!.dispose();
    super.dispose();
  }

  // When the system back button is clicked move back to the View Accounts page
  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    return helperInterceptor(
        context: context,
        currentRoute: SpecificAccountRoute,
        goTo: goToViewAccount,
        info: info,
        stopDefaultButtonEvent: stopDefaultButtonEvent);
  }

  @override
  Widget build(BuildContext context) {
    return (!finishLoad)
        ? buildLoadingScreen(context)
        : DeviceLayout(
            phoneLayout: buildPage(context),
            desktopWidget: desktopLayout(context),
          );
  }

  // ========================================================== WEB ==============================================
  Widget desktopLayout(BuildContext context) {
    final size = getSize(context);

    return SingleChildScrollView(
      child: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: backgroundGradient,
        ),
        child: Column(
          children: [
            if (MediaQuery.of(context).size.width > tabletWidth)
              DesktopTabNavigator(),

            // Spacing
            Padding(
              padding: EdgeInsets.only(top: 20),
            ),

            Heading(this.widget.acc.accountType),

            // Spacing
            Padding(
              padding: EdgeInsets.only(top: 20),
            ),

            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    children: [
                      // Card widget that displays the user's specific account details
                      Container(
                        width: size.width / 2.5,
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: AccountCardInfo(
                          accountType: this.widget.acc.accountType,
                          accountNumber: this.widget.acc.accountNumber,
                          firstName: this.widget.acc.fName,
                          middleNames: this.widget.acc.mName,
                          lastName: this.widget.acc.lName,
                          cardType: "VISA",
                          currAmount: this.widget.acc.currentBalance,
                          accountTypeId: this.widget.acc.accountTypeId,
                          canSwipe: false,
                        ),
                      ),

                      // Spacing
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                      ),

                      Row(children: [
                        Text(
                          'Add New Transaction:',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: fontMont,
                          ),
                        ),

                        // Spacing
                        Padding(
                          padding: EdgeInsets.only(right: 45),
                        ),

                        // Floating + button
                        Container(
                          width: 50,
                          height: 50,
                          alignment: Alignment.centerRight,
                          child: FloatingActionButton(
                            onPressed: () {
                              //When floating action button is pressed
                              //this will go to 'select payment method' page
                              goToSelectPayment(context);
                            },
                            backgroundColor: Colors.teal,
                            child: Text(
                              '+',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontFamily: fontMont,
                              ),
                            ),
                          ),
                        ),
                      ]),

                      // Spacing
                      Padding(
                        padding: EdgeInsets.only(top: 40),
                      ),

                      Row(children: [
                        Text(
                          'Request Statement PDF:',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: fontMont,
                          ),
                        ),

                        // Spacing
                        Padding(
                          padding: EdgeInsets.only(right: 30),
                        ),

                        // Floating + button
                        Container(
                          width: 50,
                          height: 50,
                          child: FloatingActionButton(
                            onPressed: () {
                              //Choose Previous Months
                              showMonthDialog(
                                  context, months, transactionsForAccount);
                            },
                            backgroundColor: Colors.teal,
                            child: Icon(
                              Icons.print,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ]),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.topRight,
                        child: Text(
                          'Account Transactions:',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: fontMont,
                          ),
                        ),
                      ),
                      // Spacing
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                      ),
                      Container(
                        width: size.width / 2.3,
                        height: size.height / 1.7,
                        alignment: Alignment.topRight,
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        decoration: BoxDecoration(
                            // color: Colors.white.withAlpha(128),
                            ),
                        child: DraggableScrollableSheet(
                          initialChildSize: 1, // Size when page loads
                          minChildSize: 1, // Minimum size allowed
                          maxChildSize: 1, // Maximum size allowed

                          builder: (BuildContext context,
                              ScrollController scrollController) {
                            // Scroll widget
                            if (user == null || logs == null) {
                              return buildLoadingScreen(context);
                            } else {
                              return listTransactions(
                                  logs: logs,
                                  scrollController: scrollController,
                                  acc: this.widget.acc);
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ========================================================== PHONE ==============================================

  // Use loading page instead of red error screen
  Widget buildPage(BuildContext context) {
    // While data is being loaded, display loading screen
    if (user == null || logs == null) {
      return buildLoadingScreen(context);
    } else {
      return Scaffold(

          // Set navigation drawer
          key: _scaffoldKey,
          drawer: Navigation(
              clientName: user!.firstName,
              clientSurname: user!.lastName,
              context: context),

          // buildPage
          body: Container(
            decoration: BoxDecoration(
              gradient: backgroundGradient,
            ),
            child: phoneLayout(context),
          ));
    }
  }

  Widget phoneLayout(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    //Setting the transaction history list animation variable
    yOffsetAnimation = Tween<double>(begin: size.height * 0.5, end: 0).animate(
        CurvedAnimation(
            parent: animationController!, curve: Curves.easeInCubic));

    return Stack(
      children: <Widget>[
        //Detects if the user moved their finger up or down (swiped up or down)
        GestureDetector(
          onVerticalDragUpdate: (DragUpdateDetails updateDetails) {
            if (updateDetails.delta.dy < -swipeSensitivty && !swipedUp) {
              //Bring up the transaction history
              swipedUp = true;
              animationController!.animateTo(size.width * 0.5);
            } else if (updateDetails.delta.dy > swipeSensitivty && swipedUp) {
              //Bring down the transaction history
              swipedUp = false;
              animationController!.animateBack(0);
            }
          },
        ),

        Positioned(
          top: 0,
          bottom: 80,
          left: 0,
          right: 0,
          child: Container(
            child: SingleChildScrollView(
              child: Column(children: [
                if (MediaQuery.of(context).size.width > tabletWidth)
                  DesktopTabNavigator(),

                // Three-line menu bar on the top to open the navigation drawer
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

                // Spacing
                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),

                // Card widget that displays the user's specific account details
                Container(
                  width: (size.width < tabletWidth) ? null : size.width * 0.5,
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: AccountCardInfo(
                    accountType: this.widget.acc.accountType,
                    accountNumber: this.widget.acc.accountNumber,
                    firstName: this.widget.acc.fName,
                    middleNames: this.widget.acc.mName,
                    lastName: this.widget.acc.lName,
                    cardType: "VISA",
                    currAmount: this.widget.acc.currentBalance,
                    accountTypeId: this.widget.acc.accountTypeId,
                    canSwipe: false,
                  ),
                ),

                // Spacing
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 18),
                ),

                // Spacing
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),

                  // Function is at the bottom
                  child: heading(),
                ),

                // Swipe up arrow to indicate to the user that they need to swipe up
                GestureDetector(
                  onTap: () {
                    animationController!.animateTo(size.width * 0.5);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 5, top: size.height * 0.2),
                    child: Icon(
                      Icons.arrow_upward,
                      color: Colors.teal,
                      size: 36.0,
                    ),
                  ),
                ),

                // Title
                Text(
                  "Swipe Up for Transaction History",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: fontMont,
                    fontSize: 20,
                  ),
                ),
              ]),
            ),
          ),
        ),

        // Makes the transaction history come up when dragged up
        // This widgets allows to offset the transaction history
        // at start it will be offseted all the way to the bottom of the
        // page
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(1, 3, yOffsetAnimation!.value),
          child: DraggableScrollableSheet(
            initialChildSize: 0.2, // Size when page loads
            minChildSize: 0.2, // Minimum size allowed
            maxChildSize: 0.8, // Maximum size allowed

            builder: (BuildContext context, ScrollController scrollController) {
              // Scroll widget

              return listTransactions(
                  logs: logs,
                  scrollController: scrollController,
                  acc: this.widget.acc);
            },
          ),
        ),
      ],
    );
  }
}

// heading is the title: "Add New Transaction"
// and the floting button to add a new transaction
class heading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Request Statement PDF:',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: fontMont,
              ),
            ),

            
            // Request pdf button
            Container(
              width: 50,
              height: 50,
              alignment: Alignment.topRight,
              child: FloatingActionButton(
                onPressed: () {
                  //TODO: go to pdf page
                  showMonthDialog(
                                  context, months, transactionsForAccount);
                },
                backgroundColor: Colors.teal,
                child: Icon(Icons.insert_drive_file_outlined),

                ///Expanded(child:FittedBox(child: Icon(Icons.dynamic_feed),fit: BoxFit.fill))
              ),
            ),
          ],
        ),
        Row(
          children : [Padding(
              padding: EdgeInsets.only(bottom: 30),
            ),]
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Title
            Text(
              'Add New Transaction',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: fontMont,
              ),
            ),

            // Floating + button
            Container(
              width: 50,
              height: 50,
              child: FloatingActionButton(
                onPressed: () {
                  //When floating action button is pressed
                  //this will go to 'select payment method' page
                  goToSelectPayment(context);
                },
                backgroundColor: Colors.teal,
                child: Text(
                  '+',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: fontMont,
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}

Future<void> showMonthDialog(BuildContext context, List<String> months,
    List<specificAccount> transactionsForAccount) async {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        final size = getSize(context);
        return AlertDialog(
          backgroundColor: Colors.teal,
          actions: [],
          title: Heading("Statements"),
          insetPadding: EdgeInsets.all(40),
          titlePadding: EdgeInsets.all(20),
          content: SingleChildScrollView(
            child: Container(
              // width: (size.width < tabletWidth)
              //     ? size.width * 0.8
              //     : size.width * 0.5,
              // height: size.height * 0.75,
              child: (transactionsForAccount.isEmpty)
                  ? Center(
                      child: Text(
                        "No Transactions",
                        style: TextStyle(
                          fontFamily: fontDefault,
                          fontSize: fontSizeMedium,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: months.map((e) {
                        return GestureDetector(
                          onTap: () {
                            Fluttertoast.showToast(msg: "Generating PDF");
                            generatePDF(transactionsForAccount.where((element) {
                              DateTime date = DateTime(
                                int.parse(element.timeStamp.substring(0, 4)),
                                int.parse(element.timeStamp.substring(5, 7)),
                              );

                              String _month = getMonthFromDate(date);

                              return e == _month;
                            }).toList());

                            Navigator.pop(context);
                          },
                          child: HoverContainer(
                            hoverDecoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(3000),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                            margin: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.black38,
                              borderRadius: BorderRadius.circular(3000),
                            ),
                            child: Text(
                              e,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: fontDefault,
                                fontSize: fontSizeLarge,
                              ),
                            ),
                          ),
                        );
                      }).toList(growable: false),
                    ),
            ),
          ),
        );
      });
}

// coverage:ignore-end
