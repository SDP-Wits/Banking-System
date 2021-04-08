import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:last_national_bank/classes/user.client.dart';
import 'package:last_national_bank/constants/database_constants.dart';
import 'package:last_national_bank/utils/helpers/helper.dart';
import 'package:last_national_bank/utils/services/local_db.dart';
import 'package:last_national_bank/utils/services/online_db.dart';

class PlaygroundTest extends StatefulWidget {
  @override
  _PlaygroundTestState createState() => _PlaygroundTestState();
}

class _PlaygroundTestState extends State<PlaygroundTest> {
  String testID = "1234567891012";
  String hashPassword =
      "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa";
  bool isClientLogin = true;
  // ignore: avoid_init_to_null
  User? user = null;

  @override
  void initState() {
    super.initState();
    userLoginOnline(testID, hashPassword, isClientLogin).then((statusString) {
      toastyPrint("user login was $statusString");
      if (statusString == dbSuccess) {
        LocalDatabaseHelper.instance.getUserAndAddress().then((localUser) {
          if (localUser != null) {
            setState(() {
              user = localUser;
            });
            toastyPrint("local User is not empty");
          } else {
            toastyPrint("local User is empty");
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return (user == null)
        ? Container(
            child: Center(
              child: Text("USER IS NULLLLLLL!!!!"),
            ),
          )
        : Container(
            child: Column(
              children: [
                Text(user!.firstName),
                Text(user!.middleName == null ? "" : user!.middleName!),
                Text(user!.lastName),
                Text(user!.age.toString()),
                Text(user!.address.streetName),
                Text(user!.email),
                Text(user!.hashPassword),
              ],
            ),
          );
  }
}
