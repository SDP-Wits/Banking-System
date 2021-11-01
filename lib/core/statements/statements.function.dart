// coverage:ignore-start
import 'dart:io';

import 'package:last_national_bank/classes/accountDetails.dart';
import 'package:last_national_bank/classes/accountTypes.dart';
import 'package:last_national_bank/classes/specificAccount.dart';
import 'package:last_national_bank/core/statements/statement.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:universal_html/html.dart';

void generatePDF(List<specificAccount> transactions, accountDetails currAccount,
    double currPassedBalance) async {
  print(
      "currAmount: $currPassedBalance, for month: ${transactions[0].timeStamp}");

  final pdfFile = await Statement.generateStatement(transactions, currAccount);
  Statement.openFile(pdfFile);

  // Fluttertoast.showToast(msg: "Got here successfully. Let's go");
}

String getMonthFromDate(DateTime date) {
  switch (date.month) {
    case 1:
      return "January";
    case 2:
      return "February";
    case 3:
      return "March";
    case 4:
      return "April";
    case 5:
      return "May";
    case 6:
      return "June";
    case 7:
      return "July";
    case 8:
      return "August";
    case 9:
      return "September";
    case 10:
      return "October";
    case 11:
      return "November";
    case 12:
      return "Decemeber";
    default:
      return "Invalid Month";
  }
}

int getMonthIndex(String month) {
  switch (month.trim()) {
    case "January":
      return 1;
    case "February":
      return 2;
    case "March":
      return 3;
    case "April":
      return 4;
    case "May":
      return 5;
    case "June":
      return 6;
    case "July":
      return 7;
    case "August":
      return 8;
    case "September":
      return 9;
    case "October":
      return 10;
    case "November":
      return 11;
    case "Decemeber":
      return 12;
    default:
      return -1;
  }
}
// coverage:ignore-end