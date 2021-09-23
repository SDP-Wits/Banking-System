// coverage:ignore-start
import 'dart:io';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:last_national_bank/config/routes/router.helper.dart';
import 'package:last_national_bank/constants/route_constants.dart';
import 'package:last_national_bank/core/registration/widgets/subHeading.dart';
import 'package:last_national_bank/core/registration/widgets/subsubHeading.dart';
import 'package:last_national_bank/utils/helpers/helper.dart';
import 'package:last_national_bank/utils/helpers/style.dart';
import 'package:last_national_bank/widgets/desktopNav.dart';
import 'package:last_national_bank/widgets/deviceLayout.dart';
import 'package:last_national_bank/widgets/heading.dart';
import 'package:last_national_bank/widgets/pendingNav.dart';

import '../../classes/thisUser.dart';
import '../../classes/user.class.dart';
import '../../utils/services/local_db.dart';
import '../../utils/services/online_db.dart';
import '../../widgets/navigation.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User? user;
  List<thisUser>? me = null;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    //Adding the back button listener
    BackButtonInterceptor.add(myInterceptor);
    if (kIsWeb) {
      BackButtonInterceptor.removeAll();
    }

    LocalDatabaseHelper.instance.getUserAndAddress().then((currUser) {
      setState(() {
        user = currUser;
      });
      // used the client ID number from the local database, to get the rest of the clients details from the online database
      getClientDetails(user!.idNumber).then((stat) {
        setState(() {
          me = stat;
        });
      });
      if (user == null) {
        LocalDatabaseHelper.instance.deleteData();
        Navigator.pop(context);
      }
    });
  }

  //When the back button is pressed, exit the app
  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    if (info.currentRoute(context)!.settings.name ==
        getCurrentRouteName(context)) {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    }

    return false;
  }

  @override
  void dispose() {
    //Removing the back button listener
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  /*
  checks whether the database contents were loaded,
  and displays a loading screen while the data is extracted
  */
  @override
  Widget build(BuildContext context) {
    if (me == null) {
      return buildLoadingScreen(context);
    } else {
      return buildPage();
    }
  }

  Widget buildPage() {
    return DeviceLayout(
      phoneLayout: phoneLayout(context),
      desktopWidget: desktopLayout(context),
    );
  }

  Widget desktopLayout(BuildContext context) {
    final size = getSize(context);
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        height: size.height,
        child: SingleChildScrollView(
          child: Container(
            height: size.height,
            child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  (me![0].status != "Pending")
                      ? DesktopTabNavigator()
                      : DesktopTabNavigator(
                          isPending: true,
                        ),
                  Container(
                    // height: size.height / 2,
                    width: size.width * 1.1,
                    padding: EdgeInsets.symmetric(vertical: 30),
                    decoration: BoxDecoration(
                      gradient: backgroundGradient,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25.0),
                        bottomRight: Radius.circular(25.0),
                        // topRight: borderRadius,
                      ),
                    ),
                    child: Column(
                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
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

                          Heading("My Profile"),

                          // Spacing
                          Padding(
                            padding: EdgeInsets.only(top: 30),
                          ),

                          Icon(
                            Icons.account_circle,
                            size: 100,
                          ),

                          subHeading(user!.firstName + " " + user!.lastName),
                          // Spacing
                          Padding(
                            padding: EdgeInsets.only(top: 15),
                          ),
                          subsubHeading(user!.idNumber),
                        ]),
                  ),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          DetailedBlocks(me![0].status, "Verification Status"),
                          DetailedBlocks(user!.email, "Email Address"),
                        ],
                      ),
                      // Spacing

                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            DetailedBlocks(user!.phoneNumber, "Phone Number"),
                            DetailedBlocks(
                                user!.address.streetNumber.toString() +
                                    " " +
                                    user!.address.streetName +
                                    ", " +
                                    user!.address.suburb,
                                "Address"),
                          ]),
                    ],
                  )),
                ]),
          ),
        ),
      ),
    );
  }

  Widget phoneLayout(BuildContext context) {
    final size = getSize(context);
    return Row(
      children: [
        Expanded(
          flex: 1, // 20%
          child: Container(color: Colors.transparent),
        ),
        Expanded(
            flex: 500, // 60%
            child: Scaffold(
              key: _scaffoldKey,
              drawer: (me![0].status != "Pending")
                  ? Navigation(
                      clientName: user!.firstName,
                      clientSurname: user!.lastName,
                      context: context)
                  : pendingNav(
                      clientName: user!.firstName,
                      clientSurname: user!.lastName,
                      context: context),
              body: SingleChildScrollView(
                child: Container(
                  //height: size.height * 1.1,
                  child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          //height: size.height / 2,
                          decoration: BoxDecoration(
                            gradient: backgroundGradient,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(25.0),
                              bottomRight: Radius.circular(25.0),
                              // topRight: borderRadius,
                            ),
                          ),
                          child: Column(
                              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: IconButton(
                                    icon: Icon(Icons.menu, color: Colors.white),
                                    onPressed: () {
                                      _scaffoldKey.currentState!.openDrawer();
                                    },
                                  ),
                                ),

                                Heading("My Profile"),

                                // Spacing
                                Padding(
                                  padding: EdgeInsets.only(top: 30),
                                ),

                                Icon(
                                  Icons.account_circle,
                                  size: 100,
                                ),

                                subHeading(
                                    user!.firstName + " " + user!.lastName),
                                // Spacing
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                ),
                                subsubHeading(user!.idNumber),
                              ]),
                        ),

                        // Spacing
                        Padding(
                          padding: EdgeInsets.only(top: 40),
                        ),

                        DetailedBlocks(me![0].status, "Verification Status"),
                        // Spacing
                        Padding(
                          padding: EdgeInsets.only(top: 30),
                        ),
                        DetailedBlocks(user!.email, "Email Address"),
                        Padding(
                          padding: EdgeInsets.only(top: 30),
                        ),
                        DetailedBlocks(user!.phoneNumber, "Phone Number"),
                        Padding(
                          padding: EdgeInsets.only(top: 30),
                        ),
                        DetailedBlocks(
                            user!.address.streetNumber.toString() +
                                " " +
                                user!.address.streetName +
                                ", " +
                                user!.address.suburb,
                            "Address"),
                      ]),
                ),
              ),
            )),
        Expanded(
          flex: 1, // 20%
          child: Container(color: Colors.transparent),
        )
      ],
    );
  }
}

class DetailedBlocks extends StatelessWidget {
  final String property;
  final String text;
  DetailedBlocks(this.text, this.property);

  @override
  Widget build(BuildContext context) {
    final size = getSize(context);
    return Container(
        width:
            (size.width <= tabletWidth) ? size.width * 0.9 : size.width * 0.4,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(
            bottom: BorderSide(
              color: Colors.black,
              width: 0.5,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              property,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.teal,
                  fontFamily: fontMont,
                  fontWeight: FontWeight.w600),
            ),

            // Spacing
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),

            Text(
              text,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontFamily: fontMont,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ));
  }
}

// coverage:ignore-end
