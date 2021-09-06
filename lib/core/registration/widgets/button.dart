import 'package:flutter/material.dart';
import 'package:last_national_bank/utils/helpers/helper.dart';

import '../../../utils/helpers/style.dart';

// coverage:ignore-start
class ButtonLogin extends StatefulWidget {
  final Function onTap;
  ButtonLogin(this.onTap);
  @override
  _ButtonLoginState createState() => _ButtonLoginState();
}

class _ButtonLoginState extends State<ButtonLogin> {
  @override
  Widget build(BuildContext context) {
    final size = getSize(context);
    return Padding(
      padding: const EdgeInsets.only(
        top: 40,
      ),
      child: Container(
        alignment: Alignment.center,
        height: 40,
        width: MediaQuery.of(context).size.width / 2,
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
              Container(
                padding: (size.width < tabletWidth)
                    ? null
                    : EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: fontMont,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// coverage:ignore-end
