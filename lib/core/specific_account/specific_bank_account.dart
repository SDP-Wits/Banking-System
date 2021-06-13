// coverage:ignore-start
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:last_national_bank/classes/accountDetails.dart';
import 'package:last_national_bank/classes/specificAccount.dart';
import 'package:last_national_bank/classes/user.class.dart';
import 'package:last_national_bank/config/routes/router.dart';
import 'package:last_national_bank/constants/app_constants.dart';
import 'package:last_national_bank/core/account/widgets/card_info.dart';
import 'package:last_national_bank/utils/helpers/style.dart';
import 'package:last_national_bank/utils/services/local_db.dart';
import 'package:last_national_bank/utils/services/online_db.dart';
import 'package:last_national_bank/widgets/navigation.dart';

class SpecificAccountPage extends StatefulWidget {
  accountDetails acc;

  //SpecificAccountPage ({ required Key key, required this.acc}): super(key: key);
  SpecificAccountPage({required this.acc});

  @override
  _SpecificAccountPageState createState() => _SpecificAccountPageState();
}

class _SpecificAccountPageState extends State<SpecificAccountPage>
    with TickerProviderStateMixin {
  User? user;
  List<specificAccount>? logs = null;

  //Variables for transaction history pull up
  double radiusSize = 30.0;
  bool swipedUp = false;

  //Animation controllers and animation for drawer going up and down
  AnimationController? animationController;
  Animation? yOffsetAnimation;

  @override
  void initState() {
    super.initState();

    BackButtonInterceptor.add(myInterceptor);

    //Intialization of animation controller and animation
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    animationController!.addListener(() {
      setState(() {});
    });

    //Gets transaction history log
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
    //Dispose of animationController from RAM once done with it
    animationController!.dispose();
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    goToAdminVerificationStatus(context);
    return true;
  }

  // Use loading page instead of red error screen
  @override
  Widget build(BuildContext context) {
    if (user == null || logs == null) {
      return buildLoadingScreen();
    } else {
      return buildPage(context);
    }
  }

  Widget buildPage(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    //Setting the transaction history list animation variable
    yOffsetAnimation = Tween<double>(begin: size.height * 0.5, end: 0).animate(
        CurvedAnimation(
            parent: animationController!, curve: Curves.easeInCubic));

    return Scaffold(
      key: _scaffoldKey,
      drawer: Navigation(
          clientName: user!.firstName, clientSurname: user!.lastName),
      body: Container(
        decoration: BoxDecoration(
          gradient: backgroundGradient,
        ),
        child: Stack(
          children: <Widget>[
            //Detects if the user moved their finger up or down (swiped up or down)
            GestureDetector(
              onVerticalDragUpdate: (DragUpdateDetails updateDetails) {
                if (updateDetails.delta.dy < -swipeSensitivty && !swipedUp) {
                  //Bring up the transaction history
                  swipedUp = true;
                  animationController!.animateTo(size.width * 0.5);
                } else if (updateDetails.delta.dy > swipeSensitivty &&
                    swipedUp) {
                  //Bring down the transaction history
                  swipedUp = false;
                  animationController!.animateBack(0);
                }
              },
              child: Positioned(
                top: 0,
                bottom: 150,
                left: 0,
                right: 0,
                child: Container(
                  child: Column(children: [
                    // Floating back button
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
                      padding: EdgeInsets.only(top: 20),
                    ),

                    // Card
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

                    Spacer(),

                    Padding(
                      padding: EdgeInsets.only(left: 15, right: 15),

                      // Function is at the bottom
                      child: heading(),
                    ),

                    Padding(
                      padding:
                          EdgeInsets.only(bottom: size.height * 0.2, top: 15),
                      child: Icon(
                        Icons.arrow_upward,
                        color: Colors.white38,
                        size: 36.0,
                      ),
                    ),
                  ]),
                ),
              ),
            ),

            // Makes the transaction history come up when dragged up

            //This widgets allows to offset the transaction history
            //at start it will be offseted all the way to the bottom of the
            //page
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(1, 3, yOffsetAnimation!.value),
              child: DraggableScrollableSheet(
                initialChildSize: 0.2, // Size when page loads
                minChildSize: 0.2, // Minimum size allowed
                maxChildSize: 0.8, // Maximum size allowed

                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return Container(
                    padding: EdgeInsets.all(10.0),

                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(radiusSize),
                          topLeft: Radius.circular(radiusSize)),
                    ),

                    // The list of transactions
                    child: ListView.builder(
                        controller: scrollController,
                        itemCount: logs!.length,
                        itemBuilder: (BuildContext context, int index) {
                          //Checks whether a transaction amount is positive (accountTo) or negative (accountFrom)
                          //and adds the appropriate Rand symbol to the front of the amount
                          String amountPrefix;
                          Color textCol = Colors.black;
                          if (this.widget.acc.accountNumber ==
                              logs![index].accountTo) {
                            textCol = Colors.green[800]!;
                            amountPrefix = "R ";
                          } else {
                            textCol = Colors.red[500]!;
                            amountPrefix = "- R ";
                          }
                          // If there are no transactions, then display message in place
                          if (logs!.length == 0) {
                            return Column(
                              children: [
                                ListTile(
                                  title: Text("No Recent Activity",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white)),
                                ),
                              ],
                            );
                          }

                          // Display transactions if there are any
                          else {
                            return Container(
                              padding: EdgeInsets.all(20),
                              margin: EdgeInsets.symmetric(vertical: 15),
                              decoration: BoxDecoration(
                                  color: Colors.teal[50],
                                  borderRadius: BorderRadius.circular(35)),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    logs![index].timeStamp.split(" ")[0],
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.blueGrey[600]!,
                                      fontFamily: fontMont,
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(top: 5)),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Ref No: ',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black,
                                              fontFamily: fontMont,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
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
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
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
                                              horizontal: 30),
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
                        }),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// heading is the title: "Account Transaction History"
// and the floting button to add a new transaction
// I created this because of the long code which is used twice
class heading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Account Transaction History',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontFamily: fontMont,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(20),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Title
            Text(
              'Add New Transaction:',
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
        )
      ],
    );
  }
}

// coverage:ignore-end
