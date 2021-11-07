// coverage:ignore-start
import 'dart:ui';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:last_national_bank/classes/user.class.dart';
import 'package:last_national_bank/config/routes/router.dart';
import 'package:last_national_bank/constants/route_constants.dart';
import 'package:last_national_bank/utils/helpers/helper.dart';
import 'package:last_national_bank/utils/services/local_db.dart';
import 'package:last_national_bank/utils/services/online_db.dart';
import 'package:last_national_bank/widgets/desktopNav.dart';
import 'package:last_national_bank/widgets/heading.dart';
import 'package:last_national_bank/utils/helpers/back_button_helper.dart';
import 'package:last_national_bank/widgets/navigation.dart';
import 'package:last_national_bank/widgets/pendingNav.dart';
import 'package:last_national_bank/classes/thisUser.dart';
import '../registration/widgets/buttonRejectClient.dart';
import '../registration/widgets/buttonVerifyClient.dart';
import 'verification.functions.dart';

import '../../classes/name.class.dart';
import '../../utils/helpers/style.dart';
import '../../utils/services/online_db.dart';
import 'admin_verify_user.dart';

class AdminVerificationListPage extends StatefulWidget {
  @override
  _AdminVerificationListPageState createState() =>
      _AdminVerificationListPageState();
}

class _AdminVerificationListPageState extends State<AdminVerificationListPage> {
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

  List<thisUser> names = [];
  User? user; // User information

  @override
  void initState() {
    super.initState();

    //Adding the back button listener
    BackButtonInterceptor.add(myInterceptor);
    if (kIsWeb) {
      BackButtonInterceptor.removeAll();
    }

    getUnverifiedClients().then((lstNames) {
      names = lstNames;
      setState(() {});
    });

    // Get user details
    LocalDatabaseHelper.instance.getUserAndAddress().then((userDB) {
      setState(() {
        user = userDB;
      });
    });
  }

  //When the back button is pressed, go to Login Page
  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    return helperInterceptor(
        context: context,
        currentRoute: AdminVerificationListRoute,
        goTo: goToLogin,
        info: info,
        stopDefaultButtonEvent: stopDefaultButtonEvent);
  }

  @override
  void dispose() {
    //Removing the back button listener
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  // Displays loading screen while the data loads
  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return buildLoadingScreen(context);
    } else {
      return buildPage(context);
    }
  }

  /*
  Builds the Admin Verification Page, there is a heading,
  and a list of containers with the user name, once you tap on the user
  it will take them to the verify user
  */
  Widget buildPage(BuildContext context) {
    final size = getSize(context);
    if (size.width > tabletWidth) {
      final size = MediaQuery.of(context).size;
      // _scaffoldKey is the key used for the navigation drawer
      GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

      return Scaffold(
          // Set navigation drawer
          key: _scaffoldKey,
          drawer: pendingNav(
              clientName: user!.firstName,
              clientSurname: user!.lastName,
              context: context),
          body: Container(
            decoration: BoxDecoration(
              gradient: backgroundGradient,
            ),

            // Allows page to be scrollable
            child: SingleChildScrollView(
              child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height),
                  child: LayoutBuilder(builder: (context, constraints) {
                    //List
                    return Column(
                      children: [
                        if (MediaQuery.of(context).size.width > tabletWidth)
                          DesktopTabNavigator(
                            isPending: true,
                          ),

                        // Three-line menu bar on the top to open the navigation drawer
                        if (MediaQuery.of(context).size.width <= tabletWidth)
                          Align(
                            alignment: Alignment.topLeft,
                            child: IconButton(
                              icon: Icon(Icons.menu, color: Colors.white),
                              onPressed: () {
                                _scaffoldKey.currentState!.openDrawer();
                              },
                            ),
                          ),

                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Heading("Verify User"),
                        ),
                        (names.length == 0)
                            ? Row(
                                children: [
                                  Expanded(
                                    flex: 3, // 20%
                                    child: Container(color: Colors.transparent),
                                  ),
                                  Expanded(
                                    flex: 3, // 60%
                                    child: Container(
                                      width: size.width,
                                      height: size.height,
                                      child: Center(
                                        child: Text(
                                          "No Users to Verify",
                                          style: TextStyle(
                                            fontFamily: fontMont,
                                            fontSize: 30,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3, // 20%
                                    child: Container(color: Colors.transparent),
                                  )
                                ],
                              )
                            : Row(
                                children: [
                                  Expanded(
                                    flex: 1, // 20%
                                    child: Container(color: Colors.transparent),
                                  ),
                                  Expanded(
                                    flex: 10, // 60%
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: ScrollPhysics(),
                                        itemCount: names.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          String
                                              textToUse = /*"\t\t*/ " ${names[index].firstName} "; //had to comment out /t/t since its converted to square boxes on the web version
                                          if (names[index].middleName != null) {
                                            textToUse +=
                                                names[index].middleName!;
                                            textToUse += " ";
                                          }
                                          textToUse += names[index].lastName;
                                          textToUse = "Name: " + textToUse;
                                          String Age = "Age: " +
                                              (names[index].age).toString();
                                          String ph = "Phone No.: " +
                                              (names[index].phoneNumber)
                                                  .toString();
                                          String id = "ID No.: " +
                                              (names[index].idNumber)
                                                  .toString();
                                          String v = "verificationStatus: " +
                                              (names[index].status).toString();
                                          String e = "Email: " +
                                              (names[index].email).toString();

                                          return Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.symmetric(
                                                vertical: 10),
                                            decoration: BoxDecoration(
                                              color: Colors.black26,
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: InkWell(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                padding: EdgeInsets.all(15),
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            Text(
                                                              textToUse,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      fontSizeSmall,
                                                                  color: Colors
                                                                      .white,
                                                                  fontFamily:
                                                                      fontMont),
                                                            ),
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            15)),
                                                            Text(
                                                              id,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      fontSizeSmall,
                                                                  color: Colors
                                                                      .white,
                                                                  fontFamily:
                                                                      fontMont),
                                                            ),
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            15)),
                                                            Text(
                                                              e,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              softWrap: true,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      fontSizeSmall,
                                                                  color: Colors
                                                                      .white,
                                                                  fontFamily:
                                                                      fontMont),
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          children: [
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            25)),
                                                          ],
                                                        ),
                                                        Column(
                                                          children: [
                                                            Text(
                                                              Age,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      fontSizeSmall,
                                                                  color: Colors
                                                                      .white,
                                                                  fontFamily:
                                                                      fontMont),
                                                            ),
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            15)),
                                                            Text(
                                                              ph,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      fontSizeSmall,
                                                                  color: Colors
                                                                      .white,
                                                                  fontFamily:
                                                                      fontMont),
                                                            ),
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            15)),
                                                            Text(
                                                              v,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      fontSizeSmall,
                                                                  color: Colors
                                                                      .white,
                                                                  fontFamily:
                                                                      fontMont),
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          children: [
                                                            Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            25)),
                                                          ],
                                                        ),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            buttonVerifyClient(
                                                                () {
                                                              // verification.functions.dart
                                                              verificationProcedure(
                                                                      context,
                                                                      names[index]
                                                                          .idNumber,
                                                                      true,
                                                                      fromVerifyUser:
                                                                          false)
                                                                  .then(
                                                                      (value) {
                                                                setState(() {
                                                                  names.removeAt(
                                                                      index);

                                                                  names = [
                                                                    ...names
                                                                  ];
                                                                });
                                                              });
                                                            }),
                                                            buttonRejectClient(
                                                                () {
                                                              // verification.functions.dart
                                                              verificationProcedure(
                                                                      context,
                                                                      names[index]
                                                                          .idNumber,
                                                                      false,
                                                                      fromVerifyUser:
                                                                          false)
                                                                  .then(
                                                                      (value) {
                                                                setState(() {
                                                                  names.removeAt(
                                                                      index);
                                                                  names = [
                                                                    ...names
                                                                  ];
                                                                });
                                                              });
                                                            }),
                                                          ],
                                                        ),
                                                      ]),
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                  Expanded(
                                    flex: 1, // 20%
                                    child: Container(color: Colors.transparent),
                                  )
                                ],
                              )
                      ],
                    );
                  })),
            ),
          ));
    } else {
      final size = MediaQuery.of(context).size;
      // _scaffoldKey is the key used for the navigation drawer
      GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

      return Scaffold(
          // Set navigation drawer
          key: _scaffoldKey,
          drawer: pendingNav(
              clientName: user!.firstName,
              clientSurname: user!.lastName,
              context: context),
          body: Container(
            decoration: BoxDecoration(
              gradient: backgroundGradient,
            ),

            // Allows page to be scrollable
            child: SingleChildScrollView(
              child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height),
                  child: LayoutBuilder(builder: (context, constraints) {
                    //List
                    return Column(
                      children: [
                        if (MediaQuery.of(context).size.width > tabletWidth)
                          DesktopTabNavigator(
                            isPending: true,
                          ),

                        // Three-line menu bar on the top to open the navigation drawer
                        if (MediaQuery.of(context).size.width <= tabletWidth)
                          Align(
                            alignment: Alignment.topLeft,
                            child: IconButton(
                              icon: Icon(Icons.menu, color: Colors.white),
                              onPressed: () {
                                _scaffoldKey.currentState!.openDrawer();
                              },
                            ),
                          ),

                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Heading("Verify Users"),
                        ),
                        (names.length == 0)
                            ? Row(
                                children: [
                                  Expanded(
                                    flex: 3, // 20%
                                    child: Container(color: Colors.transparent),
                                  ),
                                  Expanded(
                                    flex: 3, // 60%
                                    child: Container(
                                      width: size.width,
                                      height: size.height,
                                      child: Center(
                                        child: Text(
                                          "No Users to Verify",
                                          style: TextStyle(
                                            fontFamily: fontMont,
                                            fontSize: 30,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3, // 20%
                                    child: Container(color: Colors.transparent),
                                  )
                                ],
                              )
                            : Row(
                                children: [
                                  Expanded(
                                    flex: 3, // 20%
                                    child: Container(color: Colors.transparent),
                                  ),
                                  Expanded(
                                    flex: 3, // 60%
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: ScrollPhysics(),
                                        itemCount: names.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          String
                                              textToUse = /*"\t\t*/ " ${names[index].firstName} "; //had to comment out /t/t since its converted to square boxes on the web version
                                          if (names[index].middleName != null) {
                                            textToUse +=
                                                names[index].middleName!;
                                            textToUse += " ";
                                          }
                                          textToUse += names[index].lastName;

                                          return Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 10),
                                            decoration: BoxDecoration(
                                              color: Colors.black26,
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: InkWell(
                                              // When user clicks on item box, sonmething happens:
                                              // customBorder: Border.all(color: Colors.white, width: 2),
                                              onTap: () {
                                                goToVerifyUser(
                                                    context: context,
                                                    idNumber:
                                                        names[index].idNumber);
                                              },

                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                padding: EdgeInsets.all(15),
                                                child: Text(
                                                  // names i sthe name of the example array used above
                                                  // Will need to find outy how to use array in
                                                  // verification.functions.dart here
                                                  textToUse,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: fontSizeSmall,
                                                      color: Colors.white,
                                                      fontFamily: fontMont),
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                  Expanded(
                                    flex: 3, // 20%
                                    child: Container(color: Colors.transparent),
                                  )
                                ],
                              )
                      ],
                    );
                  })),
            ),
          ));
    }
  }
}

Widget buildcont(BuildContext ctxt, String index) {
  return new Text(index);
}

// coverage:ignore-end
//==================================================================
