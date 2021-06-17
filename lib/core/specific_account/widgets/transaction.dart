// coverage:ignore-start
import 'package:flutter/material.dart';
import 'package:last_national_bank/classes/specificAccount.dart';
import 'package:last_national_bank/utils/helpers/style.dart';

class Transaction extends StatelessWidget {
  
  String timeStamp;
  String amount;
  String refName;
  int index;
  String amountPrefix;
  Color textCol;
  String title1;
  String info1;

  Transaction({required this.timeStamp, required this.amount, required this.refName, 
                required this.index, required this.amountPrefix, required this.textCol,
                required this.title1, required this.info1});

  @override
  Widget build(BuildContext context) {
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
                                Text(
                                  timeStamp,
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
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          title1,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontFamily: fontMont,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10),

                                      child: Text(
                                          info1,
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black,
                                              fontFamily: fontMont
                                            ),
                                            
                                        ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      amountPrefix +
                                          amount,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      padding: EdgeInsets.symmetric(horizontal: 30),

                                      child: Text(
                                            refName,
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.black,
                                                fontFamily: fontMont
                                              ), 
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
}
// coverage:ignore-end