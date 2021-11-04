// coverage:ignore-start
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:last_national_bank/classes/accountDetails.dart';
import 'package:last_national_bank/classes/user.class.dart';
import 'package:last_national_bank/config/routes/router.dart';
import 'package:last_national_bank/constants/route_constants.dart';
import 'package:last_national_bank/core/registration/widgets/customCircle.dart';
import 'package:last_national_bank/core/select_payment/widgets/paymentButton.dart';
import 'package:last_national_bank/utils/helpers/helper.dart';
import 'package:last_national_bank/utils/helpers/icons.dart';
import 'package:last_national_bank/utils/helpers/style.dart';
import 'package:last_national_bank/utils/services/local_db.dart';
import 'package:last_national_bank/utils/services/online_db.dart';
import 'package:last_national_bank/widgets/desktopNav.dart';
import 'package:last_national_bank/widgets/heading.dart';
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
    if (kIsWeb) {
      BackButtonInterceptor.removeAll();
    }

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
    final size = getSize(context);
    return Scaffold(
      // Set navigation:
      key: _scaffoldKey,
      drawer: Navigation(
          clientName: user!.firstName,
          clientSurname: user!.lastName,
          context: context),

      body: Container(
        // Decorate background
        decoration: BoxDecoration(
          gradient: backgroundGradient,
        ),
        height: size.height,
        width: size.width,
        // Column: Three lines icon, Heading, Two buttons
        child: SingleChildScrollView(
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
            // Heading
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: (size.width > tabletWidth)
                  ? Heading('Select Form of Payment')
                  : Heading('Select Form\n of Payment'),
            ),

            (size.width < tabletWidth)
                ? Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        // First button
                        if (accountDets.length > 1)
                          paymentButton(
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
                          buttonDescription:
                              "Make payments to other client's bank accounts.",
                          buttonIcon: iconFamily.user,
                        ),
                      ],
                    ),
                  )
                :

                //Desktop Layout
                Stack(
                    children: [
                      Positioned(
                        child: CustomCircle(
                          color: Color(0x005ca9).withAlpha(92),
                          sizeFactor: 0.8,
                        ),
                        top: size.height / 15,
                        left: size.width / 15,
                      ),
                      Positioned(
                        child: CustomCircle(
                          color: Color(0xf0af25).withAlpha(92),
                          sizeFactor: 0.8,
                        ),
                        top: size.height / 15,
                        right: size.width / 15,
                      ),
                      Container(
                        width: size.width,
                        height: size.height * 0.8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // First button
                            if (accountDets.length > 1)
                              paymentButton(
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
                              buttonDescription:
                                  "Make payments to other client's bank accounts.",
                              buttonIcon: iconFamily.user,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ]),
        ),
      ),
    );
  }
}

// coverage:ignore-end
