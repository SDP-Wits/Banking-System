library bankingsystem.globals;
import 'dart:core';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:last_national_bank/widgets/NewAge.dart';
import 'package:last_national_bank/widgets/NewSurname.dart';
import 'package:last_national_bank/widgets/newName.dart';
import 'package:last_national_bank/widgets/newEmail.dart';
import 'package:last_national_bank/widgets/NewIDnum.dart';
import 'package:last_national_bank/widgets/NewLoc.dart';
import 'package:last_national_bank/widgets/NewPhone.dart';
import 'package:last_national_bank/widgets/NewPassword.dart';
import 'package:last_national_bank/widgets/NewPassword2.dart';
import 'package:last_national_bank/core/SHA-256_encryption.dart';

// bool registerAdmin(String idNumber) {
//   return true;
// }
var  _age = NewAgeState().returnAge() ;
var _name = NewNameState().returnName() ;
var _surname = NewSurnameState().returnSurName();
var _email = NewEmailState().returnEmail();
var idNum = NewIDnumState().returnID();
var _loc = NewLocState().returnloc();
var password = PasswordInputState().getPassword();
var password2 = PasswordInput2State().returnpassword() ;
var _phone = NewPhoneState().returnPhone();

var hash = encode(password);

String returnhash(){
  return hash;
}





