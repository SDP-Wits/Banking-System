import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../widgets/inputEmail.dart';

bool login(String idNumber, String password) {
  return true;
}

void loginProcedure(String s) {
  String email = InputEmail().getEmail();
  Fluttertoast.showToast(msg: email + "ccc");
}

String hash(String string) {
  return string;
}
