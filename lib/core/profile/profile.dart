// coverage:ignore-start
import 'package:flutter/material.dart';
import '../../widgets/navigation.dart';

import '../../classes/thisUser.dart';
import '../../classes/user.class.dart';
import '../../config/routes/router.dart';
import '../../utils/services/local_db.dart';
import '../../utils/services/online_db.dart';

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

    LocalDatabaseHelper.instance.getUserAndAddress().then((currUser) {
      setState(() {
        user = currUser;
      });
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

  @override
  Widget build(BuildContext context) {
    if (me == null) {
      return _buildLoadingScreen();
    } else {
      return buildPage();
    }
  }

  Widget buildPage() {
    final Size size = MediaQuery.of(context).size;

    return (user == null)
        ? Scaffold(
            drawer: null,
            body: Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.blueGrey, Colors.teal]),
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(Icons.menu, color: Colors.white),
                  onPressed: () {
                    _scaffoldKey.currentState!.openDrawer();
                  },
                ),
              ),
            ))
        : Scaffold(
            key: _scaffoldKey,
            drawer: (me![0].status != "Pending")
                ? Navigation(
                    clientName: user!.firstName, clientSurname: user!.lastName)
                : null,
            body: Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.teal, Colors.blueGrey]),
              ),
              padding: EdgeInsets.all(10.0),
              child: ListView(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: Icon(Icons.menu, color: Colors.white),
                      onPressed: () {
                        _scaffoldKey.currentState!.openDrawer();
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                  ),
                  HeadingBlocks1("My Information", 34, 30),
                  Container(
                    padding: EdgeInsets.all(15),
                  ),
                  HeadingBlocks(
                      "Verification Status: " + me![0].status, 22, 20),
                  DetailedBlocks(user!.firstName, "First Name"),
                  (user!.middleName != null)
                      ? DetailedBlocks(user!.middleName!, "Middle Name")
                      : Container(),
                  DetailedBlocks(user!.lastName, "Last Name"),
                  DetailedBlocks(user!.email, "Email"),
                  DetailedBlocks(user!.idNumber, "ID"),
                  DetailedBlocks(user!.phoneNumber, "Phone Number"),
                  DetailedBlocks(
                      user!.address.streetNumber.toString() +
                          " " +
                          user!.address.streetName,
                      "Address"),
                  DetailedBlocks(user!.address.suburb, "Suburb"),
                ],
              ),
            ));
  }
}

class HeadingBlocks extends StatelessWidget {
  final String text;
  final double fontSize;
  final double padding;
  HeadingBlocks(this.text, this.fontSize, this.padding);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: fontSize,
          color: Colors.teal,
        ),
      ),
    );
  }
}

class HeadingBlocks1 extends StatelessWidget {
  final String text;
  final double fontSize;
  final double padding;
  HeadingBlocks1(this.text, this.fontSize, this.padding);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15),
        // border: Border(
        //   left: BorderSide(
        //     color: Colors.white,
        //     width: 1,
        //   ),
        //   bottom: BorderSide(
        //     color: Colors.white,
        //     width: 1,
        //   ),
        // ),
        border: Border.all(color: Colors.white, width: 3),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: fontSize,
          color: Colors.white,
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
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
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
    );
  }
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
// coverage:ignore-end
