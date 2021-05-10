import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import "package:http/http.dart" as http;
import 'package:last_national_bank/classes/accountTypes.dart';
import 'package:last_national_bank/classes/thisUser.dart';
import 'package:last_national_bank/classes/accountDetails.dart';
import 'package:last_national_bank/utils/helpers/helper.dart';

import '../../classes/name.class.dart';
import '../../classes/user.class.dart';
import '../../constants/database_constants.dart';
import '../../constants/php_url.dart';
import 'local_db.dart';

Future<List<Map<String, dynamic>>> getURLData(String url) async {
  print(url);
  final Uri uri = Uri.parse(url);

  final httpResponse = await http.get(uri);

  if (httpResponse.statusCode == 200) {
    print("response from json is " + httpResponse.body);
    final jsonOutput = json.decode(httpResponse.body);

    List<Map<String, dynamic>> map = [];
    for (dynamic e in jsonOutput) {
      map.add(Map<String, dynamic>.from(e));
    }

    return map;
  } else {
    print("Oi, the url that just failed was : $url");
    return [
      {"error": "Failed to get data from database"}
    ];
  }
}

//TODO: Tests
//
Future<String> userLoginOnline(
    String idNumber, String hashPassword, bool isClientLogin) async {
  //Choosing php file based off whether the user is a client or admin
  String phpFileToUse =
      isClientLogin ? attempt_client_login : attempt_admin_login;

  List<String> phpNames = ["id", "password"];
  final String arguments = argumentMaker(
      phpNames: phpNames, inputVariables: [idNumber, hashPassword]);

  // print(urlPath + phpFileToUse + arguments);
  Map data = (await getURLData(urlPath + phpFileToUse + arguments))[0];

  //If there is an error
  if (data.containsKey("status")) {
    if (!data["status"]) {
      return data["error"];
    }
  }

  //If there isn't an error, then we should add User to local DB
  //then we should return dbSuccess

  //TODO: check out how null values get returned from the database
  //i.e. the apartmentNumber
  print("null value in sql is: ");
  print(data["apartmentNumber"]);
  bool isAdmin = !isClientLogin;
  User user = User(
    (isAdmin) ? int.parse(data["adminID"]) : int.parse(data["clientID"]),
    data["firstName"],
    data["middleName"],
    data["lastName"],
    int.parse(data["age"]),
    data["phoneNumber"],
    data["email"],
    data["idNumber"],
    data["password"],
    isAdmin,
    int.parse(data["streetNumber"]),
    data["streetName"],
    data["suburb"],
    data["province"],
    data["country"],
    int.parse(data["apartmentNumber"]),
  );

  //TODO: Chech how the user data is looking like

  return await LocalDatabaseHelper.instance.addUserDetails(
      user.userID,
      user.email,
      user.phoneNumber,
      user.idNumber,
      user.hashPassword,
      user.age,
      user.firstName,
      user.middleName,
      user.lastName,
      user.isAdmin,
      user.address.streetNumber,
      user.address.streetName,
      user.address.suburb,
      user.address.province,
      user.address.country,
      user.address.apartmentNumber);
}

//TODO: insert_admin
Future<String> adminRegisterOnline(String idNumber, String hashPassword) async {
  final String arguments = "?id=$idNumber;password=$hashPassword";
  Map data = (await getURLData(urlPath + insert_admin + arguments))[0];

  bool status = data["status"];

  if (status) {
    return dbSuccess;
  } else {
    return data["error"];
  }
}

//TODO: insert_client

//TODO: select_unverified_clients
Future<List<Name>> getUnverifiedClienta() async {
  final String url = urlPath + select_unverified_client_names;

  final data = await getURLData(url);

  List<Name> names = [];
  for (var map in data) {
    Name name = Name(
      fName: map["firstName"],
      mName: (map["middleName"] == null) ? null : map["middleName"],
      sName: map["lastName"],
      IDnum: map["idNumber"],
    );

    names.add(name);
  }

  return names;
}

// get clients details for admin to view

Future<List<thisUser>> getclientdets(String idNumber) async {
  final String arguments = "?id=$idNumber";
  final String url = urlPath + select_client_id + arguments;

  List<Map> data = (await getURLData(url));

  List<thisUser> users = [];
  for (var map in data) {
    if (map.containsKey("status")) {
      if (!map["status"]) {
        return [];
      }
    }

    thisUser user = thisUser(
        userID: int.parse(map["clientID"]),
        firstName: map["firstName"],
        middleName: (map["middleName"] == null) ? null : map["middleName"],
        lastName: map["lastName"],
        age: int.parse(map["age"]),
        phoneNumber: map["phoneNumber"],
        email: map["email"],
        idNumber: map["idNumber"],
        address: "",
        status: map["verificationStatus"]);

    users.add(user);
  }
  return users;
}

Future<String> verifyClient(
    String clientIdNumber, String adminIdNumber, String clientStatus) async {
  String date = getDate();

  String arguments = argumentMaker(phpNames: [
    "clientIdNum",
    "adminIdNum",
    "currentDate",
    "verificationStatus"
  ], inputVariables: [
    clientIdNumber,
    adminIdNumber,
    date,
    clientStatus
  ]);

  Map data = (await getURLData(urlPath + verify_client + arguments))[0];

  bool status = data["status"];

  if (status) {
    return dbSuccess;
  } else {
    return dbFailed;
  }
}

// Get account options data
Future<List<accountTypes>> getAccTypes() async {
  String url = urlPath + select_account_types;

  List<Map> accTypeDetails = await getURLData(url);

  List<accountTypes> bankAccTypes = [];

  for (int i = 0; i < accTypeDetails.length; ++i) {
    String accType = accTypeDetails[i]["accountType"];
    String accDescription = accTypeDetails[i]["accountDescription"];

    accountTypes accOption =
        accountTypes(accType: accType, accDescription: accDescription);

    bankAccTypes.add(accOption);
  }

  return bankAccTypes;
}

Future<String> createAccount(String clientID, String accountType) async {
  String date = getDate();

  List<String> phpNames = ["clientIdNum", "accountType", "currentDate"];
  List<String> inputVariables = [clientID, accountType, date];

  String arguments =
      argumentMaker(phpNames: phpNames, inputVariables: inputVariables);

  final String url = urlPath + insert_new_account + arguments;

  Map data = (await getURLData(url))[0];

  if (data["status"]) {
    return dbSuccess;
  }

  return "Failed to create an account";
}

// get client account details

// Future<List<accountDetails>> getAccountDetails(String accNumber) async {
//   final String arguments = "?accNum=$accNumber";
//   final String url = urlPath + select_client_account + arguments;
//
//   final data = await getURLData(url);
//
//   List<accountDetails> accounts = [];
//   for (var map in data) {
//     accountDetails account = accountDetails(
//         accountNumber: map["accountNumber"],
//         accountTypeID: int.parse(map["accountTypeID"]),
//         currentBalance: map["currentBalance"],
//         createdDate: map["createdDate"]);
//     accounts.add(account);
//   }
//   return accounts;
// }
Future<List<accountDetails>> getAccountDetails(String idNumber) async {
  final String arguments = "?idNum=$idNumber";
  final String url = urlPath + select_client_account + arguments;

  final List<Map> data = await getURLData(url);

  List<accountDetails> accounts = [];

  if (data[0].containsKey("status")){  // Contain a key 

    bool status = (data[0])["status"];

    if (status == false) {
      return [];
    }
  }

  for (var map in data) {
    accountDetails account = accountDetails(
        accountNumber: map["accountNumber"],
        accountType: map["accountType"],
        currentBalance: double.parse(map["currentBalance"].toString()),
        fName: map["firstName"],
        mName: map["middleName"],
        lName: map["lastName"]);
    accounts.add(account);
  }

  return accounts;
  
}

//Helper Functions

String argumentMaker(
    {required List<String> phpNames, required List<String> inputVariables}) {
  String argument = "?";
  int length = phpNames.length;

  for (int i = 0; i < length; i++) {
    argument += "${phpNames[i]}=${inputVariables[i]}";

    if (i != length - 1) {
      argument += '&';
    }
  }

  return argument;
}
