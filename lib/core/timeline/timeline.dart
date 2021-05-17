import 'package:flutter/material.dart';
//import 'package:last_national_bank/utils/services/online_db.dart';
import '../../classes/log.dart';

class TimelinePage extends StatefulWidget {
  @override
  _TimelineListPageState createState() => _TimelineListPageState();
}

class _TimelineListPageState extends State<TimelinePage> {
  List<Log> logs = [Log(timeStamp: "2012-01-40", logDescription: "Test 1"),
  Log(timeStamp: "2048-02-19", logDescription: "Test 2")];

  @override
  void initState() {
    super.initState();
    //TODO sheslin http request here
    /*getUnverifiedClients().then((lstNames) {
      names = lstNames;
      setState(() {});
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            //padding: EdgeInsets.all(2.0),
            child: ConstrainedBox(
              //Use MediaQuery.of(context).size.height for max Height
              constraints:
              BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                  maxHeight: MediaQuery.of(context).size.height
              ),

              // List
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: logs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        ListTile(
                          title: Text(
                            logs[index].timeStamp,
                            style: TextStyle(fontSize: 12, color: Colors.blueGrey)),
                          subtitle: Text(
                            logs[index].logDescription,
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
                  }),
            ),
          ),
        ));
  }
}