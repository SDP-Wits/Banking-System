import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:last_national_bank/utils/helpers/helper.dart';
import 'package:last_national_bank/utils/helpers/style.dart';

class AccountCardInfo extends StatefulWidget {
  final String accountType;
  final String accountNumber;
  final String firstName;
  final String middleNames;
  final String lastName;
  final String cardType;

  final double currAmount;

  AccountCardInfo(
      {required this.accountType,
      required this.accountNumber,
      required this.firstName,
      required this.middleNames,
      required this.lastName,
      required this.cardType,
      required this.currAmount});

  @override
  _AccountCardInfoState createState() => _AccountCardInfoState();
}

class _AccountCardInfoState extends State<AccountCardInfo> {
  bool isFront = true;
  double angle = 0.0;

  void _flip() {
    setState(() {
      angle = (angle + pi) % (2 * pi);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _flip,
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: angle),
        duration: Duration(milliseconds: 750),
        builder: (BuildContext context, double angleVal, __) {
          if (angleVal >= (pi / 2)) {
            isFront = false;
          } else {
            isFront = true;
          }

          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(angleVal),
            child: Container(
              child: (isFront)
                  ? _FrontCard(
                      accountType: this.widget.accountType,
                      seperatedCardNumber:
                          seperateCardNumber(this.widget.accountNumber),
                      nameDisplay: getNameDisplay(this.widget.firstName,
                          this.widget.middleNames, this.widget.lastName),
                      cardType: this.widget.cardType,
                    )
                  : Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()..rotateY(-angleVal),
                      child: _BackCard(
                          accountType: this.widget.accountType,
                          currAmount: this.widget.currAmount.toString(),
                          nameDisplay: getNameDisplay(this.widget.firstName,
                              this.widget.middleNames, this.widget.lastName),
                          cardType: this.widget.cardType),
                    ),
            ),
          );
        },
      ),
    );
  }
}

class _FrontCard extends StatelessWidget {
  final String accountType;
  final String seperatedCardNumber;
  final String nameDisplay;
  final String? cardType;

  _FrontCard({
    required this.accountType,
    required this.seperatedCardNumber,
    required this.nameDisplay,
    this.cardType,
  });

  @override
  Widget build(BuildContext context) {
    return _CardLayout(children: [
      //Heading
      Text(
        accountType,
        style: TextStyle(
          color: Colors.teal,
          fontSize: fontSizeLarge,
          fontFamily: fontMont,
          // fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
        ),
      ),
      //Names

      Text(
        seperatedCardNumber,
        style: TextStyle(
          color: Colors.teal,
          fontSize: fontSizeSmall,
          fontFamily: fontMont,
        ),
      ),

      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            nameDisplay,
            style: TextStyle(
              color: Colors.teal,
              fontSize: fontSizeMedium,
              fontFamily: fontMont,
            ),
          ),
          (cardType != null)
              ? Text(
                  "VISA",
                  style: TextStyle(
                    color: Colors.teal,
                    fontSize: 48,
                    fontFamily: "arial",
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : Container(),
        ],
      ),
    ]);
  }
}

class _BackCard extends StatelessWidget {
  final String accountType;
  final String currAmount;
  final String nameDisplay;
  final String cardType;

  _BackCard({
    required this.accountType,
    required this.currAmount,
    required this.nameDisplay,
    required this.cardType,
  });

  @override
  Widget build(BuildContext context) {
    return _CardLayout(children: [
      //Heading
      Text(
        accountType,
        style: TextStyle(
          color: Colors.teal,
          fontSize: fontSizeLarge,
          fontFamily: fontMont,
          // fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
        ),
      ),
//Names

      Text(
        "R$currAmount",
        style: TextStyle(
          color: Colors.teal,
          fontSize: fontSizeSmall,
          fontFamily: fontMont,
        ),
      ),

      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            nameDisplay,
            style: TextStyle(
              color: Colors.teal,
              fontSize: fontSizeMedium,
              fontFamily: fontMont,
            ),
          ),
          Text(
            cardType,
            style: TextStyle(
              color: Colors.teal,
              fontSize: 48,
              fontFamily: "arial",
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ]);
  }
}

class _CardLayout extends StatelessWidget {
  final List<Widget> children;
  _CardLayout({required this.children});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Material(
      elevation: 15.0,
      borderOnForeground: false,
      borderRadius: BorderRadius.circular(15.0),
      child: Container(
        width: size.width * 0.9,
        height: size.height * 0.3,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.blueGrey[100]!,
              Colors.blueGrey[50]!,
              Colors.blueGrey[100]!
            ],
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: this.children,
        ),
      ),
    );
  }
}
