// coverage:ignore-start
import 'package:flutter/material.dart';

import '../registration.functions.dart';

class NewLoc extends StatefulWidget {
  final double width;

  NewLoc(this.width);

  @override
  NewLocState createState() => NewLocState();
}

class NewLocState extends State<NewLoc> {
  bool _hasInputErrorAdd = false; //input error control variable
  bool _hasInputErrorName = false;
  bool _hasInputErrorSub = false;
  bool _hasInputErrorProv = false;
  bool _hasInputErrorApart = false;

  /*String _add = ""; //location variable
  String _name = "";
  String _sub = "";
  String _prov = "";
  String _apart = "";*/

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
      child: Container(
        height: 374,
        width: this.widget.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    child: Icon(Icons.location_pin, color: Colors.white),
                  ),
                  TextSpan(
                    text: "Address",
                    style: TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                ],
              ),
            ),
            TextField(
              onChanged: (value) {
                _hasInputErrorAdd = hasInputErrorInt(
                    value); //call validator to check for errors
                if (_hasInputErrorAdd == false) {
                  //if no errors, assign location
                  //_add = value;
                  Address.streetNumber = value;
                  setCheck(true);
                } else {
                  setCheck(false);
                }
                setState(() {});
              },
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                /*contentPadding:
                    const EdgeInsets.only(top: 30, left: 50, right: 50),*/
                errorText: _hasInputErrorAdd ? "Invalid street number" : null,
                fillColor: Colors.transparent,
                hintText: 'Street Number',
                hintStyle: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ),
            TextField(
              scrollPadding:
                  const EdgeInsets.only(top: 30, left: 50, right: 50),
              onChanged: (value) {
                _hasInputErrorApart = hasInputErrorInt(
                    value); //call validator to check for errors
                if (_hasInputErrorApart == false) {
                  //if no errors, assign location
                  //_loc = value;
                  Address.apartmentNumber = value;
                  setCheck(true);
                } else {
                  setCheck(false);
                }
                setState(() {});
              },
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                errorText:
                    _hasInputErrorApart ? "Invalid apartment number" : null,
                fillColor: Colors.transparent,
                hintText: 'Apartment number',
                hintStyle: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ),
            TextField(
              scrollPadding:
                  const EdgeInsets.only(top: 30, left: 50, right: 50),
              onChanged: (value) {
                _hasInputErrorName = hasInputErrorLoc(
                    value); //call validator to check for errors
                if (_hasInputErrorName == false) {
                  //if no errors, assign location
                  //_loc = value;
                  Address.streetName = value;
                  setCheck(true);
                } else {
                  setCheck(false);
                }
                setState(() {});
              },
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                /*contentPadding:
                    const EdgeInsets.only(top: 30, left: 50, right: 50),*/
                errorText: _hasInputErrorName ? "Invalid street name" : null,
                fillColor: Colors.transparent,
                hintText: 'Street Name',
                hintStyle: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ),
            TextField(
              scrollPadding:
                  const EdgeInsets.only(top: 30, left: 50, right: 50),
              onChanged: (value) {
                _hasInputErrorSub = hasInputErrorLoc(
                    value); //call validator to check for errors
                if (_hasInputErrorSub == false) {
                  //if no errors, assign location
                  //_loc = value;
                  Address.suburb = value;
                  setCheck(true);
                } else {
                  setCheck(false);
                }
                setState(() {});
              },
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                errorText: _hasInputErrorSub ? "Invalid suburb" : null,
                fillColor: Colors.transparent,
                hintText: 'Suburb',
                hintStyle: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ),
            TextField(
              scrollPadding:
                  const EdgeInsets.only(top: 30, left: 50, right: 50),
              onChanged: (value) {
                _hasInputErrorProv = hasInputErrorLoc(
                    value); //call validator to check for errors
                if (_hasInputErrorProv == false) {
                  //if no errors, assign location
                  //_loc = value;
                  Address.province = value;
                  setCheck(true);
                } else {
                  setCheck(false);
                }
                setState(() {});
              },
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                errorText: _hasInputErrorProv ? "Invalid Province" : null,
                fillColor: Colors.transparent,
                hintText: 'Province',
                hintStyle: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//function to check for invalid name
bool hasInputErrorLoc(String loc) {
  if (loc.length == 0) {
    return true;
  }
  return false;
}

/*String returnloc() {
    return _loc;
  }*/
// coverage:ignore-end

