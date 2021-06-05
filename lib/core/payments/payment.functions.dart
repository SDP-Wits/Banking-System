// coverage:ignore-start
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:last_national_bank/classes/accountDetails.dart';
import 'package:last_national_bank/classes/user.class.dart';
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

void submitPayment(User? user, accountDetails accountDetail) async {
  if (user == null) {
    Fluttertoast.showToast(msg: "Please Login Again");
    return;
  }

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
  String fullName = user.firstName + ' ';

  if (user.middleName != null) {
    fullName += user.middleName! + ' ';
  }

  fullName += user.lastName;

  final String successString = await makePayment(
      accountDetail.accountNumber,
      receipentAccountNumberText,
      amount.toString(),
      referenceNameText,
      user.userID.toString(),
      fullName);

  Fluttertoast.showToast(msg: successString);

  return;
}
// coverage:ignore-end
