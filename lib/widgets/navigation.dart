import 'package:flutter/material.dart';
import 'package:last_national_bank/config/routes/router.dart';
import 'package:last_national_bank/utils/helpers/icons.dart';
import 'package:last_national_bank/utils/helpers/style.dart';


class DrawerCode extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navigation(clientName: '', clientSurname:  '',),
      appBar: AppBar(
        title: Text("Drawer"),
      ),
    );
  }
}


class Navigation extends StatelessWidget {
  String clientName, clientSurname;

  Navigation({required this.clientName, required this.clientSurname});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
          // Important: Remove any padding from the ListView.
          //padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 250,
              child: DrawerHeader(
                
                decoration: BoxDecoration(
                  gradient: backgroundGradient,
                  
                  image: new DecorationImage(
                    image: AssetImage("assets/logo1.png"),
                    alignment: Alignment.topCenter,
                  ),

                ),
                
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
          
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),

                  Padding( padding: const EdgeInsets.only(top: 140, left: 10),
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
              )
            ),

            ListTile(
              leading: Icon(iconFamily.user),
              title: Text('My Profile', 
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: fontMont,
                ),
              ),

              onTap: () {
                Navigator.pop(context);
                goToAdminVerificationStatus(context);
              },
            ),

            ListTile(
              leading: Icon(iconFamily.account_balance),
              title: Text('View Accounts', 
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: fontMont,
                ),
              ),

              onTap: () {
                Navigator.pop(context);
                goToViewAccount(context);
                
              },
            ),

            ListTile(
              leading: Icon(iconFamily.history),
              title: Text('History/Timeline', 
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: fontMont,
                ),
              ),

              onTap: () {
                //
                Navigator.pop(context);
                goToTimeline(context);
              },
            ),

            ListTile(
              leading: Icon(iconFamily.payment),
              title: Text('Make Payment', 
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: fontMont,
                ),
              ),

              onTap: () {
                //
                Navigator.pop(context);
              },
            ),

            Align(
              alignment: Alignment.bottomCenter,  // Doesn't work idk :(

              child: ListTile(              
                leading: Icon(iconFamily.logout),
                title: Text('Log Out', 
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: fontMont,
                  ),
                ),

                onTap: () {
                  //
                  Navigator.pop(context);
                },
              )
            ),
          ],
        ),
    );
  }
}