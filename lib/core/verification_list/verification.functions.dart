import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:last_national_bank/utils/services/online_db.dart';
import 'package:last_national_bank/utils/services/local_db.dart';
import '../../classes/user.class.dart';
import '../../config/routes/router.dart';

Future<void> verifyClientProcedure(BuildContext context, String clientIDNum) async {

  User? user;

  LocalDatabaseHelper.instance.getUserAndAddress().then((currUser) {
    user = currUser;

    if (user == null){

      Fluttertoast.showToast(
        msg: "Unsuccessful",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.teal,
        textColor: Colors.white,
        fontSize: 16.0
      );

      return;

    }
    else{

      String userIDNum = user!.idNumber;
      verifyClient(clientIDNum, userIDNum);

      Fluttertoast.showToast(
          msg: "Successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.teal,
          textColor: Colors.white,
          fontSize: 16.0
      );

      goToAdminVerificationList(context);
    }
  });

}

Future<void> rejectClientProcedure(BuildContext context) async {}