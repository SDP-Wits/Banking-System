// coverage:ignore-start
import 'package:flutter/material.dart';
import 'package:last_national_bank/classes/accountDetails.dart';
import 'package:last_national_bank/classes/specificAccount.dart';
import 'package:last_national_bank/utils/helpers/style.dart';

class listTransactions extends StatelessWidget {
  List<specificAccount>? logs;
  double radiusSize = 30.0;
  ScrollController scrollController;
  accountDetails acc;

  listTransactions(
      {required this.logs, required this.scrollController, required this.acc});

  @override
  Widget build(BuildContext context) {
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
                      style: TextStyle(fontSize: 15, color: Colors.white)),
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

                if (logs!.length > 0) {
                  if (this.acc.accountNumber == logs![index].accountTo) {
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
                      borderRadius: BorderRadius.circular(35)),
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
                                padding: EdgeInsets.symmetric(horizontal: 10),

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
                            amountPrefix + logs![index].amount.toString(),
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
                              padding: EdgeInsets.symmetric(horizontal: 30),

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
              }),
    );
  }
}
