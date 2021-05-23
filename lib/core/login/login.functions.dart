import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../classes/currID.dart';
import '../../config/routes/router.dart';
import '../../constants/database_constants.dart';
import '../../utils/services/online_db.dart';
import '../SHA-256_encryption.dart';

//coverage:ignore-start
final TextEditingController idController = //coverage:ignore-line
    TextEditingController(text: ""); //coverage:ignore-line
final TextEditingController passwordController = //coverage:ignore-line
    TextEditingController(text: ""); //coverage:ignore-line

TextEditingController getIDController() { //coverage:ignore-line
  return idController; //coverage:ignore-line
}

TextEditingController getPasswordController() {//coverage:ignore-line
  return passwordController; //coverage:ignore-line
}

Future<void> loginProcedure(BuildContext context) async {
  //coverage:ignore-line
  bool isClientLogin = true; //coverage:ignore-line
  await showDialog(
      //coverage:ignore-line
      context: context, //coverage:ignore-line
      barrierDismissible: false, //coverage:ignore-line
      builder: (BuildContext context) {//coverage:ignore-line
        return AlertDialog( //coverage:ignore-line
          title: Center(  //coverage:ignore-line
            child: Text("Login?"), //coverage:ignore-line
          ), //coverage:ignore-line
          content: Row(
            //coverage:ignore-line
            mainAxisAlignment: MainAxisAlignment.center, //coverage:ignore-line
            crossAxisAlignment:
                CrossAxisAlignment.center, //coverage:ignore-line
            children: <Widget>[
              //coverage:ignore-line
              Expanded(
                //coverage:ignore-line
                child: Text(
                  //coverage:ignore-line
                  "Do you want to login in with your Admin account", //coverage:ignore-line
                  textAlign: TextAlign.start, //coverage:ignore-line
                ), //coverage:ignore-line
              ), //coverage:ignore-line
            ], //coverage:ignore-line
          ), //coverage:ignore-line
          actions: <Widget>[
            //coverage:ignore-line
            FlatButton(
              //coverage:ignore-line
              child: Text('Yes'), //coverage:ignore-line
              onPressed: () {
                //coverage:ignore-line
                isClientLogin = false; //coverage:ignore-line
                Navigator.pop(context); //coverage:ignore-line
              }, //coverage:ignore-line
            ), //coverage:ignore-line
            FlatButton(
              //coverage:ignore-line
              child: Text('No'), //coverage:ignore-line
              onPressed: () {//coverage:ignore-line
                isClientLogin = true; //coverage:ignore-line
                Navigator.pop(context); //coverage:ignore-line
              }, //coverage:ignore-line
            ), //coverage:ignore-line
          ], //coverage:ignore-line
        ); //coverage:ignore-line
      }); //coverage:ignore-line

  String id = idController.text; //coverage:ignore-line
  String password = encode(passwordController.text); //coverage:ignore-line

  String response =
      await userLoginOnline(id, password, isClientLogin); //coverage:ignore-line
  Fluttertoast.showToast(msg: response); //coverage:ignore-line

  if (response == dbSuccess) {
    //coverage:ignore-line
    currID.id = idController.text; //coverage:ignore-line
    if (!isClientLogin) {
      //coverage:ignore-line
      goToAdminVerificationList(context); //coverage:ignore-line
    } else {
      //coverage:ignore-line
      goToAdminVerificationStatus(context); //coverage:ignore-line
      // getAccountDetails(id).then((accountDetails) {
      //   if (accountDetails.isEmpty) {
      //     goToAdminVerificationStatus(context);
      //   } else {
      //     goToViewAccount(context);
      //   }
      // });
    }
  }
}
//coverage:ignore-end

//Helper Functions

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
