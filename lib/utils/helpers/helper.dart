import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:last_national_bank/config/routes/router.dart' as router;
import 'package:last_national_bank/utils/services/local_db.dart';

void toastyPrint(String string) {
  Fluttertoast.showToast(msg: string);
  print(string);
}

void autoLogin(BuildContext context) {
  LocalDatabaseHelper.instance.isUser().then((isUser) {
    if (isUser) {
      LocalDatabaseHelper.instance.getUserAndAddress().then((user) {
        if (user!.isAdmin) {
          router.goToAdminVerificationList(context);
        } else {
          router.goToAdminVerificationStatus(context);
        }
      });
    }
  });
}

String getDate() {
  DateTime now = new DateTime.now();
  DateTime date = new DateTime(now.year, now.month, now.day);

  return date.toString().split(' ')[0];
}

String seperateCardNumber(String cardNumber) {
  String ansString = "";

  int length = cardNumber.length;
  for (int i = 0; i < length; i++) {
    if (i % 4 == 0 && i != 0) {
      ansString += " ";
    }
    ansString += cardNumber[i];
  }

  return ansString;
}

String getNameDisplay(String firstName, String middleNames, String lastName) {
  firstName = firstName.trim();
  middleNames = middleNames.trim();
  lastName = lastName.trim();

  String ansString = firstName[0].toUpperCase() + '.';

  if (middleNames != '') {
    for (String middle in middleNames.split(' ')) {
      ansString += middle[0].toUpperCase() + '.';
    }
  }

  ansString += ' ' + lastName;

  return ansString;
}
