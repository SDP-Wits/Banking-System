import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../config/routes/router.dart' as router;
import '../services/local_db.dart';

// coverage:ignore-start


//Print and toast at once :)
void toastyPrint(String string) {
  Fluttertoast.showToast(msg: string);
  print(string);
}

//Checks if the user is already logged in (if they in local DB)
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

//Gets the current date in the format, YYYY-MM-DD
String getDate() {
  DateTime now = new DateTime.now();
  DateTime date = new DateTime(now.year, now.month, now.day);

  return date.toString().split(' ')[0];
}

// coverage:ignore-end

//Takes in a card number and adds spaces to it
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

//Takes in full name and makes initals for first and middles names
//eg. Arneev Mohan Joker Singh -> A.M.J. Singh
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
