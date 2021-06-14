import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../constants/php_url.dart';
import '../../../utils/helpers/style.dart';
import '../../../utils/services/online_db.dart';
import '../../../utils/helpers/SHA-256_encryption.dart';
import '../registration.functions.dart';

// coverage:ignore-start
//Manually tested
Future<String> clientRegisterOnline() async {
  //Choosing php file based off whether the user is a client or admin
  String phpFileToUse = insert_client;
  List<String> phpNames = [
    "firstName",
    "middleName",
    "lastName",
    "age",
    "phoneNum",
    "email",
    "idNum",
    "password",
    "streetName",
    "streetNum",
    "suburb",
    "province",
    "country",
    "apartmentNum"
  ];
  final String arguments = argumentMaker(phpNames: phpNames, inputVariables: [
    Data.name,
    "",
    Data.surname,
    Data.age.toString(),
    Data.phone,
    Data.email,
    Data.idnum,
    encode(Data.password1).toString(),
    Address.streetName,
    Address.streetNumber,
    Address.suburb,
    Address.province,
    Address.country,
    Address.apartmentNumber
  ]);

  // print(urlPath + phpFileToUse + arguments);
  Map data = (await getURLData(urlPath + phpFileToUse + arguments))[0];

  //If there is an error
  return data["details"];
}

//Manually tested
Future<String> adminRegisterOnline() async {
  //Choosing php file based off whether the user is a client or admin
  String phpFileToUse = insert_admin;
  List<String> phpNames = [
    "firstName",
    "middleName",
    "lastName",
    "age",
    "phoneNum",
    "email",
    "idNum",
    "password",
    "secretKey",
    "currentDate",
    "streetName",
    "streetNum",
    "suburb",
    "province",
    "country",
    "apartmentNum"
  ];
  final String arguments = argumentMaker(phpNames: phpNames, inputVariables: [
    Data.name,
    "",
    Data.surname,
    Data.age.toString(),
    Data.phone,
    Data.email,
    Data.idnum,
    encode(Data.password1).toString(),
    Data.secretKey,
    currentDate(),
    Address.streetName,
    Address.streetNumber,
    Address.suburb,
    Address.province,
    Address.country,
    Address.apartmentNumber
  ]);

  // print(urlPath + phpFileToUse + arguments);
  Map data = (await getURLData(urlPath + phpFileToUse + arguments))[0];

  //If there is an error
  return data["details"];
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
        ], color: Colors.white, borderRadius: BorderRadius.circular(30)),
        child: TextButton(
          onPressed: () {
            if (Data.is_client) {
              if (getCheck() == false) {
                // give error
                Fluttertoast.showToast(
                    msg: "Error with details",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 3,
                    backgroundColor: Colors.teal,
                    textColor: Colors.white,
                    fontSize: 16.0);
              } else {
                // call php for client
                /*@override
                void initState() {
                  clientRegisterOnline().then((value) {
                    Fluttertoast.showToast(
                        msg: value,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 3,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    setState(() {});
                  });
                }*/
                clientRegisterOnline().then((value) {
                  Fluttertoast.showToast(
                      msg: "" + value,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 3,
                      backgroundColor: Colors.teal,
                      textColor: Colors.white,
                      fontSize: 16.0);
                });
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              }
            } else {
              if (getCheck() == false) {
                // give error
                Fluttertoast.showToast(
                    msg: "Error with details",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 3,
                    backgroundColor: Colors.teal,
                    textColor: Colors.white,
                    fontSize: 16.0);
              } else {
                //call php for admin
                adminRegisterOnline().then((value) {
                  Fluttertoast.showToast(
                      msg: "" + value,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 3,
                      backgroundColor: Colors.teal,
                      textColor: Colors.white,
                      fontSize: 16.0);
                });
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              }
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Create Account',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: fontMont,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// coverage:ignore-end
