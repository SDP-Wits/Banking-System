// coverage:ignore-start
import 'package:flutter/material.dart';
import 'package:last_national_bank/core/account/accounts.dart';
import 'package:last_national_bank/core/profile/profile.dart';
import 'package:last_national_bank/core/timeline/timeline.dart';
import 'package:last_national_bank/utils/helpers/helper.dart';

import '../../constants/route_constants.dart';
import 'package:last_national_bank/utils/helpers/helper.dart';
// import '../../pages/accountspage.dart';

import '../config/routes/router.dart';
import '../utils/helpers/icons.dart';
import '../utils/helpers/style.dart';
import '../utils/services/local_db.dart';

//remember to takeout
/*void main() {
  runApp(const DesktopTabNavigator());
}*/

class DesktopTabNavigator extends StatelessWidget {
  final bool isPending;
  DesktopTabNavigator({this.isPending = false});

  @override
  Widget build(BuildContext context) {
    final size = getSize(context);
    return Container(
      width: size.width,
      // height: size.height * 0.3,
      padding: EdgeInsets.symmetric(vertical: 45),
      color: Colors.teal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (!isPending)
            makeTab(
                icon: IconButton(
                  icon: Icon(
                    (iconFamily.user),
                    color: Colors.white,
                  ),

                  // When icon is clicked, close navigation
                  onPressed: () {
                    //Navigator.pop(context);
                    goToProfilePage(context);
                  },
                ),
                text: 'Profile'),
          if (!isPending)
            makeTab(
                icon: IconButton(
                  icon: Icon(
                    (iconFamily.account_balance),
                    color: Colors.white,
                  ),

                  // When icon is clicked, close navigation
                  onPressed: () {
                    //Navigator.pop(context);
                    goToViewAccount(context);
                  },
                ),
                text: 'Accounts'),
          if (!isPending)
            makeTab(
                icon: IconButton(
                  icon: Icon(
                    (iconFamily.history),
                    color: Colors.white,
                  ),

                  // When icon is clicked, close navigation
                  onPressed: () {
                    //Navigator.pop(context);
                    goToTimeline(context);
                  },
                ),
                text: 'Timeline'),
          if (!isPending)
            makeTab(
                icon: IconButton(
                  icon: Icon(
                    (iconFamily.payment),
                    color: Colors.white,
                  ),

                  // When icon is clicked, close navigation
                  onPressed: () {
                    //Navigator.pop(context);
                    goToSelectPayment(context);
                  },
                ),
                text: 'Transfers & Payments'),
          IconButton(
            icon: Icon(
              (iconFamily.logout),
              color: Colors.redAccent,
            ),

            // When icon is clicked, close navigation
            onPressed: () {
              Future.delayed(Duration(milliseconds: 500)).then((value) {
                LocalDatabaseHelper.instance.deleteData();
              });
              goToLogin(context);
            },
          ),
        ],
      ),
    );
  }
}

class makeTab extends StatelessWidget {
  final Widget icon;
  final String text;
  makeTab({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          icon,
          Text(
            text,
            style: TextStyle(
              fontSize: 10,
              fontFamily: fontMont,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
// coverage:ignore-end