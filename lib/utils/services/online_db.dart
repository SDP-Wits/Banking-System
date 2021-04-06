import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import "package:http/http.dart" as http;
import 'package:last_national_bank/constants/database_constants.dart';

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

Future<String> clientLoginOnline(String idNumber, String hashPassword) async {
  //TODO: Testing
  //Either [{error : ErrorMsg, status : false}]
  //OR [{status : true}]

  Map data = (await getURLData(urlPath + attempt_client_login))[0];

  bool status = data["status"];

  if (status) {
    return dbSuccess;
    //returns "Success", in the frontend, check if the return
    // string is dbSuccess, if it is then you know you it works, else you know you
    // got an error message instead
  } else {
    //So if status is false, hence there is an error of some sort
    return data["error"];
  }

  //And on the front end your code will look something like this
  /*
  String clientLoginString = await clientLoginOnline(idNumber, hashPassword);
  if (clientLoginString == dbSuccess) {
    //Do something coz the user had correct credentials
  } else {
    //Insert some kwl error handling shit here
    Fluttertoast.showToast(msg: "THERE IS AN ERROR!!! $clientLoginString");
  }
  */
}
