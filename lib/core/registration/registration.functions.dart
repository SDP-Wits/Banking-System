library bankingsystem.globals;

import 'dart:core';

import 'package:intl/intl.dart';

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

//shared data classes
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
  static bool is_client = false;
  static String secretKey = "";
}

class Address {
  static String streetName = "West Street";
  static String streetNumber = "15";
  static String suburb = "Green";
  static String province = "Gauteng";
  static String country = "South Africa";
  static String apartmentNumber = "0";
}

// validation functions
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

// date

String currentDate() {
  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');
  String formattedDate = formatter.format(now);
  return formattedDate;
}

bool _finalCheck = false;

void setCheck(bool check) {
  _finalCheck = check;
}

bool getCheck() {
  return _finalCheck;
}
