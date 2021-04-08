library bankingsystem.globals;

import 'dart:convert';
import 'dart:core';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:last_national_bank/core/registration/widgets/NewAge.dart';
import 'package:last_national_bank/core/registration/widgets/NewIDnum.dart';
import 'package:last_national_bank/core/registration/widgets/NewLoc.dart';
import 'package:last_national_bank/core/registration/widgets/NewPassword.dart';
import 'package:last_national_bank/core/registration/widgets/NewPassword2.dart';
import 'package:last_national_bank/core/registration/widgets/NewPhone.dart';
import 'package:last_national_bank/core/registration/widgets/NewSurname.dart';
import 'package:last_national_bank/core/registration/widgets/newEmail.dart';
import 'package:last_national_bank/core/registration/widgets/newName.dart';
import 'package:last_national_bank/core/SHA-256_encryption.dart';
import 'package:last_national_bank/constants/php_url.dart';

// bool registerAdmin(String idNumber) {
//   return true;
// }
// var age = NewAgeState().returnAge();
// var name = NewNameState().returnName();
// var surname = NewSurnameState().returnSurName();
// var email = NewEmailState().returnEmail();
// var idNum = NewIDnumState().returnID();
// var loc = NewLocState().returnloc();
// var password = PasswordInputState().getPassword();
// var password2 = PasswordInput2State().returnpassword2();
// var phone = NewPhoneState().returnPhone();

// var hash = encode(password);

class Data {
  static String password1 = "";
  static String password2 = "";
  static String name = "";
  static String surname = "";
  static String email = "";
  static String idnum = "";
  static String loc = "";
  static String phone = "";
  static int age = 0;



}

bool fullvalidation() {
  bool flag = true;
  if (Data.age <= 0) {
    flag = false;
  }
  if (Data.email.length <= 0) {
    flag = false;
  } else {
    //Regular expression to check if email contains all necessary email components (@, .com, etc.)
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(Data.email)) {
      flag = false;
    }
  }

  if (Data.idnum.length != 13) {
    //checks if id num is of length 13
    flag = false;
  }
  if (Data.loc.length == 0) {
    flag = false;
  }
  if (Data.name.length == 0) {
    flag = false;
  }
  if (Data.phone.length != 10) {
    //checks if phone num is of length 13
    flag = false;
  }
  bool hasLetters = double.tryParse(Data.phone) !=
      null; //checks if phone number contains any letters
  if (!hasLetters) {
    flag = false;
  }
  if (Data.surname.length == 0) {
    flag = false;
  }
  if (Data.password1 != Data.password2) {
    flag = false;
  }
  return flag;
}


String giveError() {
  if (!fullvalidation()) {
    return ("Some Fields Have Errors");
  } else {
    return ("Proceed to next page");
  }
}



String apiURLclient = urlPath + insert_client;

Future insertClient() async {

    final response = await http.post(apiURLclient as Uri, body:{
      "firstName": Data.name,
      "lastName" : Data.surname,
      "age" : Data.age,
      "phoneNum" : Data.phone,
      "email": Data.email,
      "idNum": Data.idnum,
      "password":Data.password1,
    });
     Fluttertoast.showToast(
          msg: response.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);

}


