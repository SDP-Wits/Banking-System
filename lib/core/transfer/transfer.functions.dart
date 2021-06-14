// coverage:ignore-start
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:last_national_bank/constants/database_constants.dart';
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

void emptyTextTransfer() {
  accountToText = "";
  accountFromText = "";
  amountText = "";
  referenceNameText = "";

  accountToController.text = "";
  accountFromController.text = "";
  amountController.text = "";
  referenceNameController.text = "";
}

//Other functions
Future<bool> submitTransfer(double currAmt, String accountFrom,
    String accountTo, BuildContext context) async {
  //validation checks

  //check if input amount is correct
  try {
    int.parse(amountText);
  } catch (e) {
    Fluttertoast.showToast(msg: "Please Enter Valid Amount");
    return false;
  }

  //check if account number is valid
  if (accountTo.length != 11 || accountFrom.length != 11) {
    Fluttertoast.showToast(msg: "Please Enter Valid Account Number/s");
    return false;
  }

  if (currAmt < int.parse(amountText)) {
    Fluttertoast.showToast(msg: "Insufficient funds");
    return false;
  }

  if (accountTo == accountFrom) {
    Fluttertoast.showToast(msg: "Cannot send money to the same account");
    return false;
  }

  //http request to make transfer when send button is pressed
  String success =
      await makeTransfer(accountFrom, accountTo, amountText, referenceNameText);

  Fluttertoast.showToast(msg: success);
  return (success == dbSuccess);
}
// coverage:ignore-end
