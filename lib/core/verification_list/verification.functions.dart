import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../classes/user.class.dart';
import '../../config/routes/router.dart';
import '../../utils/services/local_db.dart';
import '../../utils/services/online_db.dart';

// When the Accept Client Button is clicked, add client to Verified-Clients
// table and change status to Verified

// When the Reject Client Button is clicked,  change status to Rejected

Future<void> verificationProcedure(
    BuildContext context, String clientIDNum, bool accepted) async {
  User? user;

  // Using getUserAndAddress() from Local DB to get current admin user's idNumber
  LocalDatabaseHelper.instance.getUserAndAddress().then((currUser) {
    user = currUser;

    if (user == null) {
      // Database error

      // Create 'Showmessage'
      Fluttertoast.showToast(
          msg: "Unsuccessful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.teal,
          textColor: Colors.white,
          fontSize: 16.0);

      return;
    } else {
      // Admin found in DB

      String userIDNum = user!.idNumber;

      if (accepted) {
        // Accepted button clicked
        verifyClient(
            clientIDNum, userIDNum, '1'); // 1 represents client is accepted
      } else {
        // Rejected button clicked
        verifyClient(
            clientIDNum, userIDNum, '0'); // 0 represents client is rejected
      }

      // Create 'Showmessage'
      Fluttertoast.showToast(
          msg: "Successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.teal,
          textColor: Colors.white,
          fontSize: 16.0);
    }

    goToAdminVerificationList(context);
  });
}
