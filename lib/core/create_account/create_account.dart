// coverage:ignore-start
import 'package:last_national_bank/utils/helpers/back_button_helper.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:last_national_bank/constants/php_url.dart';
import 'package:last_national_bank/constants/route_constants.dart';
import 'package:last_national_bank/utils/helpers/style.dart';
import 'package:last_national_bank/widgets/desktopNav.dart';
import 'package:last_national_bank/widgets/heading.dart';
import '../../classes/user.class.dart';
import '../../config/routes/router.dart';
import '../../constants/database_constants.dart';
import '../../utils/services/local_db.dart';
import '../../utils/services/online_db.dart';
import '../../widgets/navigation.dart';

/// This is the main application widget.
class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  List<String> accountTypeList = [];
  List<String> descriptionList = [];
  List<int> accountTypeIdList = [];
  List<int> existingAccountTypes = [];

  User? user = null;

//  List<String> accNumbersList = [];

  @override
  void initState() {
    super.initState();

    BackButtonInterceptor.add(myInterceptor);

    // get IDs of existing account types for specific user
    LocalDatabaseHelper.instance.getUserAndAddress().then((user) {
      setState(() {
        this.user = user;
      });
      getExistingAccountTypes(user!.userID).then((value) {
        for (int i = 0; i < value.length; ++i) {
          int eID = value[i];
          setState(() {
            existingAccountTypes = [...existingAccountTypes, eID];
          });
        }

        //get data, extract and put it into lists to use later on
        getAccountTypes().then((value) {
          for (int i = 0; i < value.length; ++i) {
            String accType = value[i].accType;
            String accDescription = value[i].accDescription;
            int accTypeId = value[i].accountTypeId;

            accountTypeIdList = [...accountTypeIdList, accTypeId];
            accountTypeList = [...accountTypeList, accType];
            descriptionList = [...descriptionList, accDescription];
          }

          setState(() {
            accountTypeIdList = [...accountTypeIdList];
            accountTypeList = [...accountTypeList];
            descriptionList = [...descriptionList];
          });
        });
      });
    });
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    return helperInterceptor(
        context: context,
        currentRoute: CreateAccountRoute,
        goTo: goToViewAccount,
        info: info,
        stopDefaultButtonEvent: stopDefaultButtonEvent);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.6;

    existingAccountTypes.sort();

    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final size = MediaQuery.of(context).size;
    return (user == null || accountTypeIdList.isEmpty)
        ? buildLoadingScreen(context)
        : Scaffold(
            key: _scaffoldKey,
            drawer: Navigation(
                clientName: user!.firstName,
                clientSurname: user!.lastName,
                context: context),
            body: (accountTypeList.isNotEmpty)
                ? Container(
                    height: size.height,
                    decoration: BoxDecoration(
                      gradient: backgroundGradient,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          if (MediaQuery.of(context).size.width > tabletWidth)
                            DesktopTabNavigator(),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: accountTypeList.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    if (index == 0)
                                      Column(
                                        children: [
                                          if (MediaQuery.of(context)
                                                  .size
                                                  .width <=
                                              tabletWidth)
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: IconButton(
                                                icon: Icon(Icons.menu,
                                                    color: Colors.white),
                                                onPressed: () {
                                                  _scaffoldKey.currentState!
                                                      .openDrawer();
                                                },
                                              ),
                                            ),
                                          Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5)),
                                          Heading("Create Account"),
                                          Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 15)),
                                        ],
                                      ),
                                    GestureDetector(
                                        onTap: () async {
                                          //check if account type id exists in existing account type list
                                          if (existingAccountTypes.contains(
                                              accountTypeIdList[index])) {
                                            // display toast to restrict user
                                            Fluttertoast.showToast(
                                                msg:
                                                    "An account of this type already exists. Restriction: Only one of each type of account allowed.",
                                                toastLength: Toast.LENGTH_LONG,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 3,
                                                fontSize: 16.0);
                                          } else {
                                            // confirm creation of selected account
                                            await _asyncConfirmDialog(
                                                context,
                                                accountTypeIdList[index],
                                                accountTypeList[index]);
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: Container(
                                            width: (size.width <= phoneWidth)
                                                ? size.width * 0.95
                                                : size.width * 0.7,
                                            padding: (size.width >= tabletWidth)
                                                ? EdgeInsets.only(top: 45)
                                                : null,
                                            child: Card(
                                              color: Colors.white,
                                              child: Container(
                                                  margin:
                                                      const EdgeInsets.all(10),
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
                                                        padding:
                                                            const EdgeInsets
                                                                .all(20.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Text(
                                                              accountTypeList[
                                                                  index],
                                                              style: TextStyle(
                                                                fontSize: 20,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    fontMont,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Container(
                                                              width: width,
                                                              child: Text(
                                                                descriptionList[
                                                                    index],
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    color: Colors
                                                                        .white70,
                                                                    fontFamily:
                                                                        fontMont,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  )),
                                            ),
                                          ),
                                        )),
                                  ],
                                );
                              }),
                        ],
                      ),
                    ),
                  )
                : buildLoadingScreen(context),
          );
  }
}

Future<void> _asyncConfirmDialog(
    BuildContext context, int accTypeId, String accType) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Confirm account creation'),
        content:
            Text("Are you sure you want to create a " + accType + " account?"),
        actions: <Widget>[
          FlatButton(
            child: const Text('Cancel'),
            onPressed: () {
              print("Cancelled account creation");
              Fluttertoast.showToast(msg: "Cancelled");
              Navigator.pop(context);
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

                String response = await createAccount(
                    user!.idNumber, accTypeId, insert_new_account);

                Fluttertoast.showToast(
                    msg: response,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 3,
                    backgroundColor: Colors.teal,
                    textColor: Colors.white,
                    fontSize: 16.0);

                if (response == dbSuccess) {
                  goToViewAccount(context);
                }
              });
            },
          )
        ],
      );
    },
  );
}
// coverage:ignore-end
