import 'package:flutter/material.dart';
import 'package:last_national_bank/utils/helpers/style.dart';

class VerificationStatus extends StatelessWidget {
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
                  TextField(),
                ]),

                // List
                ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      String textToUse = "Name : Hetstse";

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
