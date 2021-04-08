import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

final TextEditingController idController = TextEditingController(text: "");
final TextEditingController passwordController =
    TextEditingController(text: "");

TextEditingController getIDController() {
  return idController;
}

TextEditingController getPasswordController() {
  return passwordController;
}

void loginProcedure(BuildContext context) {
  bool isAdmin = false;
  Fluttertoast.showToast(msg: "hey there you tappedm e");
  showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Container(
            padding: EdgeInsets.all(15),
            color: Colors.white,
            child: Column(
              children: [
                Text("Do you want to login in with your Admin account?"),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        isAdmin = true;
                        Fluttertoast.showToast(msg: isAdmin.toString());
                        Navigator.pop(context);
                      },
                      child: Text("Yes"),
                    ),
                    TextButton(
                      onPressed: () {
                        isAdmin = false;
                        Fluttertoast.showToast(msg: isAdmin.toString());
                        Navigator.pop(context);
                      },
                      child: Text("No"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      });
  String id = idController.text;
  String password = passwordController.text;
  Fluttertoast.showToast(msg: isAdmin.toString());
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
