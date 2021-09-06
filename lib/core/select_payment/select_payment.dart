// coverage:ignore-start
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:last_national_bank/classes/accountDetails.dart';
import 'package:last_national_bank/classes/user.class.dart';
import 'package:last_national_bank/config/routes/router.dart';
import 'package:last_national_bank/constants/route_constants.dart';
import 'package:last_national_bank/core/select_payment/widgets/paymentButton.dart';
import 'package:last_national_bank/utils/helpers/icons.dart';
import 'package:last_national_bank/utils/helpers/style.dart';
import 'package:last_national_bank/utils/services/local_db.dart';
import 'package:last_national_bank/utils/services/online_db.dart';
import 'package:last_national_bank/widgets/desktopNav.dart';
import 'package:last_national_bank/widgets/navigation.dart';
import 'package:last_national_bank/widgets/noAccounts.dart';
import 'package:last_national_bank/utils/helpers/back_button_helper.dart';

class SelectPaymentPage extends StatefulWidget {
  @override
  _SelectPaymentPageState createState() => _SelectPaymentPageState();
}

class _SelectPaymentPageState extends State<SelectPaymentPage> {
  User? user;
  List<accountDetails> accountDets = [];

  @override
  void initState() {
    super.initState();

    //Adding the back button listener
    BackButtonInterceptor.add(myInterceptor);

    LocalDatabaseHelper.instance.getUserAndAddress().then((userDB) {
      getAccountDetails(userDB!.idNumber).then((accounts) {
        setState(
          () {
            user = userDB;
            accountDets = accounts;
          },
        );
      });
    });
  }

  @override
  void dispose() {
    //Removing the back button listener
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  //When the back button is pressed, go to Profile Page
  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    return helperInterceptor(
        context: context,
        currentRoute: SelectPaymentRoute,
        goTo: goToProfilePage,
        info: info,
        stopDefaultButtonEvent: stopDefaultButtonEvent);
  }

  // Use loading page instead of red error screen
  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return buildLoadingScreen(context);
    } else {
      if (accountDets.isNotEmpty) {
        return buildPage(context);
      } else {
        return NoAccount();
      }
    }
  }

  /*
  Choose which payment type you want to do, either
  Transfer -> Transfering money from one of your accounts to another one of your accouts
  Payments -> Paying somebody within the bank
  */
  Widget buildPage(BuildContext context) {
    // Used for navigation bar:
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      // Set navigation:
      key: _scaffoldKey,
      drawer: Navigation(
          clientName: user!.firstName, clientSurname: user!.lastName, context: context),

      body: Container(
        // Decorate background
        decoration: BoxDecoration(
          gradient: backgroundGradient,
        ),

        // Column: Three lines icon, Heading, Two buttons
        child: Column(children: [
          if (MediaQuery.of(context).size.width > tabletWidth)
          DesktopTabNavigator(),
          // Open navigation icon (three lines icon)
          if (MediaQuery.of(context).size.width <= tabletWidth)
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: Icon(Icons.menu, color: Colors.white),
              // When the icon is clicked, open the navigation/drawer
              onPressed: () {
                _scaffoldKey.currentState!.openDrawer();
              },
            ),
          ),

          // Spacing
          Padding(
            padding: EdgeInsets.only(top: 20),
          ),

          // Heading
          Text(
            'Select Form of Payment',
            style: new TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w500,
                color: Colors.white),
          ),

          // Spacing
          Padding(
            padding: EdgeInsets.only(top: 20),
          ),

          // First button
          (accountDets.length > 1)
              ? paymentButton(
                  // Pass parameters:

                  // When buton is clicked, do..
                  onTap: () {
                    Navigator.pop(context);
                    goToTransfers(context);
                  },
                  buttonTitle: "Transfers",
                  buttonDescription:
                      "Transfer funds betweeen your own accounts.",
                  buttonIcon: iconFamily.payment,
                )
              : Container(
                  height: 0,
                  width: 0,
                ),

          // Spacing
          Padding(
            padding: EdgeInsets.only(top: 20),
          ),

          // Second button
          paymentButton(
            // Pass parameters:

            // When buton is clicked, do..
            onTap: () {
              Navigator.pop(context);
              goToPayments(context);
            },
            buttonTitle: "Payments",
            buttonDescription: "Make payments to other client's bank accounts.",
            buttonIcon: iconFamily.user,
          ),
        ]),
      ),
    );
  }
}

// coverage:ignore-end
