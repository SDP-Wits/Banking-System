import 'package:flutter/material.dart';

import '../config/routes/router.dart';
import 'package:last_national_bank/core/registration/registration.functions.dart';

class FirstTime extends StatefulWidget {
  @override
  _FirstTimeState createState() => _FirstTimeState();
}

class _FirstTimeState extends State<FirstTime> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      // padding: EdgeInsets.all(15),
      color: Colors.blueGrey,
      child: Container(
        // padding: EdgeInsets.all(15),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(5),
              // padding: EdgeInsets.all(15),
              child: Text(
                'Your first time?',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white70,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Center(
                          child: Text('Registration'),
                        ),
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "Are you registering as a client or an administartor?",
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('Client'),
                            onPressed: () {
                              Data.is_client = true;
                              Navigator.pop(context);
                              goToClientRegistration(context);
                            },
                          ),
                          FlatButton(
                            child: Text('Administrator'),
                            onPressed: () {
                              Data.is_client = false;
                              Navigator.pop(context);
                              goToAdminRegistration(context);
                            },
                          ),
                        ],
                      );
                    });
              },
              child: Text(
                'Sign up',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
