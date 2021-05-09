import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import '../config/routes/router.dart';
import '../core/verification_list/admin_verification_list.dart';
import 'routeButton.dart';

class buttonRejectClient extends StatefulWidget {
  final Function onTap;
  buttonRejectClient(this.onTap);
  @override
  _buttonRejectClientState createState() => _buttonRejectClientState();
}


class _buttonRejectClientState extends State<buttonRejectClient> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        bottom: 20,
        right: 1,
      ),
      child: Container(
        alignment: Alignment.center,
        height: 40,
        width: MediaQuery.of(context).size.width / 3,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 10.0, // has the effect of softening the shadow
              spreadRadius: 1.0, // has the effect of extending the shadow
              offset: Offset(
                5.0, // horizontal, move right 10
                5.0, // vertical, move down 10
              ),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: TextButton(
          onPressed: () {
            this.widget.onTap();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Reject Client',
                style: TextStyle(
                  color: Colors.teal,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
