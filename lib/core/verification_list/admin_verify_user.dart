// coverage:ignore-start
import 'dart:ui';
import 'package:last_national_bank/config/routes/router.dart';
import 'package:last_national_bank/constants/route_constants.dart';
import 'package:last_national_bank/utils/helpers/back_button_helper.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:last_national_bank/utils/helpers/helper.dart';
import 'package:last_national_bank/utils/helpers/style.dart';

import '../../classes/thisUser.dart';
import '../../utils/services/online_db.dart';
import '../registration/widgets/buttonRejectClient.dart';
import '../registration/widgets/buttonVerifyClient.dart';
import 'verification.functions.dart';

class VerifyUser extends StatefulWidget {
  final String IDnum;
  const VerifyUser(this.IDnum);
  @override
  _VerifyUserState createState() => _VerifyUserState();
}

class _VerifyUserState extends State<VerifyUser> {
// late thisUser thisuser;
  List<thisUser> thisuser = [];

  void initState() {
    super.initState();
    //Adding the back button listener
    BackButtonInterceptor.add(myInterceptor);

    // gets the clients details for the admin to view
    getClientDetails(widget.IDnum).then((lstNames) {
      thisuser = lstNames;
      setState(() {});
    });
    // _thisuser = getClient();
    // setState(() {});
  }

  //When the back button is pressed, go to Admin Verification List
  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    return helperInterceptor(
        context: context,
        currentRoute: VerifyUserRoute,
        goTo: goToAdminVerificationList,
        info: info,
        stopDefaultButtonEvent: stopDefaultButtonEvent);
  }

  @override
  void dispose() {
//Removing the back button listener
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  // checks whether the clients details have loaded, and displays loading screen while it is being loaded
  @override
  Widget build(BuildContext context) {
    if (thisuser.isEmpty) {
      getClientDetails(widget.IDnum);
      return buildLoadingScreen(context);
    } else {
      return buildpage();
    }
  }

  /*
  Builds the Admin Verifiy User page, the users list of details show up
  and 2 buttons appear, either accept or reject, once the admin taps on either
  it will either accept or reject the user.
  */
  Widget buildpage() {
    final size = MediaQuery.of(context).size;
    // Name names = ModalRoute.of(context)!.settings.arguments as Name;
    thisUser curruser = thisuser[0];
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: backgroundGradient,
        ),

        // Allows page to be scrollable
        child: SingleChildScrollView(
          padding: new EdgeInsets.only(
            top: 15.0,
            left: 15.0,
            right: 15.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(padding: EdgeInsets.symmetric(vertical: 15)),
              Icon(
                Icons.assignment_ind_rounded,
                color: Colors.white,
                size: 75,
              ),
              Text(
                'Client Information',
                style: new TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),

              DetailedBlocks(curruser.firstName, "FirstName"),

              if (curruser.middleName != null &&
                  curruser.middleName!.trim() != "")
                DetailedBlocks(curruser.middleName!, "Middle Name"),
              DetailedBlocks(curruser.lastName, "LastName"),
              DetailedBlocks(curruser.email, "Email"),
              DetailedBlocks(curruser.idNumber, "ID"),
              DetailedBlocks(curruser.age.toString(), "Age"),
              DetailedBlocks(curruser.phoneNumber, "Phone Number"),

              // Add two verification buttons next to each other
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buttonVerifyClient(() {
                    // verification.functions.dart
                    verificationProcedure(context, curruser.idNumber, true);
                  }),
                  buttonRejectClient(() {
                    // verification.functions.dart
                    verificationProcedure(context, curruser.idNumber, false);
                  }),
                ],
              )
            ],
          ),
        ),
      ),
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
      width: size.width,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: (size.width < tabletWidth)
                ? size.width * 0.8
                : size.width * 0.6,
            padding: EdgeInsets.all(15),
            //padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
            margin: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.transparent,
              // borderRadius: BorderRadius.circular(15),
              border: Border(
                bottom: BorderSide(
                  color: Colors.white,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  property + ':',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontFamily: fontMont,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                // Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                Text(
                  text,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontFamily: fontMont,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// coverage:ignore-end
