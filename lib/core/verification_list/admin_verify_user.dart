import 'package:flutter/material.dart';



class VerifyUser extends StatefulWidget {
  // MyHomePage({key key, this.title}) : super(key:key);
  @override
  _VerifyUserState createState() => _VerifyUserState();
}

class _VerifyUserState extends State<VerifyUser> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new PreferredSize(
        child: Container(
          padding: new EdgeInsets.only(
              top: MediaQuery.of(context).padding.top
          ),
          child: new Padding(
            padding: const EdgeInsets.only(
                left: 10.0,
                right: 30.0,
                top: 5.0,
                bottom: 5.0
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Verify Customer',
                  style: new TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.admin_panel_settings_rounded),
                  iconSize: 30.0,
                  color: Colors.white,
                  tooltip: 'Verification Status',
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Application: Pending')));
                  },
                ),
              ],
            ),
          ),
          decoration: new BoxDecoration(
              gradient : new LinearGradient(
                  colors: [
                    Colors.blueGrey,
                    Colors.teal
                  ]
              ),
              boxShadow: [
                new BoxShadow(
                  color: Colors.black,
                  blurRadius: 20.0,
                  spreadRadius: 1.0,
                )
              ]
          ),
        ),
        preferredSize: new Size(
            MediaQuery.of(context).size.width,
            150.0
        ),
      ),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blueGrey, Colors.teal]),
        ),
        padding: new EdgeInsets.only(
          top: 15.0,
          left: 15.0,
          right: 15.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,

          children: <Widget>[
            Icon(Icons.assignment_ind_rounded, color: Colors.white, size: 75,),
            Text(
              'Customer Information',
              style: new TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
                color: Colors.white,

              ),
            ),
            Row(

              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                    'First Name : ',
                    style: TextStyle(color: Colors.white)
                ),
                Text('Sheslin', style: TextStyle(color: Colors.white)),
              ],

            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('Last Name : ',style: TextStyle(color: Colors.white)),
                Text('Naidoo',style: TextStyle(color: Colors.white)),
              ],
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute<void>(
            builder: (BuildContext context) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Confirmation'),
                ),
                body: const Center(
                  child: Text(
                    'Are you sure you would like to verify this client?',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              );
            },
          ));
        },
        tooltip: 'Verify',
        child: Icon(Icons.app_registration),
      ),
    );
  }
}
