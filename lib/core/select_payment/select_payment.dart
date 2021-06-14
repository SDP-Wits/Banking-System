// coverage:ignore-start
import 'package:flutter/material.dart';
import 'package:last_national_bank/classes/user.class.dart';
import 'package:last_national_bank/config/routes/router.dart';
import 'package:last_national_bank/core/select_payment/widgets/paymentButton.dart';
import 'package:last_national_bank/utils/helpers/icons.dart';
import 'package:last_national_bank/utils/helpers/style.dart';
import 'package:last_national_bank/utils/services/local_db.dart';
import 'package:last_national_bank/utils/services/online_db.dart';
import 'package:last_national_bank/widgets/navigation.dart';

class SelectPaymentPage extends StatefulWidget {
  @override
  _SelectPaymentPageState createState() => _SelectPaymentPageState();
}

class _SelectPaymentPageState extends State<SelectPaymentPage> {
  User? user;

  @override
  void initState() {
    super.initState();

    LocalDatabaseHelper.instance.getUserAndAddress().then((userDB) {
      getAccountDetails(userDB!.idNumber).then((account) {
        setState(
          () {
            user = userDB;
          },
        );
      });
    });
  }

  // Use loading page instead of red error screen
  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return _buildLoadingScreen();
    } else {
      return buildPage(context);
    }
  }

  Widget buildPage(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // Used for navigation bar:
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      // Set navigation:
      key: _scaffoldKey,
      drawer: Navigation(
          clientName: user!.firstName, clientSurname: user!.lastName),

      body: Container(
        // Decorate background
        decoration: BoxDecoration(
          gradient: backgroundGradient,
        ),

        // Column: Three lines icon, Heading, Two buttons
        child: Column(children: [
          // Open navigation icon (three lines icon)
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

          // Headingpaint
          Text(
            'Select Form of Payment',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),

          // Spacing
          Padding(
            padding: EdgeInsets.only(top: 20),
          ),

          // First button
          Container(
            width: size.width * 0.9,
            child: Column(
              children: [
                paymentButton(
                  // Pass parameters:

                  // When buton is clicked, do..
                  onTap: () {
                    //goToAdminVerificationList(context);
                  },
                  buttonTitle: "Transfers",
                  buttonDescription:
                      "Transfer funds betweeen your own accounts.",
                  buttonIcon: iconFamily.payment,
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
                    //goToAdminVerificationList(context);
                  },
                  buttonTitle: "Payments",
                  buttonDescription:
                      "Make payments to other client's bank accounts.",
                  buttonIcon: iconFamily.user,
                ),
              ],
            ),
          ),
        ]),
      ),
    );
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

// coverage:ignore-end
