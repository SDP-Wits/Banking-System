import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:last_national_bank/constants/database_constants.dart';
import '../../config/routes/router.dart';
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
  bool isAdmin = false;
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
                isAdmin = true;
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text('No'),
              onPressed: () {
                isAdmin = false;
                Navigator.pop(context);
              },
            ),
          ],
        );
      });

  String id = idController.text;
  String password = encode(passwordController.text);

  if (isAdmin) {
    //String encodedPassword = encode(password);
    String response = await userLoginOnline(id, password, !isAdmin);
    Fluttertoast.showToast(msg: response);

    if (response == dbSuccess) {
      //Transfer admin to verification list page
      goToAdminVerificationList(context);
    }
  } else {
    //String encodedPassword = encode(password);
    String response = await userLoginOnline(id, password, !isAdmin);
    Fluttertoast.showToast(msg: response);

    if (response == dbSuccess) {
      //Transfer user to next page
      goToAdminVerificationStatus(context);
    }
  }
}

String hash(String string) {
  return string;
}

//Helper Functions
//
bool hasInputErrorsPassword(String password) {
  if (password.length < 8 || password.length > 20) {
    //check if password length is correct
    return true;
  }
  if (password.length >= 8 && password.length <= 20) {
    //check if password contains uppercase, lowercase letters, number, special characters
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return !regExp.hasMatch(password);
  }
  return false;
}

bool hasInputErrorID(String idNum) {
  if (idNum.length != 13) {
    //checks if id num is of length 13
    return true;
  }
  bool hasLetters =
      double.tryParse(idNum) != null; //checks if id number contains any letters
  return !hasLetters;
}
