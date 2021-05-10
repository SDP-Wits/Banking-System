import 'package:flutter/material.dart';

import '../../classes/name.class.dart';
import '../../utils/helpers/style.dart';
import '../../utils/services/online_db.dart';
import 'admin_verify_user.dart';

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

    getUnverifiedClients().then((lstNames) {
      names = lstNames;
      setState(() {});
    });
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
                    'Verify Client',
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
            padding: EdgeInsets.all(10.0),
            child: ConstrainedBox(
              //Use MediaQuery.of(context).size.height for max Height
              constraints:
                  BoxConstraints(minHeight: MediaQuery.of(context).size.height),

              // child: Column(
              //   children: <Widget>[
              //     // Title/heading
              //     Row(children: <Widget>[
              //       VerifyUsersTitle(),
              //     ]),

              // List
              child: ListView.builder(
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
                      elevation: 1,
                      // shadowColor: Colors.transparent,
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(15.0),
                      // ),

                      // Space around item box
                      // margin: EdgeInsets.symmetric(
                      //     vertical: 20.0, horizontal: 10),

                      child: InkWell(
                        // When user clicks on item box, sonmething happens:
                        // customBorder: Border.all(color: Colors.white, width: 2),
                        onTap: () {
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => admin_verify_user(Name: names[index])) );
                          // Fluttertoast.showToast(
                          //     msg: names[index].IDnum,
                          //     toastLength: Toast.LENGTH_SHORT,
                          //     gravity: ToastGravity.CENTER,
                          //     timeInSecForIosWeb: 3,
                          //     backgroundColor: Colors.teal,
                          //     textColor: Colors.white,
                          //     fontSize: 16.0);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  VerifyUser(names[index].IDnum),
                            ),
                          );
                        },

                        child: Container(
                          // color:Colors.transparent,

                          padding: EdgeInsets.all(15),
                          child: Text(
                            // names i sthe name of the example array used above
                            // Will need to find outy how to use array in
                            // verification.functions.dart here
                            textToUse,
                            style: TextStyle(
                                fontSize: fontSizeSmall, color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  }),
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
