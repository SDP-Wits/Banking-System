import 'dart:convert';
import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import "package:http/http.dart" as http;

import '../../classes/accountDetails.dart';
import '../../classes/accountTypes.dart';
import '../../classes/log.dart';
import '../../classes/name.class.dart';
import '../../classes/specificAccount.dart';
import '../../classes/thisUser.dart';
import '../../classes/user.class.dart';
import '../../constants/database_constants.dart';
import '../../constants/php_url.dart';
import '../helpers/ignore_helper.dart';
import 'local_db.dart';

//Give in a url, get back a List of Maps (List of Rows) from PHP File
// ignore: avoid_init_to_null
Future<List<Map<String, dynamic>>> getURLData(
    {required String url, Map<String, String>? data = null}) async {
  print(url);
  if (data != null) {
    print(data);
  }

  final Uri uri = Uri.parse(url);

  try {
    final httpResponse = await http.post(
      uri,
      body: data,
    );

    if (httpResponse.statusCode == 200) {
      print("response from json is " + httpResponse.body);
      final jsonOutput = json.decode(httpResponse.body);

      List<Map<String, dynamic>> map = [];
      for (dynamic e in jsonOutput) {
        map.add(Map<String, dynamic>.from(e));
      }

      return map;
    } else {
      //coverage-ignore-line
      print("Oi, the url that just failed was : $url");return [{"error": "Failed to get data from database"}];
    }
    //coverage-ignore-line
  } on SocketException catch (e) {print("Database down");print(e.toString());Fluttertoast.showToast(msg: "The database's server is down :(");return [{"status": false, "error": "Failed to connect to database"}];
  } catch (e) {
    //coverage-ignore-line
    print("php script might be messed up");print(url);print(e.toString());Fluttertoast.showToast(msg:"Whoops, we encounted an issue. Please try again or contact support");return [{"status": false, "error": "Failed to get your information"}];
  }
}
//Log the user in, based off whether they are a client or not

Future<String> userLoginOnline(
    String idNumber, String hashPassword, bool isClientLogin) async {
  // coverage:ignore-start
  //Choosing php file based off whether the user is a client or admin"
  String phpFileToUse =
      isClientLogin ? attempt_client_login : attempt_admin_login;

  final Map<String, String> arguments = {
    "id": idNumber,
    "password": hashPassword,
  };

  // print(urlPath + phpFileToUse + arguments);
  Map data =
      (await getURLData(url: urlPath + phpFileToUse, data: arguments))[0];

  //If there is an error
  if (data.containsKey("status")) {
    if (!data["status"]) {
      return data["error"];
    }
  }

  //If there isn't an error, then we should add User to local DB
  //then we should return dbSuccess

  bool isAdmin = !isClientLogin;
  //coverage:ignore-start
  User user = User((isAdmin) ? int.parse(data["adminID"]) : int.parse(data["clientID"]),data["firstName"],data["middleName"],data["lastName"],int.parse(data["age"]),data["phoneNumber"],data["email"],data["idNumber"],data["password"],isAdmin,int.parse(data["streetNumber"]),data["streetName"],data["suburb"],data["province"],data["country"],int.parse(data["apartmentNumber"]),
    //coverage:ignore-end
  );

  //coverage:ignore-start
  return await LocalDatabaseHelper.instance.addUserDetails(user.userID,user.email,user.phoneNumber,user.idNumber,user.hashPassword,user.age,user.firstName,user.middleName,user.lastName,user.isAdmin,user.address.streetNumber,user.address.streetName,user.address.suburb,user.address.province,user.address.country,user.address.apartmentNumber);
  //coverage:ignore-end
}

//Getting list of all unverified clients
Future<List<Name>> getUnverifiedClients() async {
  final String url = urlPath + select_unverified_client_names;

  final List<Map> data = await getURLData(url: url);

  //no unverfied clients
  //or
  //status only returned in failed case, so as long as the returned data
  // contains "status" we can assume it failed
//coverage-ignore-line
  if (data.isEmpty || data[0].containsKey("status")) {
    return [];
  }

  

// coverage:ignore-start
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
  // coverage:ignore-end

  return names;
}

Future<int> getNumberOfAccounts() async {
  final String url = urlPath + count_num_accountTypes;

  final List<Map> data = (await getURLData(url: url));

  //status only returned in failed case, so as long as the returned data
  // contains "status" we can assume it failed
  // There will always be account typed in the db
  if (data[0].containsKey("status")) {
    // coverage:ignore-start
    return 0;
    // coverage:ignore-end
  }
  return int.parse(data[0]["NumAccountTypes"].toString());
}

// this function gets the ClientID from the database, using the clients ID number - we get all details, and return the ClientID
Future<int> getClientID(String accountNumber) async {
  final String url = urlPath + get_client_id;

  final Map<String, String> arguments = {
    "accountNumber": accountNumber,
  };

  final List<Map> data = (await getURLData(url: url, data: arguments));

  //status only returned in failed case, so as long as the returned data
  // contains "status" we can assume it failed
  if (data[0].containsKey("status")) {
    return 0;
  }

  return int.parse(data[0]["clientID"].toString());
}

// get clients details for admin to view
Future<List<thisUser>> getClientDetails(String idNumber) async {
  final String url = urlPath + select_client_id;

  final Map<String, String> arguments = {
    "id": idNumber,
  };

  final List<Map> data = (await getURLData(url: url, data: arguments));

  //status only returned in failed case, so as long as the returned data
  // contains "status" we can assume it failed
  if (data[0].containsKey("status")) {
    return [];
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

//Verify an unverified client
Future<String> verifyClient(String clientIdNumber, String adminIdNumber,
    String clientStatus, String php) async {
  String date = getDate();

  final Map<String, String> arguments = {
    "clientIdNum": clientIdNumber,
    "adminIdNum": adminIdNumber,
    "currentDate": date,
    "verificationStatus": clientStatus,
  };

  Map data = (await getURLData(url: urlPath + php, data: arguments))[0];

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

  final List<Map> accTypeDetails = await getURLData(url: url);

  //status only returned in failed case, so as long as the returned data
  // contains "status" we can assume it failed
  if (accTypeDetails[0].containsKey("status")) {
    //coverage:ignore-start
    return [];
    //coverage:ignore-end
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
  final Map<String, String> arguments = {
    "clientID": clientID.toString(),
  };

  final String url = urlPath + select_client_unique_accounts;

  final List<Map> existingAccTypes =
      await getURLData(url: url, data: arguments);

  // if client has no accounts
  if (existingAccTypes.isEmpty) {
    //coverage:ignore-start
    return [];
    //coverage:ignore-end
  }

  //status only returned in failed case, so as long as the returned data
  // contains "status" we can assume it failed
  if (existingAccTypes[0].containsKey("status")) {
    return [];
  }

  List<int> existingAccTypeID = [];

  for (int i = 0; i < existingAccTypes.length; ++i) {
    int accTypeId = int.parse(existingAccTypes[i]["accountTypeID"].toString());

    existingAccTypeID.add(accTypeId);
  }

  return existingAccTypeID;
}

//Create a client's account
Future<String> createAccount(
    String clientIdNumber, int accountTypeID, String php) async {
  final String date = getDate();

  final Map<String, String> arguments = {
    "clientIdNum": clientIdNumber,
    "accountType": accountTypeID.toString(),
    "currentDate": date,
  };

  final String url = urlPath + php;

  final Map data = (await getURLData(url: url, data: arguments))[0];

  if (data["status"]) {
    return dbSuccess;
  }

  return "Failed to create an account";
}

//Get all the details for all the user's accounts
Future<List<accountDetails>> getAccountDetails(String idNumber) async {
  final String url = urlPath + select_client_account;

  final Map<String, String> arguments = {
    "idNum": idNumber,
  };

  final List<Map> data = await getURLData(
    url: url,
    data: arguments,
  );

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

//Getting specific account details
Future<List<specificAccount>> getSpecificAccount(String accNum) async {
  final String url = urlPath + select_specific_account;

  final Map<String, String> arguments = {
    "accNum": accNum,
  };

  final List<Map> data = (await getURLData(url: url, data: arguments));

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

//Helper Functions

// This function gets the logs for a specific client to view on their timeline page
Future<List<Log>> getLogs(String clientID) async {
  final String url = urlPath + select_client_log;

  final Map<String, String> arguments = {
    "clientID": clientID,
  };

  final List<Map> data = (await getURLData(url: url, data: arguments));
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
  final String url = urlPath + make_transfer;

  final Map<String, String> arguments = {
    "accountFrom": accountFrom,
    "accountTo": accountTo,
    "amount": amount,
    "referenceName": refName,
  };

  final Map data = (await getURLData(url: url, data: arguments))[0];

  if (data["status"]) {
    return dbSuccess;
  }

  return "Failed to make transfer";
}

Future<String> makePayment(
    String recipientClientID,
    String accountFrom,
    String accountTo,
    String amount,
    String refName,
    String clientID,
    String clientName) async {
  final String url = urlPath + make_payment;

  final Map<String, String> arguments = {
    "recipientClientID": recipientClientID,
    "accFrom": accountFrom,
    "clientID": clientID,
    "clientName": clientName,
    "amt": amount,
    "accTo": accountTo,
    "refname": refName,
  };

  final Map data = (await getURLData(
    url: url,
    data: arguments,
  ))[0];

  if (data["status"]) {
    return dbSuccess;
  }

  return "Failed to make transfer";
}

//Insert admin to database
Future<String> insertAdmin({
  required String firstName,
  String middleName = "",
  required String lastName,
  required String age,
  required String phoneNum,
  required String email,
  required String idNum,
  required String password,
  required String secretKey,
  required String currentDate,
  required String streetName,
  required String streetNum,
  required String suburb,
  required String province,
  required String country,
  required String apartmentNum,
}) async {
  final String url = urlPath + insert_admin;

  final Map<String, String> arguments = {
    "firstName": firstName,
    "middleName": middleName,
    "lastName": lastName,
    "age": age,
    "phoneNum": phoneNum,
    "email": email,
    "idNum": idNum,
    "password": password,
    "secretKey": secretKey,
    "currentDate": currentDate,
    "streetName": streetName,
    "streetNum": streetNum,
    "suburb": suburb,
    "province": province,
    "country": country,
    "apartmentNum": apartmentNum,
  };

  // print(urlPath + phpFileToUse + arguments);
  Map data = (await getURLData(url: url, data: arguments))[0];

  //If there is an error
  return (data["status"]) ? data["details"] : data["error"];
}

//Insert client to database
Future<String> insertClient({
  required String firstName,
  String middleName = "",
  required String lastName,
  required String age,
  required String phoneNum,
  required String email,
  required String idNum,
  required String password,
  required String streetName,
  required String streetNum,
  required String suburb,
  required String province,
  required String country,
  required String apartmentNum,
}) async {
  final String url = urlPath + insert_client;

  final Map<String, String> arguments = {
    "firstName": firstName,
    "middleName": middleName,
    "lastName": lastName,
    "age": age,
    "phoneNum": phoneNum,
    "email": email,
    "idNum": idNum,
    "password": password,
    "streetName": streetName,
    "streetNum": streetNum,
    "suburb": suburb,
    "province": province,
    "country": country,
    "apartmentNum": apartmentNum,
  };

  // print(urlPath + phpFileToUse + arguments);
  Map data = (await getURLData(url: url, data: arguments))[0];

  //If there is an error
  return (data["status"]) ? data["details"] : data["error"];
}

//Get recent transaction history (past 6 months only) for pdf statements page
Future<List<specificAccount>> getRecentTransactions(String clientID) async {
  final String url = urlPath + select_previous_transactions;

  final Map<String, String> arguments = {
    "clientID": clientID,
  };

  final List<Map> data = (await getURLData(url: url, data: arguments));

  if (data.isEmpty) {
    return [];
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
