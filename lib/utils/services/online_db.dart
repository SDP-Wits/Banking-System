import 'dart:convert';

import "package:http/http.dart" as http;
import '../../classes/user.client.dart';
import 'local_db.dart';

import '../../constants/database_constants.dart';
import '../../constants/php_url.dart';

Future<List<Map<String, dynamic>>> getURLData(String url) async {
  final Uri uri = Uri.parse(url);

  final httpResponse = await http.get(uri);

  if (httpResponse.statusCode == 200) {
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
  Map data = (await getURLData(urlPath + phpFileToUse))[0];

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
  bool isAdmin = !isClientLogin;
  User user = User(
      data["clientID"],
      data["firstName"],
      data["middleName"],
      data["lastName"],
      data["age"],
      data["phoneNumber"],
      data["email"],
      data["idNumber"],
      data["password"],
      isAdmin,
      data["streetNumber"],
      data["streetName"],
      data["suburb"],
      data["province"],
      data["country"],
      data["apartmentNumber"]);

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
  Map data = (await getURLData(urlPath + insert_admin))[0];

  bool status = data["status"];

  if (status) {
    return dbSuccess;
  } else {
    return data["error"];
  }
}

//TODO: insert_client

//TODO: select_unverified_clients
