import 'dart:html';

import 'package:flutter/material.dart';

import '../registration.functions.dart';

class NewLoc extends StatefulWidget {
  @override
  NewLocState createState() => NewLocState();
}

class NewLocState extends State<NewLoc> {
  bool _hasInputError = false; //input error control variable
  String _loc = ""; //location variable

  //function to check for invalid name
  bool hasInputError(String loc) {
    if (loc.length == 0) {
      return true;
    }
    return false;
  }

  String returnloc() {
    return _loc;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
      child: Container(
        height: 300,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Addresses',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 16.0, color: Colors.white),
            ),
            TextField(
              scrollPadding:
                  const EdgeInsets.only(top: 30, left: 50, right: 50),
              onChanged: (value) {
                _hasInputError =
                    hasInputError(value); //call validator to check for errors
                if (_hasInputError == false) {
                  //if no errors, assign location
                  _loc = value;
                  Data.loc = value;
                }
                setState(() {});
              },
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                /*contentPadding:
                    const EdgeInsets.only(top: 30, left: 50, right: 50),*/
                errorText: _hasInputError ? "Invlaid Location" : null,
                fillColor: Colors.transparent,
                hintText: 'Street Number',
                hintStyle: TextStyle(fontSize: 16.0, color: Colors.white),
                icon: Icon(Icons.location_pin, color: Colors.white),
              ),
            ),
            TextField(
              scrollPadding:
                  const EdgeInsets.only(top: 30, left: 50, right: 50),
              onChanged: (value) {
                _hasInputError =
                    hasInputError(value); //call validator to check for errors
                if (_hasInputError == false) {
                  //if no errors, assign location
                  _loc = value;
                  Data.loc = value;
                }
                setState(() {});
              },
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                /*contentPadding:
                    const EdgeInsets.only(top: 30, left: 50, right: 50),*/
                errorText: _hasInputError ? "Invlaid Location" : null,
                fillColor: Colors.transparent,
                hintText: 'Street Name',
                hintStyle: TextStyle(fontSize: 16.0, color: Colors.white),
                icon: Icon(Icons.location_pin, color: Colors.white),
              ),
            ),
            TextField(
              scrollPadding:
                  const EdgeInsets.only(top: 30, left: 50, right: 50),
              onChanged: (value) {
                _hasInputError =
                    hasInputError(value); //call validator to check for errors
                if (_hasInputError == false) {
                  //if no errors, assign location
                  _loc = value;
                  Data.loc = value;
                }
                setState(() {});
              },
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                errorText: _hasInputError ? "Invlaid Location" : null,
                fillColor: Colors.transparent,
                hintText: 'Suburb',
                hintStyle: TextStyle(fontSize: 16.0, color: Colors.white),
                icon: Icon(Icons.location_pin, color: Colors.white),
              ),
            ),
            TextField(
              scrollPadding:
                  const EdgeInsets.only(top: 30, left: 50, right: 50),
              onChanged: (value) {
                _hasInputError =
                    hasInputError(value); //call validator to check for errors
                if (_hasInputError == false) {
                  //if no errors, assign location
                  _loc = value;
                  Data.loc = value;
                }
                setState(() {});
              },
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                errorText: _hasInputError ? "Invlaid Location" : null,
                fillColor: Colors.transparent,
                hintText: 'Province',
                hintStyle: TextStyle(fontSize: 16.0, color: Colors.white),
                icon: Icon(Icons.location_pin, color: Colors.white),
              ),
            ),
            TextField(
              scrollPadding:
                  const EdgeInsets.only(top: 30, left: 50, right: 50),
              onChanged: (value) {
                _hasInputError =
                    hasInputError(value); //call validator to check for errors
                if (_hasInputError == false) {
                  //if no errors, assign location
                  _loc = value;
                  Data.loc = value;
                }
                setState(() {});
              },
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                errorText: _hasInputError ? "Invlaid Location" : null,
                fillColor: Colors.transparent,
                hintText: 'Apartment number',
                hintStyle: TextStyle(fontSize: 16.0, color: Colors.white),
                icon: Icon(Icons.location_pin, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
