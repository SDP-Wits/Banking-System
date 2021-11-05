import 'package:flutter/material.dart';
import 'package:last_national_bank/utils/helpers/helper.dart';
import 'package:last_national_bank/utils/helpers/style.dart';

// coverage:ignore-start
class buttonRejectClient extends StatefulWidget {
  final Function onTap;
  buttonRejectClient(this.onTap);
  @override
  _buttonRejectClientState createState() => _buttonRejectClientState();
}

class _buttonRejectClientState extends State<buttonRejectClient> {
  @override
  Widget build(BuildContext context) {
    final size = getSize(context);
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        bottom: 20,
        right: 1,
      ),
      child: Container(
        alignment: Alignment.center,
        height: 40,
        width: (size.width < tabletWidth) ? size.width / 3 : size.width * 0.1,
        // margin: (size.width >= tabletWidth)
        //     ? EdgeInsets.symmetric(vertical: 10, horizontal: 15)
        //     : null,
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
                  color: Colors.red,
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
// coverage:ignore-end
