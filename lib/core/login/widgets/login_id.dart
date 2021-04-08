import 'package:flutter/material.dart';
import 'package:last_national_bank/core/login/login.functions.dart';

class InputID extends StatefulWidget {
  final TextEditingController idController;
  InputID(this.idController);
  @override
  _InputIDState createState() => _InputIDState();
}

String inputText = "";
bool _hasInputError = false;

class _InputIDState extends State<InputID> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextField(
          controller: this.widget.idController,
          onChanged: (String idNumb) {
            _hasInputError = hasInputErrorID(idNumb);
          },
          style: TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            errorText: _hasInputError
                ? "Invalid ID Number"
                : null, //text if password has errors
            fillColor: Colors.lightBlueAccent,
            hintText: 'ID Number',
            hintStyle: TextStyle(fontSize: 16.0, color: Colors.white),
            labelStyle: TextStyle(
              color: Colors.white70,
            ),
          ),
        ),
      ),
    );
  }
}
