// coverage:ignore-start
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../config/routes/router.dart' as router;
import '../services/local_db.dart';

//Print and toast at once :)
void toastyPrint(String string) {
  //coverage:ignore-line
  Fluttertoast.showToast(msg: string); //coverage:ignore-line
  print(string);
} //coverage:ignore-line

//Checks if the user is already logged in (if they in local DB)
void autoLogin(BuildContext context) {
  //If web
  if (kIsWeb) {
    return;
  }

  LocalDatabaseHelper.instance.isUser().then((isUser) {
    //coverage:ignore-line
    if (isUser) {
      LocalDatabaseHelper.instance.getUserAndAddress().then((user) {
        //coverage:ignore-line
        if (user!.isAdmin) {
          router.goToAdminVerificationList(context); //coverage:ignore-line
        } else {
          router.goToProfilePage(context); //coverage:ignore-line
        }
      }); //coverage:ignore-line
    }
  }); //coverage:ignore-line
} //coverage:ignore-line

//Gets the current date in the format, YYYY-MM-DD
String getDate() {
  DateTime now = new DateTime.now();
  DateTime date = new DateTime(now.year, now.month, now.day);

  return date.toString().split(' ')[0];
} //coverage:ignore-line


// coverage:ignore-end
