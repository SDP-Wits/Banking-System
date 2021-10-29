// coverage:ignore-start
import 'dart:io';

import 'package:last_national_bank/classes/accountTypes.dart';
import 'package:last_national_bank/classes/specificAccount.dart';
import 'package:last_national_bank/core/statements/statement.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:universal_html/html.dart';

void generatePDF(List<specificAccount> transactions) async {
  print("About to print transactions\n========================");
  int i = 0;
  transactions.forEach((element) {
    print("Iteration : " + i.toString());
    print("Time stamp : " + element.timeStamp);
    print("Reference Number : " + element.referenceNumber);
    i++;
  });
  print("End of print transactions\n========================");

  final pdfFile = await Statement.generateStatement(transactions);
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
// coverage:ignore-end