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
                  colors: [Colors.blueGrey, Colors.teal]),
            ),
          )
        : Container(
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
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                ),
                HeadingBlocks1("My Information", 34, 30),
                Container(
                  padding: EdgeInsets.all(15),
                ),
                HeadingBlocks("Verification Status: Pending", 22, 20),
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
        border: Border.all(color:Colors.white, width: 3),
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
        style: TextStyle(
          fontSize: 16,
          color: Colors.white
        ),
      ),
    );
  }
}
