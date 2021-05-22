import 'package:flutter/material.dart';
import 'package:last_national_bank/classes/accountDetails.dart';
import 'package:last_national_bank/classes/log.dart';
import 'package:last_national_bank/classes/specificAccount.dart';
import 'package:last_national_bank/classes/user.class.dart';
import 'package:last_national_bank/config/routes/router.dart';
import 'package:last_national_bank/constants/app_constants.dart';
import 'package:last_national_bank/core/account/widgets/card_info.dart';
import 'package:last_national_bank/core/select_payment/widgets/paymentButton.dart';
import 'package:last_national_bank/utils/helpers/helper.dart';
import 'package:last_national_bank/utils/helpers/icons.dart';
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
        });
      });
    });
  }

  @override
  void dispose() {
    //Dispose of animationController from RAM once done with it
    animationController!.dispose();
    super.dispose();
  }

  // Use loading page instead of red error screen
  @override
  Widget build(BuildContext context) {
    if (user == null || logs == null) {
      return _buildLoadingScreen();
    } else {
      return buildPage(context);
    }
  }

  Widget buildPage(BuildContext context) {
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

          child: Positioned(
            top: 0,
            bottom: 150,
            left: 0,
            right: 0,
            child: Container(
              child: Column(children: [
                
                // Floating back button
                Align(
                  alignment: Alignment(-0.95, -0.8),

                  child: Container(
                    width: 50,
                    height: 50,
                    
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      
                      child: FloatingActionButton(                      
                        backgroundColor: Colors.white,
                        
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                          size: 20,
                        ),
                        
                        onPressed: () {
                          //When floating action button is pressed
                          //this will go to 'accounts' page
                          goToViewAccount(context);
                        }
                      ),
                    ),
                  ),
                ),

                // Spacing
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
                  padding: EdgeInsets.only(bottom: size.height * 0.2, top: 15),
                  
                  child: Icon(
                    Icons.arrow_upward,
                    color: Colors.teal,
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
            initialChildSize: 0.62, // Size when page loads
            minChildSize: 0.5, // Minimum size allowed
            maxChildSize: 0.99, // Maximum size allowed

            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                padding: EdgeInsets.all(10.0),

                decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(radiusSize),
                        topLeft: Radius.circular(radiusSize))),

                // The list of transactions
                child: ListView.builder(
                    controller: scrollController,
                    itemCount: (logs!.length == 0) ? 1 : logs!.length,
                    itemBuilder: (BuildContext context, int index) {
                      // If there are no transactions, then display message in place
                      if (logs!.length == 0) {
                        return Column(
                          children: [

                            // Function is at the bottom
                            heading(),     

                            ListTile(
                              title: Text(
                                "No Recent Activity",
                                style: TextStyle(fontSize: 15, color: Colors.white)
                              ),
                            ),

                          ],
                        );
                      }

                      // Display transactions if there are any
                      else {
                        return Column(
                          children: [

                            // Function is at the bottom
                            heading(),

                            // Tile with all information of transaction
                            ListTile(
                              // LisTiles usually only have two lines but make isThreeLine true to add more
                              isThreeLine: true,

                              title: Align(
                                alignment: Alignment.centerLeft,

                                // Date
                                child: Text(
                                    logs![index].timeStamp.split(" ")[0],
                                    style: TextStyle(fontSize: 20, color: Colors.white)
                                ),
                              ),

                              // isThree lines requires all other lines to be in a column
                              subtitle: Column(
                                children: [
                                  
                                  // Reference number
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    
                                    child: Text(
                                      'Reference Number: ' + logs![index].referenceNumber,
                                      style: TextStyle(fontSize: 15, color: Colors.black)
                                    ),
                                  ),
                                  
                                  // Amount
                                  Align(
                                    alignment: Alignment.bottomRight,
                                      
                                    child: Text(
                                      'R' + logs![index].amount.toString(),
                                      style: TextStyle(fontSize: 15, color: Colors.black)
                                    ),
                                  ),   

                                  // Create black dividing line
                                  const Divider(
                                    color: Colors.black26,
                                    height: 0,
                                    thickness: 1,
                                    indent: 0,
                                    endIndent: 0,
                                  ),                             

                                ],
                              ),

                            ),
                          ],
                        );
                      }


                    }),
              );
            },
          ),
        ),
      ],
    );
  }
}

// heading is the title: "Account Transaction History" 
// and the floting button to add a new transaction
// I created this because of the long code which is used twice
class heading extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      
      children: [

        // Title
        Text(
          'Account Transaction History',
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
            
            backgroundColor: Colors.white,
            
            child: Text(
              '+',
              style: TextStyle(
                color: Colors.teal,
                fontSize: 20,
                fontFamily: fontMont,
              ),
            ),
            
            onPressed: () {
              //When floating action button is pressed
              //this will go to 'select payment method' page
              goToSelectPayment(context);
            }
          ),
        ),
      ],
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
