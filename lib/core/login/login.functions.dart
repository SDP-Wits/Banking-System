// coverage:ignore-start
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:last_national_bank/core/login/login.helpers.dart';
import 'package:last_national_bank/utils/helpers/ignore_helper.dart';

import '../../classes/currID.dart';
import '../../config/routes/router.dart';
import '../../constants/database_constants.dart';
import '../../utils/services/online_db.dart';
import '../../utils/helpers/SHA-256_encryption.dart';

/*
TextEditingControllers to keep track of the text in the UI
*/

//Text for inputs
String idText = "";
String passwordText = "";

final TextEditingController idController = TextEditingController(text: idText);
final TextEditingController passwordController =
    TextEditingController(text: passwordText);

TextEditingController getIDController() {
  return idController;
}

TextEditingController getPasswordController() {
  return passwordController;
}

// Clear InputFields
void emptyTextLogin() {
  idText = "";
  passwordText = "";
  idController.text = "";
  passwordController.text = "";
}

/*
Show a pop up box asking whether the user wants
to login with their admin or client account
*/
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
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                isClientLogin = false;
                Navigator.pop(context);
              },
            ),
            TextButton(
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

  //If Invalid ID Number, show error msg
  if (hasInputErrorID(id)) {
    Fluttertoast.showToast(msg: "Invalid ID Number");
    return;
  }

  //If Invalid password, show error msg
  if (hasInputErrorsPassword(passwordController.text)) {
    Fluttertoast.showToast(msg: "Invalid Password");
  }

  //Encrypt password
  String password = encode(passwordController.text);

  //Try to send login details to database
  String response = await userLoginOnline(id, password, isClientLogin);
  Fluttertoast.showToast(msg: response);

  

  if (response == dbSuccess) {
    currID.id = idController.text;
    if (!isClientLogin) {
      //If Admin, go to admin verification list
      goToAdminVerificationList(context);
    } else {
      //If client, go to profile page
      goToProfilePage(context);
    }
  }

  
}

// coverage:ignore-end
