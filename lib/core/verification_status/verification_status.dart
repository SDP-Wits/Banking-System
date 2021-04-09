import 'package:flutter/material.dart';
import 'package:last_national_bank/classes/user.class.dart';
import 'package:last_national_bank/config/routes/router.dart';
import 'package:last_national_bank/utils/helpers/style.dart';
import 'package:last_national_bank/utils/services/local_db.dart';

class VerificationStatus extends StatefulWidget {
  @override
  _VerificationStatusState createState() => _VerificationStatusState();
}

class _VerificationStatusState extends State<VerificationStatus> {
  User? user = null;
  @override
  void initState() {
    super.initState();
    LocalDatabaseHelper.instance.getUserAndAddress().then((currUser) {
      setState(() {
        user = currUser;
      });
      if (user == null) {
        LocalDatabaseHelper.instance.deleteData();
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return (user == null)
        ? Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.blueGrey, Colors.lightBlueAccent]),
            ),
          )
        : SingleChildScrollView(
            child: Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.blueGrey, Colors.lightBlueAccent]),
              ),
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                  ),
                  HeadingBlocks("My Information", 34, 30),
                  Container(
                    padding: EdgeInsets.all(15),
                  ),
                  HeadingBlocks("Verification Status: Pending", 28, 20),
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
                          user!.address.streetName,
                      "Address"),
                  DetailedBlocks(user!.address.suburb, "Suburb"),
                ],
              ),
            ),
          );
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
        color: Colors.grey,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: fontSize,
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
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        property + ": " + text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}
