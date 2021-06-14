// coverage:ignore-start
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../classes/currID.dart';
import '../../config/routes/router.dart';
import '../../constants/database_constants.dart';
import '../../utils/services/online_db.dart';
import '../SHA-256_encryption.dart';

final TextEditingController idController = TextEditingController(text: "");
final TextEditingController passwordController =
    TextEditingController(text: "");

TextEditingController getIDController() {
  return idController;
}

TextEditingController getPasswordController() {
  return passwordController;
}

Future<void> loginProcedure(BuildContext context) async {
  bool isClientLogin = true;
  await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text("Login?"),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Text(
                  "Do you want to login in with your Admin account",
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                isClientLogin = false;
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text('No'),
              onPressed: () {
                isClientLogin = true;
                Navigator.pop(context);
              },
            ),
          ],
        );
      });

  String id = idController.text;
  String password = encode(passwordController.text);

  String response = await userLoginOnline(id, password, isClientLogin);
  Fluttertoast.showToast(msg: response);

  if (response == dbSuccess) {
    currID.id = idController.text;
    if (!isClientLogin) {
      goToAdminVerificationList(context);
    } else {
      goToAdminVerificationStatus(context);
    }
  }
}

// coverage:ignore-end
