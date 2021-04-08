library bankingsystem.globals;
import 'dart:core';
import 'dart:html';

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

// bool registerAdmin(String idNumber) {
//   return true;
// }
var  age = NewAgeState().returnAge() ;
var name = NewNameState().returnName() ;
var surname = NewSurnameState().returnSurName();
var email = NewEmailState().returnEmail();
var idNum = NewIDnumState().returnID();
var loc = NewLocState().returnloc();
var password = PasswordInputState().getPassword();
var password2 = PasswordInput2State().returnpassword2() ;
var phone = NewPhoneState().returnPhone();

var hash = encode(password);

String returnhash(){
  return hash;
}

bool fullvalidation(){
  bool flag = true;
  if (age <= 0){
      flag = false;
    }
  if (email.length <= 0){
      flag = false;
    }
    else {
      //Regular expression to check if email contains all necessary email components (@, .com, etc.)
      if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)){
        flag = false;
      }
    }

  if (idNum.length != 13){  //checks if id num is of length 13
      flag = false;
    }
    if (loc.length == 0){
      flag = false;
    }
    if (name.length == 0){
      flag = false;
    }
    if (phone.length != 10){  //checks if phone num is of length 13
      flag = false;
    }
    bool hasLetters = double.tryParse(phone) != null; //checks if phone number contains any letters
    if(!hasLetters){
      flag = false;
    }
    if (surname.length == 0){
      flag = false;
    }
  return flag;
}

String giveError(){
  if(!fullvalidation()){
    return ("Some Fields Have Errors");
  }
  else{return ("Proceed to next page");}
}

// String apiURLclient = "";

// Future insertClient() async {

//     final response = await http.post(apiURL, body:{"date": today});
// }