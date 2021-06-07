// coverage:ignore-start
import 'package:flutter/material.dart';

class VerifyUser extends StatefulWidget {
  // MyHomePage({key key, this.title}) : super(key:key);
  @override
  _VerifyUserState createState() => _VerifyUserState();
}

class _VerifyUserState extends State<VerifyUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blueGrey, Colors.teal]),
        ),
        padding: new EdgeInsets.only(
          top: 15.0,
          left: 15.0,
          right: 15.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(
              Icons.assignment_ind_rounded,
              color: Colors.white,
              size: 75,
            ),
            Text(
              'Customer Information',
              style: new TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('First Name : ', style: TextStyle(color: Colors.white)),
                Text('Sheslin', style: TextStyle(color: Colors.white)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('Last Name : ', style: TextStyle(color: Colors.white)),
                Text('Naidoo', style: TextStyle(color: Colors.white)),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute<void>(
            builder: (BuildContext context) {
              return Scaffold(
                body: const Center(
                  child: Text(
                    'Are you sure you would like to verify this client?',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              );
            },
          ));
        },
        tooltip: 'Verify',
        child: Icon(Icons.app_registration),
      ),
    );
  }
}
// coverage:ignore-end
