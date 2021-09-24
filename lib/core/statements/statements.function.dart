import 'package:last_national_bank/classes/accountTypes.dart';
import 'package:last_national_bank/classes/specificAccount.dart';

void generatePDF(List<specificAccount> transactions) {}

String getMonthFromDate(int month) {
  switch (month) {
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
