import 'package:flutter/material.dart';
import 'package:last_national_bank/utils/services/local_db.dart';
// coverage:ignore-start
import '../config/routes/router.dart';
import '../utils/helpers/icons.dart';
import '../utils/helpers/style.dart';

class DrawerCode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: pendingNav(
        clientName: '',
        clientSurname: '',
      ),
      appBar: AppBar(
        title: Text("Drawer"),
      ),
    );
  }
}

// Navigation and Drawer used interchangeably in comments

class pendingNav extends StatelessWidget {
  String clientName, clientSurname;

  // Name and Surname needed to display in drawer header
  pendingNav({required this.clientName, required this.clientSurname});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer.
      child: ListView(
        children: <Widget>[
          Container(
              height: 250,

              // Drawer Header: Close icon, Image, Name & Surname
              child: DrawerHeader(
                decoration: BoxDecoration(
                  // Colour of header:
                  gradient: backgroundGradient,
                  // Image logo:
                  image: new DecorationImage(
                    image: AssetImage("assets/logo1.png"),
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
                      Padding(
                        padding: const EdgeInsets.only(top: 140, left: 10),
                        child: Text(
                          clientName + ' ' + clientSurname,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontFamily: fontMont,
                          ),
                        ),
                      ),
                    ]),
              )),

          // Now add all the options in the drawer as ListTiles

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
                  LocalDatabaseHelper.instance
                      .deleteData()
                      .then((value) => goToLogin(context));
                },
              )),
        ],
      ),
    );
  }
}
// coverage:ignore-end
