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
  return (await insertClient(
    firstName: Data.name,
    middleName: "",
    lastName: Data.surname,
    age: Data.age.toString(),
    phoneNum: Data.phone,
    email: Data.email,
    idNum: Data.idnum,
    password: encode(Data.password1).toString(),
    streetName: Address.streetName,
    streetNum: Address.streetNumber,
    suburb: Address.suburb,
    province: Address.province,
    country: Address.country,
    apartmentNum: Address.apartmentNumber,
  ));
}

//Manually tested
Future<String> adminRegisterOnline() async {
  return (await insertAdmin(
      firstName: Data.name,
      middleName: "",
      lastName: Data.surname,
      age: Data.age.toString(),
      phoneNum: Data.phone,
      email: Data.email,
      idNum: Data.idnum,
      password: encode(Data.password1).toString(),
      secretKey: Data.secretKey,
      currentDate: currentDate(),
      streetName: Address.streetName,
      streetNum: Address.streetNumber,
      suburb: Address.suburb,
      province: Address.province,
      country: Address.country,
      apartmentNum: Address.apartmentNumber));
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
