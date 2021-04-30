import 'package:flutter/material.dart';
import 'package:last_national_bank/utils/helpers/style.dart';

import '../../classes/user.class.dart';
import '../../constants/database_constants.dart';
import '../../utils/helpers/helper.dart';
import '../../utils/services/local_db.dart';
import '../../utils/services/online_db.dart';

class PlaygroundTest extends StatefulWidget {
  @override
  _PlaygroundTestState createState() => _PlaygroundTestState();
}

class _PlaygroundTestState extends State<PlaygroundTest> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: backgroundGradient,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: AccountCardInfo(),
          ),
        ],
      ),
    );
  }
}

class AccountCardInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 300,
      decoration: BoxDecoration(
        // gradient: LinearGradient(
        //     begin: Alignment.centerLeft,
        //     end: Alignment.centerRight,
        //     colors: [
        //       Colors.blueGrey[100]!,
        //       Colors.blueGrey[50]!,
        //       Colors.blueGrey[100]!
        //     ]),
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "VISA",
            style: TextStyle(
              color: Colors.teal,
              fontSize: 48,
              fontFamily: "arial",
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
