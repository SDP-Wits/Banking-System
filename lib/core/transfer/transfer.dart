// coverage:ignore-start
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:last_national_bank/classes/accountDetails.dart';
import 'package:last_national_bank/classes/user.class.dart';
import 'package:last_national_bank/config/routes/router.dart';
import 'package:last_national_bank/constants/route_constants.dart';
import 'package:last_national_bank/core/transfer/transfer.functions.dart';
import 'package:last_national_bank/core/transfer/widgets/scrollAccount.dart';
import 'package:last_national_bank/utils/helpers/dialogs.dart';
import 'package:last_national_bank/utils/helpers/ignore_helper.dart';
import 'package:last_national_bank/utils/helpers/style.dart';
import 'package:last_national_bank/utils/services/local_db.dart';
import 'package:last_national_bank/utils/services/online_db.dart';
import 'package:last_national_bank/widgets/heading.dart';
import 'package:last_national_bank/widgets/navigation.dart';
import 'package:last_national_bank/widgets/noAccounts.dart';
import 'package:last_national_bank/utils/helpers/back_button_helper.dart';

/*
The Transfers class allows for clients to make a transfer between their own bank accounts.
Clients can have up to and including 4 bank accounts with the bank and this feature allows
them to transfer funds between two accounts.

FRONT END
==========================================================================================
The need input data required from clients for this UI includes:
  - Account number that the client wishes to make the transfer FROM (accountFrom)
  - Account number that the client wishes to make the transfer TO (accountTo)
  - The amount the client wishes to transfer
  - The refernce name of the transaction
AccountFrom and AccountTo are presented in the form of scroll widgets which reduces user input.

BACK END
==========================================================================================
There is an http request and PHP file that gets all the accounts that the client already has 
with the bank which is used to display account information in the scroll widgets.

There is an http request and PHP file that takes the input data from this UI and enters it into
the respective tables in the database.
*/

class Transfers extends StatefulWidget {
  @override
  _TransfersState createState() => _TransfersState();
}

// Global variables used to determine the account chosen in both scroll widgets
int accountFromIndex = 0;
int accountToIndex = 0;

class _TransfersState extends State<Transfers> {
  User? user; // User information
  List<accountDetails> acc = []; // User's account information
  // Two controlers to control scroll functionality on the two widgets (accountFrom and accountTo)
  late ScrollController controller1;
  late ScrollController controller2;

  @override
  void initState() {
    // Initialise scroll contorllers
    controller1 = ScrollController();
    controller2 = ScrollController();

    super.initState();

    BackButtonInterceptor.add(myInterceptor);

    // Get user details
    LocalDatabaseHelper.instance.getUserAndAddress().then((userDB) {
      // Get user's account details
      getAccountDetails(userDB!.idNumber).then((account) {
        getNumberOfAccounts().then((numberAccounts) {
          setState(() {
            user = userDB;
            acc = account;
          });
        }); // End of future getting unique account types
      }); // End of future getting user's account details
    }); // End of future getting user details
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    return helperInterceptor(
        context: context,
        currentRoute: TransferRoute,
        goTo: goToSelectPayment,
        info: info,
        stopDefaultButtonEvent: stopDefaultButtonEvent);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // _scaffoldKey is the key used for the navigation drawer
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return (user == null)
        // While the user's dettails are being retrieved, display the loading screen
        ? buildLoadingScreen(context)

        // When the user's details have been retrieved,
        // if the do not have an account, display the NoAccount Widget,
        // otherwise display the Scaffold Widget.
        : (acc.isEmpty)
            ? NoAccount()
            : Scaffold(
                // Set navigation drawer
                key: _scaffoldKey,
                drawer: Navigation(
                    clientName: user!.firstName, clientSurname: user!.lastName),

                // SingleChildScrollView allows the page to be scrollable
                body: SingleChildScrollView(
                  // Page container
                  child: Container(
                    height: size.height,

                    // Background
                    decoration: BoxDecoration(
                      gradient: backgroundGradient,
                    ),

                    // All widets on the UI are displayed one below another (column form)
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Three-line menu bar on the top to open the navigation drawer
                        Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            icon: Icon(Icons.menu, color: Colors.white),
                            onPressed: () {
                              _scaffoldKey.currentState!.openDrawer();
                            },
                          ),
                        ),

                        // Global Heading Widget
                        Heading("Transfers"),

                        // Spacing
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                        ),

                        // Two scroll widgets are displayed next to each other with respective headings
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Heading for first scroll widget (accountFrom)
                            Text(
                              'Transfer From:',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: fontMont,
                                fontSize: 15.0,
                              ),
                            ),

                            // Heading for second scroll widget (accountTo)
                            Text(
                              'Transfer To:  ',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: fontMont,
                                fontSize: 15.0,
                              ),
                            ),
                          ],
                        ),

                        // Two scroll widgets are placed in a container so that they can be evenly spaced
                        Container(
                          width: size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // accountFrom scroll widget
                              Container(
                                width: size.width * 0.45,
                                child: ScrollAccount(
                                  acc: acc,
                                  controller: controller1,
                                  setIndex: getAccountFromIndex,
                                ),
                              ),

                              // accountTo scroll widget
                              Container(
                                width: size.width * 0.45,
                                child: ScrollAccount(
                                  acc: acc,
                                  controller: controller2,
                                  setIndex: getAccountToIndex,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Input field for transfer amount
                        InputField(
                          text: "Amount",
                          child: TextField(
                            maxLines: 1,
                            decoration: inputInputDecoration,
                            controller: amountController,
                            onChanged: onChangeAmount,
                            textAlign: TextAlign.center,
                            style: inputTextStyle,
                          ),
                        ),

                        // Input field for transfer reference
                        InputField(
                          text: "Reference Name",
                          child: TextField(
                            //maxLength: 11,
                            decoration: inputInputDecoration,
                            controller: referenceNameController,
                            onChanged: onChangeReferenceName,
                            textAlign: TextAlign.center,
                            style: inputTextStyle,
                          ),
                        ),

                        // Send button which allows transfer to be processed
                        TextButton(
                          onPressed: () {
                            // Make transfer
                            submitTransfer(
                                    acc[accountFromIndex].currentBalance,
                                    acc[accountFromIndex].accountNumber,
                                    acc[accountToIndex].accountNumber,
                                    this.context)
                                .then((success) {
                              if (success) {
                                setState(() {
                                  // Update the current balance in both respective accounts after transaction is successful
                                  acc[accountFromIndex].currentBalance -=
                                      double.parse(amountText);
                                  acc[accountToIndex].currentBalance +=
                                      double.parse(amountText);
                                  emptyTextTransfer(); // Clear InputFields
                                });

                                // Dialogue which asks user if they wish to make another transfer or
                                // be directed to the Timeline UI
                                Navigator.pop(context);
                                goToTimelineDialog(context);
                              }
                            });
                          },

                          // Container which designs the 'Send' button
                          child: Container(
                            width: size.width * 0.5,
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black54,
                                    blurRadius:
                                        10.0, // Has the effect of softening the shadow
                                    spreadRadius:
                                        1.0, // Has the effect of extending the shadow

                                    offset: Offset(
                                      5.0, // Horizontal, move right 10
                                      5.0, // Vertical, move down 10
                                    ),
                                  ),
                                ]),
                            child: Text(
                              "Send",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.teal,
                                fontSize: 18.0,
                                fontFamily: fontMont,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
  }
}

// Creates the InputField boxes for user input data
class InputField extends StatelessWidget {
  // InputField variables
  final String text; // Heading -> ('Amount' or 'Reference')
  final Widget child; // TextField widget with respective controllers

  InputField({required this.text, required this.child});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // InputField (designed in column form)
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top part of InputField (transparent) which contains the InputField title
        Container(
          width: size.width * 0.9,
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.only(
              topLeft: borderRadius,
              topRight: borderRadius,
            ),
          ),
          child: Text(
            text, // ('Amount' or 'Reference')
            style: TextStyle(
              color: Colors.white,
              fontFamily: fontMont,
              fontSize: 15.0,
            ),
          ),
        ),

        // Bottom part (white) of InputField
        Container(
          width: size.width * 0.9,
          margin: EdgeInsets.only(bottom: 5.0),
          padding: EdgeInsets.all(5),

          // Adding shadows
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.white24,
                offset: Offset(4.0, 2.0), //(x,y)
                blurRadius: 6.0,
              ),
              BoxShadow(
                color: Colors.white24,
                offset: Offset(-4.0, 2.0), //(x,y)
                blurRadius: 6.0,
              ),
            ],

            color: Colors.white,

            // Rounding corners
            borderRadius: BorderRadius.only(
              bottomLeft: borderRadius,
              bottomRight: borderRadius,
            ),
          ),

          // Adds TextField widget as child
          child: Container(width: (size.width * 0.9), child: child),
        ),
      ],
    );
  }
}

// Text style used for InputField
var inputTextStyle = TextStyle(
  color: Colors.black,
  fontFamily: fontMont,
  fontSize: 16.0,
);

// Decoration used for InputField
var inputInputDecoration = InputDecoration(
  enabledBorder: InputBorder.none,
  focusedBorder: InputBorder.none,
);

const borderRadius = Radius.circular(15.0);

// Two functions are passed into ScrollAccount widget to set the index of the accounts chosen
getAccountFromIndex(int newIndex) {
  accountFromIndex = newIndex;
}

getAccountToIndex(int newIndex) {
  accountToIndex = newIndex;
}

// coverage:ignore-end
