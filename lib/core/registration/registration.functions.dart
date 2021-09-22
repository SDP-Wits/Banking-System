library bankingsystem.globals;

import 'dart:core';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  static bool is_client = true;
  static String secretKey = "";
}

class Address {
  static String streetName = "";
  static String streetNumber = "15";
  static String suburb = "Green";
  static String province = "Gauteng";
  static String country = "South Africa";
  static String apartmentNumber = "0";
}

bool finalCheck = false;

// validation functions
bool fullvalidation() {
  bool flag = true;
  if (Data.age <= 12) {
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
  if (Address.streetName.length == 0) {
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
  if (Data.password1.length == 0) {
    flag = false;
  }
  if (Data.password1 != Data.password2) {
    flag = false;
  }
  return flag;
}

// this function just gives an error or success message depending on the validation
String giveError() {
  if (!fullvalidation()) {
    return ("Some Fields Have Errors");
  } else {
    return ("Proceed to next page");
  }
}

// Checks for any errors when entering password - used for validation
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

// Checks for any errors when entering ID Number - used for validation
bool hasInputErrorID(String idNum) {
  if (idNum.length != 13) {
    //checks if id num is of length 13
    return true;
  }
  bool hasLetters =
      double.tryParse(idNum) != null; //checks if id number contains any letters
  return !hasLetters;
}

//function to check for invalid age
bool hasInputErrorAge(int age) {
  if (age <= 12) {
    return true;
  }
  return false;
}

//function to check if email is invalid
bool hasInputErrorEmail(String email) {
  if (email.length == 0) {
    return true;
  } else if (email.length > 0) {
    //Regular expression to check if email contains all necessary email components (@, .com, etc.)
    return !RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }
  return false;
}

// following functions used for validation purposes
bool hasInputErrorId(String idNum) {
  if (idNum.length != 13) {
    //checks if id num is of length 13
    return true;
  }
  bool hasLetters =
      double.tryParse(idNum) != null; //checks if id number contains any letters
  return !hasLetters;
}

bool hasInputErrorInt(String Num) {
  bool hasLetters =
      double.tryParse(Num) != null; //checks if id number contains any letters
  return !hasLetters;
}

//function to check for invalid name
bool hasInputErrorName(String name) {
  if (name.length == 0) {
    return true;
  }
  return false;
}

bool hasInputErrorsPassword1(String password) {
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

bool hasInputErrorsPassword2(String passwordVal) {
  if (Data.password1 != passwordVal) {
    return true;
  }
  return false;
}

bool hasInputErrorPhone(String phone) {
  if (phone.length != 10) {
    //checks if phone num is of length 13
    return true;
  }
  bool hasLetters = double.tryParse(phone) !=
      null; //checks if phone number contains any letters
  return !hasLetters;
}

//function to check for invalid name
bool hasInputErrorSurname(String surname) {
  if (surname.length == 0) {
    return true;
  }
  return false;
}

// returns the current date
String currentDate() {
  // coverage:ignore-start
  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');
  String formattedDate = formatter.format(now);
  return formattedDate;
}



void setCheck(bool check) {
  finalCheck = check;
}

bool getCheck() {
  if (finalCheck){
    return fullvalidation();
  }
  return false;
}
// coverage:ignore-end
