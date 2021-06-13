// coverage:ignore-start
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:last_national_bank/utils/services/online_db.dart';
import 'package:last_national_bank/widgets/heading.dart';

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
    final size = MediaQuery.of(context).size;
    return Scaffold(
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
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      VerifyUser(names[index].IDnum),
                                ),
                              );
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
