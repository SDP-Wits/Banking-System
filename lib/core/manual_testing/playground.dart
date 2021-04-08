import 'package:flutter/material.dart';

import '../../classes/user.client.dart';
import '../../constants/database_constants.dart';
import '../../utils/helpers/helper.dart';
import '../../utils/services/local_db.dart';
import '../../utils/services/online_db.dart';

class PlaygroundTest extends StatefulWidget {
  @override
  _PlaygroundTestState createState() => _PlaygroundTestState();
}

class _PlaygroundTestState extends State<PlaygroundTest> {
  String testID = "0123456789123";
  String hashPassword =
      "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb";
  bool isClientLogin = false;
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
