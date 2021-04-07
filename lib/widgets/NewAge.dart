import 'package:flutter/material.dart';

class NewAge extends StatefulWidget {
  @override
  NewAgeState createState() => NewAgeState();
}

class NewAgeState extends State<NewAge> {
  bool _hasInputError = false; //error control variable
  int _age = 0; //age variable

  //function to check for invalid age
  bool hasInputError(int age){
    if (age <= 0){
      return true;
    }
    return false;
  }
int returnAge(){
  return _age;
}
  //assign age if no value present
  void assignAge(int age){
    if (hasInputError(age) == false){
      _age = age;
    }
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
            if (value == ""){         //if no value is enterred in age field, call error
              _hasInputError = true;
            }
            else{                     //convert string to integer and check for invalid age
              int age = int.parse(value);
              _hasInputError = hasInputError(age);
              if (_hasInputError == false){
                assignAge(age);
              }
            }
            setState(() {});
          },
          style: TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            errorText: _hasInputError ? "Invalid Age": null, //display text if errors present
            fillColor: Colors.transparent,
            hintText: 'Age',
            hintStyle: TextStyle(fontSize: 16.0, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
