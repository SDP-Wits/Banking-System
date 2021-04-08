import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../constants/php_url.dart';
import '../core/registration/registration.functions.dart';
import '../utils/services/online_db.dart';

Future<String> userRegisterOnline(bool isClientRegistration) async {
  //Choosing php file based off whether the user is a client or admin
  String phpFileToUse = isClientRegistration ? insert_client : insert_admin;

  List<String> phpNames = [
    "firstName",
    "middleName",
    "lastName",
    "age",
    "phoneNum",
    "email",
    "idNum",
    "password"
  ];
  final String arguments = argumentMaker(phpNames: phpNames, inputVariables: [
    Data.name,
    "",
    Data.surname,
    Data.age.toString(),
    Data.phone,
    Data.email,
    Data.idnum,
    Data.password1
  ]);

  // print(urlPath + phpFileToUse + arguments);
  Map data = (await getURLData(urlPath + phpFileToUse + arguments))[0];

  //If there is an error
  if (data.containsKey("status")) {
    if (!data["status"]) {
      return data["error"];
    }
  }

  return data["error"];
}

class ButtonNewUser extends StatefulWidget {
  @override
  _ButtonNewUserState createState() => _ButtonNewUserState();
}

class _ButtonNewUserState extends State<ButtonNewUser> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Container(
        alignment: Alignment.center,
        height: 40,
        width: MediaQuery.of(context).size.width / 2,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0, // has the effect of softening the shadow
            spreadRadius: 1.0, // has the effect of extending the shadow
            /*offset: Offset(
              5.0, // horizontal, move right 10
              5.0, // vertical, move down 10
            ),*/
          ),
        ], color: Colors.indigo[200], borderRadius: BorderRadius.circular(30)),
        child: TextButton(
          onPressed: () {
            if (Data.is_client) {
              if (!fullvalidation()) {
                // give error
                Fluttertoast.showToast(
                    msg: "client error",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 3,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              } else {
                // call php for client
                userRegisterOnline(true);
                Fluttertoast.showToast(
                    msg: "client sorted",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 3,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            } else {
              if (!fullvalidation()) {
                // give error
                Fluttertoast.showToast(
                    msg: "admin error",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 3,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              } else {
                Fluttertoast.showToast(
                    msg: "admin sorted",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 3,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
                // call php for admin
              }
            }

            // Fluttertoast.showToast(
            //     msg: giveError(),
            //     toastLength: Toast.LENGTH_SHORT,
            //     gravity: ToastGravity.CENTER,
            //     timeInSecForIosWeb: 3,
            //     backgroundColor: Colors.red,
            //     textColor: Colors.white,
            //     fontSize: 16.0);

            //insertClient();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Create Account',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
