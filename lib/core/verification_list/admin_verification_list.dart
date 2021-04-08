//-import 'package:flutter/material.dart';
/*import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//import 'package:last_national_bank/core/verification_list/verification.functions.dart';
import 'package:last_national_bank/utils/helpers/style.dart';
import 'package:last_national_bank/widgets/verifyUsersTitle.dart';
import 'package:last_national_bank/constants/php_url.dart';

import '../../utils/helpers/style.dart';
import '../../widgets/verifyUsersTitle.dart';
@ -9,10 +15,43 @@ class VerificationListPage extends StatefulWidget {
  _VerificationListPageState createState() => _VerificationListPageState();
}

/*class User {
  final String fName;
  final String mName;
  final String sName;

  User({
    required this.fName,
    required this.mName,
    required this.sName,
  });
}*/

/*Future<List<User>> selectUnverifiedClients() async {
  //replace your restFull API here.
  Uri url = (urlPath + select_unverified_client_names) as Uri;
  final response = await http.get(url);

  var responseData = json.decode(response.body);

  //Creating a list to store input data;
  List<User> users = [];
  for (var singleUser in responseData) {
    User user = User(
        fName: singleUser["firstName"],
        mName: singleUser["middleName"],
        sName: singleUser["lastName"]);

    //Adding user to the list.
    users.add(user);
  }
  return users;
}*/

class _VerificationListPageState extends State<VerificationListPage> {
  //==================================================================
  //Example data:
  List<VerificationListClass> names = [
  /*List<VerificationListClass> names = [
    VerificationListClass(name: 'Joe Biden', id: '0664652652'),
    VerificationListClass(name: 'Mary Gilbert', id: '0664652652'),
    VerificationListClass(name: 'Bob Stan', id: '0664652652'),
@ -24,8 +63,33 @@ class _VerificationListPageState extends State<VerificationListPage> {
    VerificationListClass(name: 'Moe Timber', id: '0664652652'),
    VerificationListClass(name: 'Tristan Steel', id: '0664652652'),
    VerificationListClass(name: 'Seshlin Mike', id: '0664652652')
  ];
  ];*/
  //==================================================================
  //
  //
  //Future<List<User>> selectUnverifiedClients() async {
  //replace your restFull API here.
  //
  /*Future<List<User>> selectUnverifiedClients() async {
    //replace your restFull API here.
    Uri url = (urlPath + select_unverified_client_names) as Uri;
    final response = await http.get(url);

    var responseData = json.decode(response.body);

    //Creating a list to store input data;
    List<User> users = [];
    for (var singleUser in responseData) {
      User user = User(
          fName: singleUser["firstName"],
          mName: singleUser["middleName"],
          sName: singleUser["lastName"]);

      //Adding user to the list.
      users.add(user);
    }
    return users;
  }*/

  @override
  Widget build(BuildContext context) {
@ -56,7 +120,167 @@ class _VerificationListPageState extends State<VerificationListPage> {
                ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: names.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        color: Colors.transparent,
                        elevation: 2,
                        // Space around item box
                        margin: EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 10),

                        child: InkWell(
                          // When user clicks on item box, sonmething happens:
                          onTap: () {},

                          child: Container(
                            padding: EdgeInsets.all(15),
                            /*child: FutureBuilder(
                              future: selectUnverifiedClients(),
                              builder:
                                  (BuildContext ctx, AsyncSnapshot snapshot) {
                                if (snapshot.data == null) {
                                  return Container(
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                } else {
                                  return ListView.builder(
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (ctx, index) => ListTile(
                                      title: Text(snapshot.data[index].title),
                                      subtitle: Text(snapshot.data[index].body),
                                      contentPadding:
                                          EdgeInsets.only(bottom: 20.0),
                                    ),
                                  );
                                }
                              },
                            ),*/
                          ),
                        ),
                      );
                    }),
              ],
            ),
          ),
        ));
  }
}/**/ */

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:last_national_bank/constants/php_url.dart';
import 'package:last_national_bank/core/registration/registration.functions.dart';
import '../../utils/helpers/style.dart';
import '../../widgets/verifyUsersTitle.dart';
import 'package:fluttertoast/fluttertoast.dart';

class User {
  final String fName;
  final String mName;
  final String sName;

  User({
    required this.fName,
    required this.mName,
    required this.sName,
  });
}

class VerificationListPage extends StatefulWidget {
  @override
  _VerificationListPageState createState() => _VerificationListPageState();
}

class _VerificationListPageState extends State<VerificationListPage> {
  //==================================================================
  //Example data:
  /*List<VerificationListClass> names = [
    VerificationListClass(name: 'Joe Biden', id: '0664652652'),
    VerificationListClass(name: 'Mary Gilbert', id: '0664652652'),
    VerificationListClass(name: 'Bob Stan', id: '0664652652'),
    VerificationListClass(name: 'Lisa Monroe', id: '0664652652'),
    VerificationListClass(name: 'Noah Arc', id: '0664652652'),
    VerificationListClass(name: 'Kiara Sweets', id: '0664652652'),
    VerificationListClass(name: 'Kerina Bennet', id: '0664652652'),
    VerificationListClass(name: 'Arneev Draco', id: '0664652652'),
    VerificationListClass(name: 'Moe Timber', id: '0664652652'),
    VerificationListClass(name: 'Tristan Steel', id: '0664652652'),
    VerificationListClass(name: 'Seshlin Mike', id: '0664652652')
  ];*/

  Future<List<User>> getURLData() async {
    Fluttertoast.showToast(msg: "Helolosdjknjsd");
    String url = urlPath + select_unverified_client_names;
    Fluttertoast.showToast(msg: url);

    final Uri uri = Uri.parse(url);

    final httpResponse = await http.get(uri);

    final jsonOutput = json.decode(httpResponse.body);

    List<User> name = [];
    for (var singleUser in jsonOutput) {
      User user = User(
          fName: singleUser["firstName"],
          mName: singleUser["middleName"],
          sName: singleUser["lastName"]);

      //Adding user to the list.
      name.add(user);
    }
    return name;
  }

  List<User> names = [];

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    //names.add(getURLData());
    getURLData().then((value) {
      names = value;
      setState(() {});
      Fluttertoast.showToast(msg: "Helolosdjknjsd");
    });
    //names = await  getURLData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blueGrey, Colors.lightBlueAccent]),
        ),

        // Allows page to be scrollable
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: ConstrainedBox(
            //Use MediaQuery.of(context).size.height for max Height
            constraints:
                BoxConstraints(minHeight: MediaQuery.of(context).size.height),

            child: Column(
              children: <Widget>[
                // Title/heading
                Row(children: <Widget>[
                  VerifyUsersTitle(),
                ]),

                // List
                ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: names.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        color: Colors.transparent,
                        elevation: 2,
                        // Space around item box
                        margin: EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 10),

                        child: InkWell(
                          // When user clicks on item box, sonmething happens:
                          onTap: () {},

                          child: Container(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              // names i sthe name of the example array used above
                              // Will need to find outy how to use array in
                              // verification.functions.dart here
                              "\t\t" +
                                  names[index].fName +
                                  ": " +
                                  names[index].mName +
                                  ": " +
                                  names[index].sName,
                              style: TextStyle(fontSize: fontSizeSmall),
                            ),
                          ),
                        ),
                      );
                    }),
              ],
            ),
          ),
        ));
  }
}
//==================================================================

//@override
/*Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(url1),
          leading: Icon(
            Icons.get_app,
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: FutureBuilder(
            future: selectUnverifiedClients(),
            builder: (BuildContext ctx, AsyncSnapshot snapshot) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (ctx, index) => ListTile(
                  title: Text(snapshot.data[index].fNmae),
                  subtitle: Text(snapshot.data[index].sName),
                  contentPadding: EdgeInsets.only(bottom: 20.0),
                ),
              );
            },
          ),
        ),
      ),
    );
  }*/
