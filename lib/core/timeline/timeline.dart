// coverage:ignore-start
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:last_national_bank/config/routes/router.dart';
import 'package:last_national_bank/constants/route_constants.dart';
import 'package:last_national_bank/utils/helpers/style.dart';
import 'package:last_national_bank/utils/services/local_db.dart';
import 'package:last_national_bank/utils/services/online_db.dart';
import 'package:last_national_bank/widgets/desktopNav.dart';
import 'package:last_national_bank/widgets/heading.dart';
import 'package:last_national_bank/widgets/navigation.dart';
import 'package:last_national_bank/utils/helpers/back_button_helper.dart';

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

    //Adding the back button listener
    BackButtonInterceptor.add(myInterceptor);
    if (kIsWeb) {
      BackButtonInterceptor.removeAll();
    }

    LocalDatabaseHelper.instance.getUserAndAddress().then((userDB) {
      setState(() {
        user = userDB;
      });
      //uses the local database to get the userID then makes a call to the online database to get the Logs for this user
      getLogs(user!.userID.toString()).then((logsIn) {
        setState(() {
          logs = logsIn;
          logs = logs!.reversed.toList();
        });
      });
    });
  }

  @override
  void dispose() {
    //Removing the back button listener
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  //When the back button is pressed, go to Login Page
  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    return helperInterceptor(
        context: context,
        currentRoute: TimelineRoute,
        goTo: goToProfilePage,
        info: info,
        stopDefaultButtonEvent: stopDefaultButtonEvent);
  }

  // Displays loading screen while the data loads
  @override
  Widget build(BuildContext context) {
    if (logs == null) {
      return buildLoadingScreen(context);
    } else {
      return buildPage();
    }
  }

  /*
  Builds the Timeline page which shows the users logs (transactions and actions)
  */
  Widget buildPage() {
    final Size size = MediaQuery.of(context).size;
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      drawer: Navigation(
          clientName: user!.firstName,
          clientSurname: user!.lastName,
          context: context),
      body: Container(
        width: size.width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: backgroundGradient,
        ),
        // Allows page to be scrollable
        child: SingleChildScrollView(
          // padding: EdgeInsets.all(2.0),
          child: Column(children: [
            if (MediaQuery.of(context).size.width > tabletWidth)
              DesktopTabNavigator(),
            if (MediaQuery.of(context).size.width <= tabletWidth)
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(Icons.menu, color: Colors.white),
                  onPressed: () {
                    _scaffoldKey.currentState!.openDrawer();
                  },
                ),
              ),
            ConstrainedBox(
              //Use MediaQuery.of(context).size.height for max Height
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                  maxHeight: MediaQuery.of(context).size.height),

              // List
              child: (logs!.length == 0)
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: TimelineHeading(),
                        ),
                        Container(
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
                        ),
                      ],
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: logs!.length,
                      itemBuilder: (BuildContext context, int index) {
                        Color colorToUse =
                            (logs![index].logDescription.contains("to"))
                                ? Colors.red[500]!
                                : Colors.green[600]!;
                        return Column(
                          children: [
                            (index == 0)
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 15.0),
                                    child: TimelineHeading(),
                                  )
                                : Container(
                                    width: 0,
                                    height: 0,
                                  ),
                            Container(
                              width: (size.width <= phoneWidth)
                                  ? size.width * 0.9
                                  : (size.width <= tabletWidth)
                                      ? size.width * 0.7
                                      : size.width * 0.5,
                              margin: EdgeInsets.only(top: 25),
                              padding: EdgeInsets.all(15),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white70,
                                borderRadius: BorderRadius.circular(35),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                            ),
                          ],
                        );
                      }),
            ),
          ]),
        ),
      ),
    );
  }
}

class TimelineHeading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 20),
        ),
        Heading("Timeline"),
        Padding(
          padding: EdgeInsets.only(top: 20),
        )
      ],
    );
  }
}

// coverage:ignore-end
