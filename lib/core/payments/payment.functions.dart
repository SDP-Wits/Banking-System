// coverage:ignore-start
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

//Text for inputs
String amountText = "";
String receipentAccountNumberText = "";
String referenceNameText = "";

//Contorllers for Input Field
final TextEditingController amountController =
    TextEditingController(text: amountText);

final TextEditingController receiptentAccountNumberController =
    TextEditingController(text: receipentAccountNumberText);

final TextEditingController referenceNameController =
    TextEditingController(text: referenceNameText);

//OnChange for Controllers
void onChangeAmount(String newAmount) {
  amountText = newAmount;
}

void onChangeReceipent(String newReceipent) {
  receipentAccountNumberText = newReceipent;
}

void onChangeReferenceName(String newReferenceName) {
  referenceNameText = newReferenceName;
}

void submitPayment() {
  int amount;
  try {
    amount = int.parse(amountText);
  } catch (e) {
    Fluttertoast.showToast(msg: "Please Enter Valid Amount");
    return;
  }

  if (receipentAccountNumberText.length != 11) {
    Fluttertoast.showToast(msg: "Please Enter Valid Account Number");
    return;
  }

  //Http Request
  //addPayment(amount, receipentAccountNumberText, referenceNameText)

  Fluttertoast.showToast(msg: "Success");
}
// coverage:ignore-end
