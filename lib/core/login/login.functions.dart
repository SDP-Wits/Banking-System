// coverage:ignore-start
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../classes/currID.dart';
import '../../config/routes/router.dart';
import '../../constants/database_constants.dart';
import '../../utils/services/online_db.dart';
import '../SHA-256_encryption.dart';

final TextEditingController idController =
    TextEditingController(text: ""); //coverage:ignore-line
final TextEditingController passwordController =
    TextEditingController(text: ""); //coverage:ignore-line

TextEditingController getIDController() {
  return idController;
} //coverage:ignore-line

TextEditingController getPasswordController() {
  return passwordController;
} //coverage:ignore-line

Future<void> loginProcedure(BuildContext context) async {
  //coverage:ignore-line
  bool isClientLogin = true;
  await showDialog(
      //coverage:ignore-line
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          //coverage:ignore-line
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
            //coverage:ignore-line
            FlatButton(
              //coverage:ignore-line
              child: Text('Yes'),
              onPressed: () {
                isClientLogin = false;
                Navigator.pop(context);
              },
            ),
            FlatButton(
              //coverage:ignore-line
              child: Text('No'),
              onPressed: () {
                //coverage:ignore-line
                isClientLogin = true;
                Navigator.pop(context); //coverage:ignore-line
              },
            ),
          ],
        );
      }); //coverage:ignore-line

  String id = idController.text;
  String password = encode(passwordController.text);

  String response =
      await userLoginOnline(id, password, isClientLogin); //coverage:ignore-line
  Fluttertoast.showToast(msg: response); //coverage:ignore-line

  if (response == dbSuccess) {// coverage:ignore-end
    currID.id = idController.text;
    if (!isClientLogin) {
      //coverage:ignore-line
      goToAdminVerificationList(context); //coverage:ignore-line
    } else {
      goToAdminVerificationStatus(context); //coverage:ignore-line
    }
  } //coverage:ignore-line
} //coverage:ignore-line

// coverage:ignore-end

