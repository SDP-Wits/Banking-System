import 'package:flutter/material.dart';
import 'package:last_national_bank/classes/accountDetails.dart';
import 'package:last_national_bank/classes/log.dart';
import 'package:last_national_bank/classes/user.class.dart';
import 'package:last_national_bank/config/routes/router.dart';
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

class _SpecificAccountPageState extends State<SpecificAccountPage> {
  User? user;
  List<Log>? logs = null;
    @override
    void initState() {
      super.initState();
      LocalDatabaseHelper.instance.getUserAndAddress().then((userDB) {
        setState(() {
          user = userDB;

        });
        getLogs(user!.userID.toString()).then((logsIn) {

          setState(() {
            logs = logsIn;
          });
        });
      }
    );
          
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
    // TODO: implement build

    return Stack(
    children: <Widget>[
      Positioned(
        top: 0,
        bottom: 150,
        left: 0,
        right: 0,
        child: Container(
          child: Column(
            children: [

              // Spacing
              Padding(
                padding: EdgeInsets.only(top: 50),
              ),
              
              // Heading
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Account Type',
                  style: new TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w500,
                      color: Colors.teal
                  ),
                ),
              ),

              // Spacing
              Padding(
                padding: EdgeInsets.only(top: 50),
              ),

              // Card
              AccountCardInfo(
                accountType: this.widget.acc.accountType,
                accountNumber: this.widget.acc.accountNumber,
                firstName: this.widget.acc.fName,
                middleNames: this.widget.acc.mName,
                lastName: this.widget.acc.lName,
                cardType: "VISA",
                currAmount: this.widget.acc.currentBalance,
                accountTypeId: this.widget.acc.accountTypeId,
              ),

            ]
          ),
        ),
      ),


      // Makes the thingy that comes up when dragged
      DraggableScrollableSheet(
                
        initialChildSize: 0.4,  // Size when page loads
        minChildSize: 0.4,      // Minimum size allowed
        maxChildSize: 0.8,      // Maximum size allowed

        builder: (BuildContext context, ScrollController scrollController){

          return Container(

            padding: EdgeInsets.all(10.0),
            color: Colors.teal,

            // The list of transactions
            child: ListView.builder(

              controller: scrollController,
              itemCount: (logs!.length ==0) ? 1 :logs!.length,

              itemBuilder: (BuildContext context, int index){

                // If there are no transactions, then display message in place
                if (logs!.length == 0){

                  return ListTile(
                    title: Text("",
                    style: TextStyle(fontSize: 15, color: Colors.white)),
                    subtitle: Text("No Recent Activity",
                    style: TextStyle(fontSize: 16)),
                                
                  );
                }

                // Display transactions if there are any
                else{

                  return ListTile(
                    title: Text(logs![index].timeStamp.split(" ")[0],
                    style: TextStyle(fontSize: 15, color: Colors.black)),
                    subtitle: Text(logs![index].logDescription,
                    style: TextStyle(fontSize: 18, color: Colors.white)),
                  );
                }

              }),
          );
        },
      )
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

