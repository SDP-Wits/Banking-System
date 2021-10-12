// coverage:ignore-start
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:last_national_bank/classes/accountDetails.dart';
import 'package:last_national_bank/classes/user.class.dart';
import 'package:last_national_bank/constants/database_constants.dart';
import 'package:last_national_bank/utils/services/online_db.dart';

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

void emptyText() {
  amountText = "";
  receipentAccountNumberText = "";
  referenceNameText = "";

  amountController.text = "";
  receiptentAccountNumberController.text = "";
  referenceNameController.text = "";
}

Future<bool> submitPayment(User? user, accountDetails accountDetail) async {
  if (user == null) {
    Fluttertoast.showToast(msg: "Please Login Again");
    return false;
  }

  int amount = -1;
  try {
    amount = int.parse(amountText);
  } catch (e) {
    Fluttertoast.showToast(msg: "Please Enter Valid Amount");
    return false;
  }

  if (amount <= 0) {
    Fluttertoast.showToast(msg: "Please Enter Valid Amount");
    return false;
  }

  if (receipentAccountNumberText.length != 11) {
    Fluttertoast.showToast(msg: "Please Enter Valid Account Number");
    return false;
  }

  if (accountDetail.currentBalance < amount) {
    Fluttertoast.showToast(msg: "Insufficient funds");
    return false;
  }

  if (accountDetail.accountNumber == receipentAccountNumberText) {
    Fluttertoast.showToast(msg: "Cannot transfer to your own account");
    return false;
  }

  final int recipientClientID = await getClientID(receipentAccountNumberText);
  print(recipientClientID);
  if (recipientClientID == 0) {
    Fluttertoast.showToast(msg: "Recipient Account does not exist");
    return false;
  }

  //Http Request
  String fullName = user.firstName + ' ';

  if (user.middleName != null) {
    fullName += user.middleName! + ' ';
  }

  fullName += user.lastName;
  print(recipientClientID.toString());

  final String successString = await makePayment(
      recipientClientID.toString(),
      accountDetail.accountNumber,
      receipentAccountNumberText,
      amountText,
      referenceNameText,
      user.userID.toString(),
      fullName);

  Fluttertoast.showToast(msg: successString);

  return (successString == dbSuccess);
}
// coverage:ignore-end
