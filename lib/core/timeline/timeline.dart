// coverage:ignore-start
import 'package:flutter/material.dart';
import 'package:last_national_bank/utils/helpers/style.dart';
import 'package:last_national_bank/utils/services/local_db.dart';
import 'package:last_national_bank/widgets/heading.dart';
import 'package:last_national_bank/widgets/navigation.dart';
import 'package:last_national_bank/utils/services/online_db.dart';
import '../../classes/log.dart';
import '../../classes/user.class.dart';

class TimelinePage extends StatefulWidget {
  @override
  _TimelineListPageState createState() => _TimelineListPageState();
}

class _TimelineListPageState extends State<TimelinePage> {
  User? user;
  List<Log>? logs;

  @override
  void initState() {
    super.initState();
    LocalDatabaseHelper.instance.getUserAndAddress().then((userDB) {
      setState(() {
        user = userDB;
      });
      getLogs(user!.userID.toString()).then((logsIn) {
        setState(() {
          logs = logsIn;
          logs = logs!.reversed.toList();
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (logs == null) {
      return _buildLoadingScreen();
    } else {
      return buildPage();
    }
  }

  Widget buildPage() {
    final Size size = MediaQuery.of(context).size;
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
        key: _scaffoldKey,
        drawer: Navigation(
            clientName: user!.firstName, clientSurname: user!.lastName
        ),
        body: Container(
          width: size.width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blueGrey, Colors.teal]),
          ),

          // Allows page to be scrollable
          child: Container(
            width: size.width * 0.9,
            alignment: Alignment.center,
            child: SingleChildScrollView(
              // padding: EdgeInsets.all(2.0),
              child: Column(
                
                children: [

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
                    padding: EdgeInsets.only(top: 20),
                  ),
                  Heading("Timeline"),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                  ),

                  ConstrainedBox(
                    //Use MediaQuery.of(context).size.height for max Height
                    constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height,
                        maxHeight: MediaQuery.of(context).size.height),

                    // List
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: (logs!.length == 0) ? 1 : logs!.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (logs!.length == 0) {
                            return Container(
                              width: size.width,
                              height: size.height,
                              child: Center(
                                child: Text(
                                  "No Recent Activity",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                      fontFamily: fontMont),
                                ),
                              ),
                            );
                          } else {
                            Color colorToUse =
                                (logs![index].logDescription.contains("to"))
                                    ? Colors.red[500]!
                                    : Colors.green[600]!;
                            return Container(
                              width: size.width * 0.8,
                              margin: EdgeInsets.only(top: 25),
                              padding: EdgeInsets.all(15),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white70,
                                borderRadius: BorderRadius.circular(35),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    logs![index].timeStamp.split(" ")[0],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: fontMont,
                                      color: Colors.blueGrey[800]!,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(top: 5)),
                                  Text(
                                    logs![index].logDescription,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: fontMont,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: colorToUse,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        }),
                  ),
                ]
              ),
              
              
              
              
              
            ),
          ),
        ));
  }
}

Widget _buildLoadingScreen() {
  return Center(
    child: Container(
      // decoration: BoxDecoration(
      //   gradient: LinearGradient(
      //       begin: Alignment.topRight,
      //       end: Alignment.bottomLeft,
      //       colors: [Colors.blueGrey, Colors.teal]),
      // ),
      width: 50,
      height: 50,
      child: CircularProgressIndicator(),
    ),
  );
}
// coverage:ignore-end
