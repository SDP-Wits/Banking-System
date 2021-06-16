// coverage:ignore-start
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
import 'package:last_national_bank/utils/helpers/style.dart';
import 'package:last_national_bank/utils/services/local_db.dart';
import 'package:last_national_bank/utils/services/online_db.dart';
import 'package:last_national_bank/widgets/navigation.dart';

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

class SpecificAccountPage extends StatefulWidget {

  // Account details for specific account is retrieved from the previous UI (Accounts)
  accountDetails acc;
  SpecificAccountPage({required this.acc});

  @override
  _SpecificAccountPageState createState() => _SpecificAccountPageState();
}

class _SpecificAccountPageState extends State<SpecificAccountPage> with TickerProviderStateMixin {

  // User details
  User? user;

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

    // For the system back button 
    BackButtonInterceptor.add(myInterceptor);

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
        stopDefaultButtonEvent: stopDefaultButtonEvent
    );
  }

  // Use loading page instead of red error screen
  @override
  Widget build(BuildContext context) {

    // While data is being loaded, display loading screen
    if (user == null || logs == null) {

      return buildLoadingScreen(context);
    } 
    else {

      return Scaffold(
        
        // Set navigation drawer
        key: _scaffoldKey,
        drawer: Navigation(
          clientName: user!.firstName, 
          clientSurname: user!.lastName
        ),

        // buildPage
        body: Container(
          decoration: BoxDecoration(
            gradient: backgroundGradient,
          ),
          child: buildPage(context),
        )
      );
    }
  }

  Widget buildPage(BuildContext context) {

    final Size size = MediaQuery.of(context).size;

    //Setting the transaction history list animation variable
    yOffsetAnimation = Tween<double>(begin: size.height * 0.5, end: 0).animate(
      CurvedAnimation(
        parent: animationController!, 
        curve: Curves.easeInCubic
      )
    );

    return Stack(
      children: <Widget>[

        //Detects if the user moved their finger up or down (swiped up or down)
        GestureDetector(
          onVerticalDragUpdate: (DragUpdateDetails updateDetails) {

            if (updateDetails.delta.dy < -swipeSensitivty && !swipedUp) {
              //Bring up the transaction history
              swipedUp = true;
              animationController!.animateTo(size.width * 0.5);
            } 
            else if (updateDetails.delta.dy > swipeSensitivty && swipedUp) {
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
            child: Column(
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

                // Spacing
                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),

                // Card widget that displays the user's specific account details
                Align(
                  alignment: Alignment.topCenter,
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
                Padding(
                  padding: EdgeInsets.only(bottom: 5, top: size.height * 0.2),
                  child: Icon(
                    Icons.arrow_upward,
                    color: Colors.teal,
                    size: 36.0,
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
              return Container(
                padding: EdgeInsets.all(10.0),

                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(radiusSize),
                      topLeft: Radius.circular(radiusSize)),
                ),

                // The list of transactions
                child: (logs!.length == 0)
                    ? // If there are no transactions, then display message in place
                    Column(
                        children: [
                          ListTile(
                            title: Text("No Recent Activity",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white)),
                          ),
                        ],
                      )

                    : // If there are transactions, then display them
                    ListView.builder(
                        controller: scrollController,
                        itemCount: logs!.length,
                        itemBuilder: (BuildContext context, int index) {

                          // Checks whether a transaction amount is positive (accountTo) or negative (accountFrom)
                          // and adds the appropriate Rand symbol to the front of the amount
                          String amountPrefix = '';
                          Color textCol = Colors.black;
                          if (logs!.length > 0){
                            if (this.widget.acc.accountNumber ==
                                logs![index].accountTo) {
                              textCol = Colors.green[800]!;
                              amountPrefix = "+ R ";
                            } else {
                              textCol = Colors.red[500]!;
                              amountPrefix = "- R ";
                            }
                          }

                          // Display transaction
                          return Container(
                            padding: EdgeInsets.all(20),
                            margin: EdgeInsets.symmetric(vertical: 15),

                            decoration: BoxDecoration(
                                color: Colors.teal[100],
                                borderRadius: BorderRadius.circular(35)
                            ),

                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              
                              children: [
                                
                                // Date of transaction
                                Text(
                                  logs![index].timeStamp.split(" ")[0],
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blueGrey[600]!,
                                    fontFamily: fontMont,
                                  ),
                                ),

                                // Spacing
                                Padding(padding: EdgeInsets.only(top: 5)),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,                                  
                                  children: [
                                    
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        
                                        // Title
                                        Text(
                                          'Ref No: ',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontFamily: fontMont,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        // Spacing
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10
                                          ),

                                          // Reference number
                                          child: Text(
                                            logs![index].referenceNumber,
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.black,
                                                fontFamily: fontMont),
                                          ),
                                        ),

                                      ],
                                    ),

                                    // Transaction amount
                                    Text(
                                      amountPrefix +
                                          logs![index].amount.toString(),
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: textCol,
                                          fontFamily: fontMont),
                                    ),

                                  ],
                                ),

                                // Spacing
                                Padding(
                                  padding: EdgeInsets.all(10),
                                ),


                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  
                                  children: [
                                    
                                    // Title
                                    Text(
                                      'Ref: ',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontFamily: fontMont,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30
                                        ),

                                        // Reference name
                                        child: Text(
                                          logs![index].referenceName,
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black,
                                              fontFamily: fontMont),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 5,
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ],
                            ),
                          );
                        }
                    ),
              );
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

    return Row(
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
    );
  }
}

// coverage:ignore-end
