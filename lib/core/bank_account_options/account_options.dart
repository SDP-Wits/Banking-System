import 'package:flutter/material.dart';
import 'package:last_national_bank/classes/accountTypes.dart';

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
  var accountTypeList = [];
  var descriptionList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future<List<accountTypes>> bankAccountOptions = getAccTypes();

    bankAccountOptions.then((value) {
      for (int i = 0; i < value.length; ++i) {
        var accType = value[i].accType;
        var accDescription = value[i].accDescription;

        accountTypeList.add(accType);
        descriptionList.add(accDescription);
      }
      setState(() {});
    });
  }

  //fix this

  var accNumbersList = [
    "**** **** **** 4862",
    "**** **** **** 7913",
    "**** **** **** 0258",
    "**** **** **** 9510"
  ];

  //fix this
  var colorsList = [
    Colors.blueAccent[200],
    Colors.blueGrey[200],
    Colors.teal[400],
    Colors.deepPurple[700]
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.6;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bank account options",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 5,
        backgroundColor: Colors.white,
      ),
      body: (accountTypeList.isEmpty)
          ? ListView.builder(
              itemCount: accountTypeList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    ShowDialogFunc(context, accountTypeList[index]);
                  },
                  child: Card(
                      color: colorsList[index],
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(15.0),
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
                                    accNumbersList[index],
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white60,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )),
                );
              })
          : Container(
              child: Text("Page loading"),
            ),
    );
  }
}

ShowDialogFunc(context, accType) {
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
                      FlatButton(
                          onPressed: () {
                            print("yes Button Success");
                          },
                          child: Text("Yes")),
                      FlatButton(
                          onPressed: () {
                            print("no Button Success");
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
