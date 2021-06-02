import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:last_national_bank/classes/accountDetails.dart';
import 'package:last_national_bank/utils/helpers/style.dart';
//import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ScrollAccount extends StatelessWidget {

  List<accountDetails> acc = [];
  //final ItemScrollController itemScrollController = ItemScrollController();
 // final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  ScrollAccount({required this.acc});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        // Scroll up
        Container(
          width: size.width * 0.45,
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,

          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
            ),
          ),

          child: Icon(
            Icons.keyboard_arrow_up_rounded
          ),
        ),

        // Center part with account information - doesn't work
        /*Container(
          width: size.width * 0.45,
          height: size.width * 0.3,  

          decoration: BoxDecoration(
            color: Colors.white,
          ),        

          child: ListView.builder(
            
            //physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 15),
            itemCount: acc.length,
            
            itemBuilder: (BuildContext context, int index) {
              
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: __bankDetails(
                  accountType: this.acc[index].accountType, 
                  accountNumber: this.acc[index].accountNumber,  
                  amount: this.acc[index].currentBalance, 
                ),

              );
            },

           // itemScrollController: itemScrollController,
           // itemPositionsListener: itemPositionsListener,
          ),
        ),
*/

        // Scroll down
        Container(
          width: size.width * 0.45,
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,

          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15.0),
              bottomRight: Radius.circular(15.0),
            ),
          ),

          child: Icon(
            Icons.keyboard_arrow_down_rounded
          ),
        ),


      ],
    );
  }
}

class __bankDetails extends StatelessWidget {
  final String accountType;
  final String accountNumber;
  final double amount;

  __bankDetails({
    required this.accountType,
    required this.accountNumber,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      
      child: Column(
      
        children: [
          //Heading
          Text(
            accountType,
            style: TextStyle(
              color: Colors.teal,
              fontSize: 20,
              fontFamily: fontMont,
              // fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ),
          ),
          //Names

          Text(
            "Account Number: \n" + accountNumber,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontFamily: fontMont,
            ),
          ),

          Text(
            "Balance: " + "R$amount",
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontFamily: fontMont,
            ),
          ),
        ]
      ),
    );
  }
}