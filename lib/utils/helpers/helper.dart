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
