import 'dart:ui';

import 'package:flutter/material.dart';

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

// Future<thisUser> getClient() async{
//   return getClientDetails(widget.IDnum);
// }
// Future<String> print() async{
//   await Future.delayed(Duration(seconds: 2));
//   return thisuser[0].firstName;
// }
  void initState() {
    super.initState();
    getClientDetails(widget.IDnum).then((lstNames) {
      thisuser = lstNames;
      setState(() {});
    });
    // _thisuser = getClient();
    // setState(() {});
  }

  // @override
  // Widget build(BuildContext context) {
  //   return FutureBuilder<thisUser>(
  //     future: getClient(),
  //     builder: (ctx, snapshot) {
  //       thisUser thisuser = snapshot.data! ;
  //       switch (snapshot.connectionState) {
  //         case ConnectionState.done:
  //            return _buildpage(thisuser);
  //         default:
  //           return _buildLoadingScreen();
  //       }
  //     },
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    if (thisuser.isEmpty) {
      getClientDetails(widget.IDnum);
      return _buildLoadingScreen();
    } else {
      return buildpage();
    }
  }

  Widget buildpage() {
    // Name names = ModalRoute.of(context)!.settings.arguments as Name;
    thisUser curruser = thisuser[0];
    return Scaffold(
      appBar: new PreferredSize(
        child: Container(
          padding: new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: new Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 30.0, top: 5.0, bottom: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Client Verification',
                  style: new TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                IconButton(
                  icon: const Icon(Icons.admin_panel_settings_rounded),
                  iconSize: 30.0,
                  color: Colors.white,
                  tooltip: 'Verification Status',
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Application: Pending')));
                  },
                ),
              ],
            ),
          ),
          decoration: new BoxDecoration(
              gradient:
                  new LinearGradient(colors: [Colors.blueGrey, Colors.teal]),
              boxShadow: [
                new BoxShadow(
                  color: Colors.black,
                  blurRadius: 20.0,
                  spreadRadius: 1.0,
                )
              ]),
        ),
        preferredSize: new Size(MediaQuery.of(context).size.width, 150.0),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blueGrey, Colors.teal]),
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
              (curruser.middleName != null)
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

      /*  floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return Scaffold(
                      appBar: AppBar(
                        title: const Text('Confirmation'),
                      ),
                      body: const Center(
                        child: Text(
                          'Are you sure you would like to verify this client?',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    );
                  },
                ));
              },
              tooltip: 'Verify',
              child: Icon(Icons.app_registration),
            ),*/
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
              // left: BorderSide(
              //   color: Colors.white,
              //   width: 1,
              // ),
              bottom: BorderSide(
                color: Colors.white,
                width: 1,
              ),
            ),
          ),
          child: Text(
            property + ": " + text,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        )
      ],
    );
  }
}
