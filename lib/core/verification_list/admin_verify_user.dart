// coverage:ignore-start
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:last_national_bank/utils/helpers/style.dart';

import '../../classes/thisUser.dart';
import '../../utils/services/online_db.dart';
import '../../widgets/buttonRejectClient.dart';
import '../../widgets/buttonVerifyClient.dart';
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
    getClientDetails(widget.IDnum).then((lstNames) {
      thisuser = lstNames;
      setState(() {});
    });
    // _thisuser = getClient();
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (thisuser.isEmpty) {
      getClientDetails(widget.IDnum);
      return buildLoadingScreen();
    } else {
      return buildpage();
    }
  }

  Widget buildpage() {
    // Name names = ModalRoute.of(context)!.settings.arguments as Name;
    thisUser curruser = thisuser[0];
    return Scaffold(
      body: Container(
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
            mainAxisAlignment: MainAxisAlignment.start,
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
              (curruser.middleName != null || curruser.middleName!.trim() == "")
                  ? DetailedBlocks(curruser.middleName!, "Middle Name")
                  : Container(),
              DetailedBlocks(curruser.lastName, "LastName"),
              DetailedBlocks(curruser.email, "Email"),
              DetailedBlocks(curruser.idNumber, "ID"),
              DetailedBlocks(curruser.age.toString(), "Age"),
              DetailedBlocks(curruser.phoneNumber, "Phone Number"),

              // Add two verification buttons next to each other
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    // Accept Client
                    buttonVerifyClient(() {
                      // verification.functions.dart
                      verificationProcedure(context, curruser.idNumber, true);
                    }),

                    // Reject Client
                    buttonRejectClient(() {
                      // verification.functions.dart
                      verificationProcedure(context, curruser.idNumber, false);
                    }),
                  ])
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
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
        )
      ],
    );
  }
}

// coverage:ignore-end
