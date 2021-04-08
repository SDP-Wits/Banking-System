import 'package:flutter/material.dart';

import '../../utils/helpers/style.dart';
import '../../widgets/verifyUsersTitle.dart';
import 'verification.functions.dart';

class VerificationListPage extends StatefulWidget {
  @override
  _VerificationListPageState createState() => _VerificationListPageState();
}

class _VerificationListPageState extends State<VerificationListPage> {
  //==================================================================
  //Example data:
  List<VerificationListClass> names = [
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
  ];
  //==================================================================

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blueGrey, Colors.lightBlueAccent]),
        ),

        // Allows page to be scrollable
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: ConstrainedBox(
            //Use MediaQuery.of(context).size.height for max Height
            constraints:
                BoxConstraints(minHeight: MediaQuery.of(context).size.height),

            child: Column(
              children: <Widget>[
                // Title/heading
                Row(children: <Widget>[
                  VerifyUsersTitle(),
                ]),

                // List
                ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: names.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        color: Colors.transparent,
                        elevation: 2,
                        // Space around item box
                        margin: EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 10),

                        child: InkWell(
                          // When user clicks on item box, sonmething happens:
                          onTap: () {},

                          child: Container(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              // names i sthe name of the example array used above
                              // Will need to find outy how to use array in
                              // verification.functions.dart here
                              "\t\t" +
                                  names[index].name +
                                  ": " +
                                  names[index].id,
                              style: TextStyle(fontSize: fontSizeSmall),
                            ),
                          ),
                        ),
                      );
                    }),
              ],
            ),
          ),
        ));
  }
}
