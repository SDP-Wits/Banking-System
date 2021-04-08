import 'package:flutter/material.dart';

import '../config/routes/router.dart';

class FirstTime extends StatefulWidget {
  @override
  _FirstTimeState createState() => _FirstTimeState();
}

class _FirstTimeState extends State<FirstTime> {
  
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 30),
      child: Container(
        alignment: Alignment.topRight,
        color: Colors.blueGrey,
        height: 20,
        child: Container(
          // padding: EdgeInsets.all(15),
          alignment: Alignment.center,
          child: Row(
            children: <Widget>[
              Container(
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
                    barrierDismissible: false,
                    builder: (BuildContext context){
                      return AlertDialog(
                        title: Center(child: Text('Registration'),),
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
                              goToClientRegistration(context);
                            },
                          ),
                          FlatButton(
                            child: Text('Administrator'),
                            onPressed: () {
                              goToAdminRegistration(context);
                            },
                          ),
                        ],
                      );
                    }
                  );
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
      ),
    );
  }
}
