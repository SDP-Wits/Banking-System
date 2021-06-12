// coverage:ignore-start
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:last_national_bank/classes/accountDetails.dart';
import 'package:last_national_bank/classes/user.class.dart';
import 'package:last_national_bank/config/routes/router.dart';
import 'package:last_national_bank/core/transfer/widgets/scrollAccount.dart';
import 'package:last_national_bank/utils/helpers/dialogs.dart';
import 'package:last_national_bank/utils/helpers/style.dart';
import 'package:last_national_bank/utils/services/local_db.dart';
import 'package:last_national_bank/utils/services/online_db.dart';
import 'package:last_national_bank/widgets/heading.dart';
import 'package:last_national_bank/core/transfer/transfer.functions.dart';
import 'package:last_national_bank/widgets/navigation.dart';
import 'package:last_national_bank/widgets/noAccounts.dart';

class Transfers extends StatefulWidget {
  @override
  _TransfersState createState() => _TransfersState();
}

// Used to determine the account chosen in both scroll widgets
int accountFromIndex = 0;
int accountToIndex = 0;

class _TransfersState extends State<Transfers> {
  User? user;
  List<accountDetails> acc = [];
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

    //Getting unique account details
    LocalDatabaseHelper.instance.getUserAndAddress().then((userDB) {
      getAccountDetails(userDB!.idNumber).then((account) {
        getNumberOfAccounts().then((numberAccounts) {
          setState(() {
            user = userDB;
            acc = account;
          });
        }); //End of future getting unique account types
      });
    });
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    goToAdminVerificationStatus(context);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return (user == null)
        ? buildLoadingScreen()
        : (acc.isEmpty)
            ? NoAccount()
            : Scaffold(
                key: _scaffoldKey,
                drawer: Navigation(
                    clientName: user!.firstName, clientSurname: user!.lastName
                ),
                body: SingleChildScrollView(
                  child: Container(
                    height: size.height,
                    decoration: BoxDecoration(
                      gradient: backgroundGradient,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        Heading("Transfers"),
                        // Spacing
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                        ),
                        // Scroll widgets with headings and stuff
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Transfer From:',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: fontMont,
                                fontSize: 15.0,
                              ),
                            ),
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

                        Container(
                          width: size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // From
                              Container(
                                width: size.width * 0.45,
                                child: ScrollAccount(
                                  acc: acc,
                                  controller: controller1,
                                  setIndex: getAccountFromIndex,
                                ),
                              ),

                              // To
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

                        // amount
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

                        // reference
                        InputField(
                          text: "Reference Name",
                          child: TextField(
                            // maxLength: 11,
                            decoration: inputInputDecoration,
                            controller: referenceNameController,
                            onChanged: onChangeReferenceName,
                            textAlign: TextAlign.center,
                            style: inputTextStyle,
                          ),
                        ),

                        // Send button
                        TextButton(
                          onPressed: () {
                            submitTransfer(
                                    acc[accountFromIndex].currentBalance,
                                    acc[accountFromIndex].accountNumber,
                                    acc[accountToIndex].accountNumber,
                                    this.context)
                                .then((success) {
                              if (success) {
                                setState(() {
                                  acc[accountFromIndex].currentBalance -=
                                      double.parse(amountText);

                                  acc[accountToIndex].currentBalance +=
                                      double.parse(amountText);

                                  emptyTextTransfer();
                                });

                                goToTimelineDialog(context);
                              }
                            });
                          },
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
                                        10.0, // has the effect of softening the shadow
                                    spreadRadius:
                                        1.0, // has the effect of extending the shadow
                                    offset: Offset(
                                      5.0, // horizontal, move right 10
                                      5.0, // vertical, move down 10
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

// Creates input boxes
class InputField extends StatelessWidget {
  final String text;
  final Widget child;

  InputField({required this.text, required this.child});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            text,
            style: TextStyle(
              color: Colors.white,
              fontFamily: fontMont,
              fontSize: 15.0,
            ),
          ),
        ),
        Container(
          width: size.width * 0.9,
          margin: EdgeInsets.only(bottom: 5.0),
          padding: EdgeInsets.all(5),
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
            borderRadius: BorderRadius.only(
              bottomLeft: borderRadius,
              bottomRight: borderRadius,
              // topRight: borderRadius,
            ),
          ),
          child: Container(width: (size.width * 0.9), child: child),
        ),
      ],
    );
  }
}

var inputTextStyle = TextStyle(
  color: Colors.black,
  fontFamily: fontMont,
  fontSize: 16.0,
);

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
