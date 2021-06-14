// coverage:ignore-start
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:last_national_bank/constants/database_constants.dart';
import 'package:last_national_bank/utils/services/online_db.dart';

/*
Functions used in the process to make a client transfer.
*/

//Text for inputs
String amountText = "";
String referenceNameText = "";

//Controllers for input fields
final TextEditingController amountController =
    TextEditingController(text: amountText);

final TextEditingController referenceNameController =
    TextEditingController(text: referenceNameText);

// Whenever a user changes the amount in the Input Field,
// the amountText variable is changed (always has updated value)
void onChangeAmount(String newAmount) {
  amountText = newAmount;
}

// Whenever a user changes the reference in the Input Field,
// the referenceNameText variable is changed (always has updated value)
void onChangeReferenceName(String newReferenceName) {
  referenceNameText = newReferenceName;
}

// Clear InputFields
void emptyTextTransfer() {
  amountText = "";
  referenceNameText = "";
  amountController.text = "";
  referenceNameController.text = "";
}

// When user clicks the 'Submit' button, this function is called
Future<bool> submitTransfer(double currAmt, String accountFrom, String accountTo, BuildContext context) async {

  // Validation checks
  // ===============================================================================

  //check if input amount is correct
  try {
    int.parse(amountText);
  } catch (e) {
    Fluttertoast.showToast(msg: "Please Enter Valid Transfer Amount");
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

  // ===============================================================================

  //http request to make transfer when send button is pressed
  String success =
      await makeTransfer(accountFrom, accountTo, amountText, referenceNameText);

  Fluttertoast.showToast(msg: success);
  return (success == dbSuccess);
}
// coverage:ignore-end
