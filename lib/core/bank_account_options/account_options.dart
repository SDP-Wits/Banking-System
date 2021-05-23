import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:last_national_bank/utils/services/online_db.dart';
import 'package:last_national_bank/widgets/navigation.dart';

import '../../classes/user.class.dart';
import '../../config/routes/router.dart';
import '../../constants/database_constants.dart';
import '../../utils/services/local_db.dart';
import '../../utils/services/online_db.dart';

/// This is the main application widget.
class AccountOptionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: BankAccountOptions());
  }
}

class BankAccountOptions extends StatefulWidget {
  @override
  _BankAccountOptionsState createState() => _BankAccountOptionsState();
}

class _BankAccountOptionsState extends State<BankAccountOptions> {
  List<String> accountTypeList = [];
  List<String> descriptionList = [];
  List<int> accountTypeIdList = [];
  List<int> existingAccountTypes = [];

//  List<String> accNumbersList = [];

  @override
  void initState() {
    super.initState();

    getAccountTypes().then((value) {
      for (int i = 0; i < value.length; ++i) {
        String accType = value[i].accType;
        String accDescription = value[i].accDescription;
        int accTypeId = value[i].accountTypeId;

        accountTypeIdList = [...accountTypeIdList, accTypeId];
        accountTypeList = [...accountTypeList, accType];
        descriptionList = [...descriptionList, accDescription];
//        accNumbersList = [...accNumbersList, "**** **** **** 95${i}0"];
      }

      setState(() {
        accountTypeIdList = [...accountTypeIdList];
        accountTypeList = [...accountTypeList];
        descriptionList = [...descriptionList];
//        accNumbersList = [...accNumbersList];
      });
    });

    getExistingAccountTypes().then((value) {
      for (int i = 0; i < value.length; ++i) {
        int eID = value[i];
        existingAccountTypes = [...existingAccountTypes, eID];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.6;

    existingAccountTypes.sort();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bank Account Options",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 5,
        backgroundColor: Colors.white,
      ),
      body: (accountTypeList.isNotEmpty)
          ? ListView.builder(
              itemCount: accountTypeList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () async {
                      if (existingAccountTypes.contains(index + 1)) {
                        Fluttertoast.showToast(
                            msg:
                                "An account of this type already exists. Restriction: Only one of each type of account allowed.",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 3,
                            fontSize: 16.0);
                      } else {
                        await _asyncConfirmDialog(context,
                            accountTypeIdList[index], accountTypeList[index]);
                      }
                    },
                    child: Card(
                      child: Container(
                          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.teal,
                              Colors.teal[800]!,
                            ],
                          )),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      accountTypeList[index],
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: width,
                                      child: Text(
                                        descriptionList[index],
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white60,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )),
                    ));
              })
          : _buildLoadingScreen(),
    );
  }
}

ShowDialogFunc(BuildContext context, int accTypeId, String accType) {
  return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width * 0.8,
              height: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Are you sure you want to create a  " +
                      accType +
                      "  account?"),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                          onPressed: () {
                            User? user;

                            // Using getUserAndAddress() from Local DB to get current admin user's idNumber
                            LocalDatabaseHelper.instance
                                .getUserAndAddress()
                                .then((currUser) async {
                              user = currUser;

                              String response = await createAccount(
                                  user!.idNumber, accTypeId);

                              if (response == dbSuccess) {
                                // Create 'Showmessage'
                                Fluttertoast.showToast(
                                    msg: "Succesful",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 3,
                                    backgroundColor: Colors.teal,
                                    textColor: Colors.white,
                                    fontSize: 16.0);

                                goToAdminVerificationStatus(context);
                              } else {
                                // Create 'Showmessage'
                                Fluttertoast.showToast(
                                    msg: response,
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 3,
                                    backgroundColor: Colors.teal,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                            });
                          },
                          child: Text("Yes")),
                      TextButton(
                          onPressed: () {
                            print("Cancelled account creation");
                            Fluttertoast.showToast(msg: "Cancelled");
                          },
                          child: Text("No")),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      });
}

Future<void> _asyncConfirmDialog(
    BuildContext context, int accTypeId, String accType) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Confirm account creation'),
        content: Text(
            "Are you sure you want to create a  " + accType + "  account?"),
        actions: <Widget>[
          FlatButton(
            child: const Text('Cancel'),
            onPressed: () {
              print("Cancelled account creation");
              Fluttertoast.showToast(msg: "Cancelled");
            },
          ),
          FlatButton(
            child: const Text('Confirm'),
            onPressed: () {
              User? user;

              // Using getUserAndAddress() from Local DB to get current admin user's idNumber
              LocalDatabaseHelper.instance
                  .getUserAndAddress()
                  .then((currUser) async {
                user = currUser;

                String response =
                    await createAccount(user!.idNumber, accTypeId);

                if (response == dbSuccess) {
                  // Create 'Showmessage'
                  Fluttertoast.showToast(
                      msg: "Succesful",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 3,
                      backgroundColor: Colors.teal,
                      textColor: Colors.white,
                      fontSize: 16.0);

                  goToAdminVerificationStatus(context);
                } else {
                  // Create 'Showmessage'
                  Fluttertoast.showToast(
                      msg: response,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 3,
                      backgroundColor: Colors.teal,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              });
            },
          )
        ],
      );
    },
  );
}

Widget _buildLoadingScreen() {
  return Center(
    child: Container(
      // decoration: BoxDecoration(
      //   gradient: LinearGradient(
      //       begin: Alignment.topRight,
      //       end: Alignment.bottomLeft,
      //       colors: [Colors.blueGrey, Colors.teal]),
      // ),
      width: 50,
      height: 50,
      child: CircularProgressIndicator(),
    ),
  );
}
