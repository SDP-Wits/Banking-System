// coverage:ignore-start
import 'dart:ui';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:last_national_bank/classes/user.class.dart';
import 'package:last_national_bank/config/routes/router.dart';
import 'package:last_national_bank/constants/route_constants.dart';
import 'package:last_national_bank/utils/services/local_db.dart';
import 'package:last_national_bank/utils/services/online_db.dart';
import 'package:last_national_bank/widgets/heading.dart';
import 'package:last_national_bank/utils/helpers/back_button_helper.dart';
import 'package:last_national_bank/widgets/navigation.dart';
import 'package:last_national_bank/widgets/pendingNav.dart';

import '../../classes/name.class.dart';
import '../../utils/helpers/style.dart';
import '../../utils/services/online_db.dart';
import 'admin_verify_user.dart';

class AdminVerificationListPage extends StatefulWidget {
  @override
  _AdminVerificationListPageState createState() =>
      _AdminVerificationListPageState();
}

class _AdminVerificationListPageState extends State<AdminVerificationListPage> {
  //==================================================================
  //Example data:
  /*List<VerificationListClass> names = [
    VerificationListClass(name: 'Joe Biden', id: '0664652652'),
    VerificationListClass(name: 'Mary Gilbert', id: '0664652652'),
    VerificationListClass(name: 'Bob Stan', id: '0664652652'),
    VerificationListClass(name: 'Lisa Monroe', id: '0664652652'),
    VerificationListClass(name: 'Noah Arc', id: '0664652652'),
    VerificationListClass(name: 'Kiara Sweets', id: '0664652652'),
    VerificationListClass(name: 'Kerina Bennet', id: '0664652652'),
    VerificationListClass(name: 'Arneev Draco', id: '0664652652'),
    VerificationListClass(name: 'Moe Timber', id: '0664652652'),
    VerificationListClass(name: 'Tristan Steel', id: '0664652652'),
    VerificationListClass(name: 'Seshlin Mike', id: '0664652652')
  ];*/

  List<Name> names = [];
  User? user; // User information

  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);

    getUnverifiedClients().then((lstNames) {
      names = lstNames;
      setState(() {});
    });

    // Get user details
    LocalDatabaseHelper.instance.getUserAndAddress().then((userDB) {
      setState(() {
        user = userDB;
      });
    });
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    return helperInterceptor(
        context: context,
        currentRoute: AdminVerificationListRoute,
        goTo: goToLogin,
        info: info,
        stopDefaultButtonEvent: stopDefaultButtonEvent);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // _scaffoldKey is the key used for the navigation drawer
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
        // Set navigation drawer
        key: _scaffoldKey,
        drawer: pendingNav(
            clientName: user!.firstName, clientSurname: user!.lastName),
        body: Container(
          decoration: BoxDecoration(
            gradient: backgroundGradient,
          ),

          // Allows page to be scrollable
          child: SingleChildScrollView(
            padding: EdgeInsets.all(10.0),
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(minHeight: MediaQuery.of(context).size.height),

              // List
              child: Column(
                children: [
                  // Three-line menu bar on the top to open the navigation drawer
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: Icon(Icons.menu, color: Colors.white),
                      onPressed: () {
                        _scaffoldKey.currentState!.openDrawer();
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Heading("Verify User"),
                  ),
                  (names.length == 0)
                      ? Container(
                          width: size.width,
                          height: size.height,
                          child: Center(
                            child: Text(
                              "No Users to Verify",
                              style: TextStyle(
                                fontFamily: fontMont,
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: names.length,
                          itemBuilder: (BuildContext context, int index) {
                            String textToUse = "\t\t ${names[index].fName} ";
                            if (names[index].mName != null) {
                              textToUse += names[index].mName!;
                              textToUse += " ";
                            }
                            textToUse += names[index].sName;

                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: InkWell(
                                // When user clicks on item box, sonmething happens:
                                // customBorder: Border.all(color: Colors.white, width: 2),
                                onTap: () {
                                  goToVerifyUser(
                                      context: context,
                                      idNumber: names[index].IDnum);
                                },

                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  padding: EdgeInsets.all(15),
                                  child: Text(
                                    // names i sthe name of the example array used above
                                    // Will need to find outy how to use array in
                                    // verification.functions.dart here
                                    textToUse,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: fontSizeSmall,
                                        color: Colors.white,
                                        fontFamily: fontMont),
                                  ),
                                ),
                              ),
                            );
                          }),
                ],
              ),
            ),
          ),
        ));
  }
}

// coverage:ignore-end
//==================================================================

//@override
/*Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(url1),
          leading: Icon(
            Icons.get_app,
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: FutureBuilder(
            future: selectUnverifiedClients(),
            builder: (BuildContext ctx, AsyncSnapshot snapshot) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (ctx, index) => ListTile(
                  title: Text(snapshot.data[index].fNmae),
                  subtitle: Text(snapshot.data[index].sName),
                  contentPadding: EdgeInsets.only(bottom: 20.0),
                ),
              );
            },
          ),
        ),
      ),
    );
  }*/
