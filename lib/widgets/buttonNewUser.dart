import 'package:flutter/material.dart';

class ButtonNewUser extends StatefulWidget {
  @override
  _ButtonNewUserState createState() => _ButtonNewUserState();
}

class _ButtonNewUserState extends State<ButtonNewUser> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Container(
        alignment: Alignment.center,
        height: 40,
        width: MediaQuery.of(context).size.width / 2,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0, // has the effect of softening the shadow
            spreadRadius: 1.0, // has the effect of extending the shadow
            /*offset: Offset(
              5.0, // horizontal, move right 10
              5.0, // vertical, move down 10
            ),*/
          ),
        ], color: Colors.indigo[200], borderRadius: BorderRadius.circular(30)),
        child: FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Create Account',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
