import 'package:flutter/material.dart';
import 'package:last_national_bank/utils/helpers/helper.dart';

// coverage:ignore-start
import '../config/routes/router.dart';
import '../utils/helpers/icons.dart';
import '../utils/helpers/style.dart';
import '../utils/services/local_db.dart';

class DrawerCode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navigation(
        clientName: '',
        clientSurname: '',
        context: context,
      ),
      appBar: AppBar(
        title: Text("Drawer"),
      ),
    );
  }
}

// Navigation and Drawer used interchangeably in comments
Widget? Navigation(
    {required String clientName,
    required String clientSurname,
    required BuildContext context}) {
  final size = getSize(context);
  if (size.width > tabletWidth) {
    return null;
  } else {
    return _Navigation(clientName: clientName, clientSurname: clientSurname);
  }
}

class _Navigation extends StatelessWidget {
  String clientName, clientSurname;

  // Name and Surname needed to display in drawer header
  _Navigation({required this.clientName, required this.clientSurname});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer.
      child: ListView(
        children: <Widget>[
          Container(
              height: 325,

              // Drawer Header: Close icon, Image, Name & Surname
              child: DrawerHeader(
                decoration: BoxDecoration(
                  // Colour of header:
                  gradient: backgroundGradient,
                  // Image logo:
                  image: new DecorationImage(
                    image: AssetImage("assets/images/logo1.png"),
                    alignment: Alignment.topCenter,
                  ),
                ),

                // Column: Close icon, Client name
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Close icon
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: Icon(
                            Icons.close,
                            color: Colors.white,
                          ),

                          // When icon is clicked, close navigation
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),

                      // Client name & surname
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(top: 140, left: 10),
                        child: Text(
                          clientName + '\n' + clientSurname,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontFamily: fontMont,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ]),
              )),

          // Now add all the options in the drawer as ListTiles

          // My Profile
          ListTile(
            leading: Icon(iconFamily.user),

            title: Text(
              'My Profile',
              style: TextStyle(
                fontSize: 18,
                fontFamily: fontMont,
              ),
            ),

            // When tile is clicked, do..
            onTap: () {
              Navigator.pop(context);
              goToProfilePage(context);
            },
          ),

          // View Accounts
          ListTile(
            leading: Icon(iconFamily.account_balance),

            title: Text(
              'View Accounts',
              style: TextStyle(
                fontSize: 18,
                fontFamily: fontMont,
              ),
            ),

            // When tile is clicked, do..
            onTap: () {
              Navigator.pop(context);
              goToViewAccount(context);
            },
          ),

          // Timeline
          ListTile(
            leading: Icon(iconFamily.history),

            title: Text(
              'Timeline',
              style: TextStyle(
                fontSize: 18,
                fontFamily: fontMont,
              ),
            ),

            // When tile is clicked, do..
            onTap: () {
              Navigator.pop(context);
              goToTimeline(context);
            },
          ),

          // Transfers & Payments
          ListTile(
            leading: Icon(iconFamily.payment),

            title: Text(
              'Transfers & Payments',
              style: TextStyle(
                fontSize: 18,
                fontFamily: fontMont,
              ),
            ),

            // When tile is clicked, do..
            onTap: () {
              Navigator.pop(context);
              goToSelectPayment(context);
            },
          ),

          // Logout
          Align(
              alignment: Alignment.bottomCenter, // Doesn't work idk :(

              child: ListTile(
                leading: Icon(iconFamily.logout),

                title: Text(
                  'Log Out',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: fontMont,
                  ),
                ),

                // When tile is clicked, do..
                onTap: () {
                  Future.delayed(Duration(milliseconds: 500)).then((value) {
                    LocalDatabaseHelper.instance.deleteData();
                  });
                  goToLogin(context);
                },
              )),
        ],
      ),
    );
  }
}
// coverage:ignore-end
