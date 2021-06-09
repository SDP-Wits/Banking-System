import 'dart:convert';

import "package:http/http.dart" as http;
import 'package:last_national_bank/utils/helpers/ignore_helper.dart';

import '../../classes/accountDetails.dart';
import '../../classes/accountTypes.dart';
import '../../classes/log.dart';
import '../../classes/name.class.dart';
import '../../classes/specificAccount.dart';
import '../../classes/thisUser.dart';
import '../../classes/user.class.dart';
import '../../constants/database_constants.dart';
import '../../constants/php_url.dart';
import '../helpers/helper.dart';
import 'local_db.dart';

//Give in a url, get back a List of Maps (List of Rows) from PHP File
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
//Manually tested
//Log the user in, based off whether they are a client or not

// coverage:ignore-start
//coveralls-ignore-start
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


  bool isAdmin = !isClientLogin;
  User user = User((isAdmin) ? int.parse(data["adminID"]) : int.parse(data["clientID"]), data["firstName"], data["middleName"], data["lastName"], int.parse(data["age"]), data["phoneNumber"], data["email"], data["idNumber"], data["password"], isAdmin, int.parse(data["streetNumber"]), data["streetName"], data["suburb"], data["province"], data["country"], int.parse(data["apartmentNumber"]),
  );

  return await LocalDatabaseHelper.instance.addUserDetails(user.userID, user.email, user.phoneNumber, user.idNumber, user.hashPassword, user.age, user.firstName, user.middleName, user.lastName, user.isAdmin, user.address.streetNumber, user.address.streetName, user.address.suburb, user.address.province, user.address.country, user.address.apartmentNumber);
}
//coveralls-ignore-end
// coverage:ignore-end

//Admin Registering online
//no implementations found so im commnting it out for now
/*
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
*/

//Manually tested
//Getting list of all unverified clients
Future<List<Name>> getUnverifiedClients() async {
  final String url = urlPath + select_unverified_client_names;

  final List<Map> data = await getURLData(url);

  if (data[0].containsKey("status")) {
    if (!data[0]["status"]) {
      print("There are no unverified clients");
      return [];
    }
  }

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

//Manually tested
Future<int> getNumberOfAccounts() async {
  final String url = urlPath + count_num_accountTypes;

  final List<Map> data = (await getURLData(url));

  if (data[0].containsKey("status")) {
    if (!data[0]["status"]) {
      print("There are no account types");
      return 0;
    }
  }

  return int.parse(data[0]["NumAccountTypes"].toString());
}

//Manually tested
// get clients details for admin to view
Future<List<thisUser>> getClientDetails(String idNumber) async {
  final String arguments = "?id=$idNumber";
  final String url = urlPath + select_client_id + arguments;

  final List<Map> data = (await getURLData(url));

  if (data[0].containsKey("status")) {
    if (!data[0]["status"]) {
      print("There are no unverified clients");
      return [];
    }
  }

  List<thisUser> users = [];
  for (var map in data) {
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

//Manually tested
//Verify an unverified client
Future<String> verifyClient(
    String clientIdNumber, String adminIdNumber, String clientStatus, String php) async {
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

  Map data = (await getURLData(urlPath + php + arguments))[0];

  bool status = data["status"];

  if (status) {
    return dbSuccess;
  } else {
    return dbFailed;
  }
}

// Get account options data
Future<List<accountTypes>> getAccountTypes() async {
  final String url = urlPath + select_account_types;

  final List<Map> accTypeDetails = await getURLData(url);

  if (accTypeDetails[0].containsKey("status")) {
    if (!accTypeDetails[0]["status"]) {
      print("There are no account options");
      return [];
    }
  }

  List<accountTypes> bankAccTypes = [];

  for (int i = 0; i < accTypeDetails.length; ++i) {
    String accType = accTypeDetails[i]["accountType"];
    String accDescription = accTypeDetails[i]["accountDescription"];
    int accTypeId = int.parse(accTypeDetails[i]["accountTypeID"].toString());

    accountTypes accOption = accountTypes(
      accType: accType,
      accDescription: accDescription,
      accountTypeId: accTypeId,
    );

    bankAccTypes.add(accOption);
  }

  return bankAccTypes;
}

// Check which accounts exist for specific user
Future<List<int>> getExistingAccountTypes(int clientID) async {
  final String args = argumentMaker(
      phpNames: ["clientID"], inputVariables: [clientID.toString()]);

  final String url = urlPath + select_client_unique_accounts + args;

  final List<Map> existingAccTypes = await getURLData(url);

  if (existingAccTypes.isEmpty){
    return [];
  }

  if (existingAccTypes[0].containsKey("status")) {
    if (!existingAccTypes[0]["status"]) {
      print("There are no exisiting accounts for this user");
      return [];
    }
  }

  List<int> existingAccTypeID = [];

  for (int i = 0; i < existingAccTypes.length; ++i) {
    int accTypeId = int.parse(existingAccTypes[i]["accountTypeID"].toString());

    existingAccTypeID.add(accTypeId);
  }

  return existingAccTypeID;
}

//Manually tested
//Create a client's account
Future<String> createAccount(String clientIdNumber, int accountTypeID, String php) async {
  final String date = getDate();

  List<String> phpNames = ["clientIdNum", "accountType", "currentDate"];
  List<String> inputVariables = [
    clientIdNumber,
    accountTypeID.toString(),
    date
  ];

  String arguments =
      argumentMaker(phpNames: phpNames, inputVariables: inputVariables);

  final String url = urlPath + php + arguments;

  final Map data = (await getURLData(url))[0];

  if (data["status"]) {
    return dbSuccess;
  }

  return "Failed to create an account";
}

//Manually tested
//Get all the details for all the user's accounts
Future<List<accountDetails>> getAccountDetails(String idNumber) async {
  final String arguments = "?idNum=$idNumber";
  final String url = urlPath + select_client_account + arguments;

  final List<Map> data = await getURLData(url);

  List<accountDetails> accounts = [];

  if (data[0].containsKey("status")) {
    // Contain a key

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
        lName: map["lastName"],
        accountTypeId: int.parse(map['accountTypeID'].toString()));
    accounts.add(account);
  }

  return accounts;
}

//Getting account description from account id

//Manually tested
//Getting specific account details
Future<List<specificAccount>> getSpecificAccount(String accNum) async {
  final String arguments = "?accNum=$accNum";
  final String url = urlPath + select_specific_account + arguments;

  final List<Map> data = (await getURLData(url));

  if (data[0].containsKey("status")) {
    if (!data[0]["status"]) {
      print("There are no unverified clients");
      return [];
    }
  }

  List<specificAccount> specAccounts = [];
  for (var map in data) {
    specificAccount specAccount = specificAccount(
      accountNumber: map["accountNumber"],
      accountTypeId: int.parse(map["accountTypeID"]),
      currentBalance: double.parse(map["currentBalance"]),
      accountType: map["accountType"],
      accountDescription: map["accountDescription"],
      transactionID: int.parse(map["transactionID"]),
      customerName: map["customerName"],
      timeStamp: map["timeStamp"],
      amount: double.parse(map["amount"]),
      accountFrom: map["accountFrom"],
      accountTo: map["accountTo"],
      referenceName: map["referenceName"],
      referenceNumber: map["referenceNumber"],
    );
    specAccounts.add(specAccount);
  }

  return specAccounts;
}

//Manually tested
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

//Manually tested
Future<List<Log>> getLogs(String clientID) async {
  final String arguments = "?clientID=$clientID";
  final String url = urlPath + select_client_log + arguments;

  final List<Map> data = (await getURLData(url));
  // if (data[0].containsKey("status")) {
  //   if (!data[0]["status"]) {
  //     print("There are no logs");
  //     return [];
  //   }
  // }
  if (data.isEmpty) {
    return [];
  }
  List<Log> logs = [];
  for (var map in data) {
    Log log = Log(
      logDescription: map["description"],
      timeStamp: map["timeStamp"].toString(),
    );
    logs.add(log);
  }

  return logs;
}

//make a transfer (transaction option)
//used in transfer.functions.dart
Future<String> makeTransfer(
    String accountFrom, String accountTo, String amount, String refName) async {
  final String date = getDate();

  List<String> phpNames = [
    "accountFrom",
    "accountTo",
    "amount",
    "referenceName"
  ];
  List<String> inputVariables = [accountFrom, accountTo, amount, refName];

  String arguments =
      argumentMaker(phpNames: phpNames, inputVariables: inputVariables);

  final String url = urlPath + make_transfer + arguments;

  final Map data = (await getURLData(url))[0];

  if (data["status"]) {
    return dbSuccess;
  }

  return "Failed to make transfer";
}

Future<String> makePayment(String accountFrom, String accountTo, String amount,
    String refName, String clientID, String clientName) async {
  List<String> phpNames = [
    "accFrom",
    "clientID",
    "clientName",
    "amt",
    "accTo",
    "refname"
  ];
  List<String> inputVariables = [
    accountFrom,
    clientID,
    clientName,
    amount,
    accountTo,
    refName
  ];

  String arguments =
      argumentMaker(phpNames: phpNames, inputVariables: inputVariables);

  final String url = urlPath + make_payment + arguments;

  final Map data = (await getURLData(url))[0];

  if (data["status"]) {
    return dbSuccess;
  }

  return "Failed to make transfer";
}
