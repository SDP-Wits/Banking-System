// coverage:ignore-start
import 'package:flutter/material.dart';
import 'package:last_national_bank/classes/user.class.dart';
import 'package:last_national_bank/config/routes/router.dart';
import 'package:last_national_bank/utils/helpers/style.dart';
import 'package:last_national_bank/utils/services/local_db.dart';
import 'package:last_national_bank/widgets/navigation.dart';

class NoAccount extends StatefulWidget {
  const NoAccount({Key? key}) : super(key: key);

  @override
  _NoAccountState createState() => _NoAccountState();
}

class _NoAccountState extends State<NoAccount> {
  // ignore: avoid_init_to_null
  User? user = null;

  @override
  void initState() {
    LocalDatabaseHelper.instance.getUserAndAddress().then((user) {
      setState(() {
        this.user = user;
      });
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return (user == null)
        ? buildLoadingScreen(context)
        : Scaffold(
            drawer: Navigation(
                clientName: user!.firstName, clientSurname: user!.lastName),
            body: Container(
              decoration: BoxDecoration(
                gradient: backgroundGradient,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 90.0),
                      child: Text(
                        "No Accounts here...",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: fontMont,
                          fontSize: 40,
                          color: Colors.teal,
                        ),
                      ),
                    ),
                  ),
                  floatingCreateAccount(context),
                ],
              ),
            ),
          );
  }
}

Widget floatingCreateAccount(BuildContext context) {
  return Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: FloatingActionButton(
            backgroundColor: Colors.white,
            child: Text(
              '+',
              style: TextStyle(
                color: Colors.teal,
                fontSize: 36,
                fontFamily: fontMont,
              ),
            ),
            onPressed: () {
              //When floating action button is pressed
              //this will go to 'create account' page
              goToCreateAccount(context);
            }),
      ),
    ],
  );
}
// coverage:ignore-end
