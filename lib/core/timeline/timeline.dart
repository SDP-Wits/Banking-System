import 'package:flutter/material.dart';
import 'package:last_national_bank/utils/helpers/style.dart';
import 'package:last_national_bank/utils/services/local_db.dart';
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
    return Scaffold(
        drawer: Navigation(
            clientName: user!.firstName, clientSurname: user!.lastName),
        appBar: new PreferredSize(
          child: Container(
            padding:
                new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: new Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 30.0, top: 5.0, bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Timeline',
                    style: new TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            decoration: new BoxDecoration(
                gradient:
                    new LinearGradient(colors: [Colors.blueGrey, Colors.teal]),
                boxShadow: [
                  new BoxShadow(
                    color: Colors.black,
                    blurRadius: 20.0,
                    spreadRadius: 1.0,
                  )
                ]),
          ),
          preferredSize: new Size(MediaQuery.of(context).size.width, 150.0),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blueGrey, Colors.teal]),
          ),

          // Allows page to be scrollable
          child: SingleChildScrollView(
            // padding: EdgeInsets.all(2.0),
            child: ConstrainedBox(
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
                      return Column(
                        children: [
                          ListTile(
                            title: Text(logs![index].timeStamp.split(" ")[0],
                                style: TextStyle(
                                    fontSize: 12, color: Colors.blueGrey)),
                            subtitle: Text(logs![index].logDescription,
                                style: TextStyle(fontSize: 16)),
                            tileColor: Colors.white,
                          ),
                          const Divider(
                            color: Colors.black26,
                            height: 0,
                            thickness: 1,
                            indent: 0,
                            endIndent: 0,
                          ),
                        ],
                      );
                    }
                  }),
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
