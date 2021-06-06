// coverage:ignore-start
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:last_national_bank/utils/services/online_db.dart';

//Text for inputs
String accountToText = "";
String accountFromText = "";
String amountText = "";
String referenceNameText = "";

//Controllers for input fields
final TextEditingController accountToController =
TextEditingController(text: accountToText);

final TextEditingController accountFromController =
TextEditingController(text: accountFromText);

final TextEditingController amountController =
TextEditingController(text: amountText);

final TextEditingController referenceNameController =
TextEditingController(text: referenceNameText);

//onChange for Controllers
void onChangeAccountTo(String newAccountTo) {
  accountToText = newAccountTo;
}

void onChangeAccountFrom(String newAccountFrom) {
  accountFromText = newAccountFrom;
}

void onChangeAmount(String newAmount) {
  amountText = newAmount;
}

void onChangeReferenceName(String newReferenceName) {
  referenceNameText = newReferenceName;
}

//Other functions
void submitTransfer(String accountFrom, String accountTo){
  //validation checks
  int amount;

  //check if input amount is correct
  try {
    amount = int.parse(amountText);
  } catch (e) {
    Fluttertoast.showToast(msg: "Please Enter Valid Amount");
    return;
  }

  //check if account number is valid
  if (accountTo.length != 11 || accountFrom.length != 11) {
    Fluttertoast.showToast(msg: "Please Enter Valid Account Number/s");
    return;
  }

  //http request to make transfer when send button is pressed
  makeTransfer(accountFrom, accountTo, amountText, referenceNameText);

  Fluttertoast.showToast(msg: "Transfer Successful");

}
// coverage:ignore-end