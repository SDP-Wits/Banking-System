import 'package:flutter/material.dart';

class NewLoc extends StatefulWidget {
  @override
  NewLocState createState() => NewLocState();
}

class NewLocState extends State<NewLoc> {
  bool _hasInputError = false; //input error control variable
  String _loc = ""; //location variable

  //function to check for invalid name
  bool hasInputError(String loc){
    if (loc.length == 0){
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextField(
          onSubmitted: (value){
            _hasInputError = hasInputError(value);  //call validator to check for errors
            if (_hasInputError == false){ //if no errors, assign location
              _loc = value;
            }
            setState(() {});
          },
          style: TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            errorText: _hasInputError ? "Invlaid Location": null,
            fillColor: Colors.transparent,
            hintText: 'Location',
            hintStyle: TextStyle(fontSize: 16.0, color: Colors.white),
            icon: Icon(Icons.location_pin, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
