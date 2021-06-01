import 'package:flutter/material.dart';
import 'package:last_national_bank/core/payments/payment.functions.dart';
import 'package:last_national_bank/utils/helpers/style.dart';
import 'package:last_national_bank/widgets/heading.dart';

class Payments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        height: size.height,
        decoration: BoxDecoration(
          gradient: backgroundGradient,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Heading("Payments"),
            InputField(
              text: "Amount",
              child: TextField(
                maxLines: 1,
                decoration: inputInputDecoration,
                controller: amountController,
                onChanged: onChangeAmount,
                textAlign: TextAlign.center,
                style: inputTextStyle,
              ),
            ),
            InputField(
              text: "Recipient Account Number",
              child: TextField(
                maxLength: 11,
                decoration: inputInputDecoration,
                controller: receiptentAccountNumberController,
                onChanged: onChangeReceipent,
                textAlign: TextAlign.center,
                style: inputTextStyle,
              ),
            ),
            InputField(
              text: "Reference Name",
              child: TextField(
                // maxLength: 11,
                decoration: inputInputDecoration,
                controller: referenceNameController,
                onChanged: onChangeReferenceName,
                textAlign: TextAlign.center,
                style: inputTextStyle,
              ),
            ),
            TextButton(
              onPressed: submitPayment,
              child: Container(
                width: size.width * 0.5,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54,
                        blurRadius:
                            10.0, // has the effect of softening the shadow
                        spreadRadius:
                            1.0, // has the effect of extending the shadow
                        offset: Offset(
                          5.0, // horizontal, move right 10
                          5.0, // vertical, move down 10
                        ),
                      ),
                    ]),
                child: Text(
                  "Send",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.teal,
                    fontSize: 18.0,
                    fontFamily: fontMont,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InputField extends StatelessWidget {
  final String text;
  final Widget child;

  InputField({required this.text, required this.child});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: size.width * 0.9,
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.only(
              topLeft: borderRadius,
              topRight: borderRadius,
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontFamily: fontMont,
              fontSize: 15.0,
            ),
          ),
        ),
        Container(
          width: size.width * 0.9,
          margin: EdgeInsets.only(bottom: 15.0),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.white24,
                offset: Offset(4.0, 2.0), //(x,y)
                blurRadius: 6.0,
              ),
              BoxShadow(
                color: Colors.white24,
                offset: Offset(-4.0, 2.0), //(x,y)
                blurRadius: 6.0,
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: borderRadius,
              bottomRight: borderRadius,
              // topRight: borderRadius,
            ),
          ),
          child: Container(width: (size.width * 0.9), child: child),
        ),
      ],
    );
  }
}

var inputTextStyle = TextStyle(
  color: Colors.black,
  fontFamily: fontMont,
  fontSize: 16.0,
);

var inputInputDecoration = InputDecoration(
  enabledBorder: InputBorder.none,
  focusedBorder: InputBorder.none,
);

const borderRadius = Radius.circular(15.0);
