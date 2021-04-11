import 'package:flutter/material.dart';

import '../../classes/name.class.dart';
import '../../utils/helpers/style.dart';
import '../../utils/services/online_db.dart';
import '../../widgets/verifyUsersTitle.dart';

class VerificationListPage extends StatefulWidget {
  @override
  _VerificationListPageState createState() => _VerificationListPageState();
}

class _VerificationListPageState extends State<VerificationListPage> {
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

  @override
  void initState() {
    super.initState();

    getUnverifiedClienta().then((lstNames) {
      names = lstNames;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blueGrey, Colors.teal]),
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
                      String textToUse = "\t\t ${names[index].fName} ";
                      if (names[index].mName != null) {
                        textToUse += names[index].mName!;
                        textToUse += " ";
                      }
                      textToUse += names[index].sName;

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
                              textToUse,
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
