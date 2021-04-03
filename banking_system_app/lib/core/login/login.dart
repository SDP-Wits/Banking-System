import 'package:flutter/material.dart';
import 'package:last_national_bank/config/routes/router.dart';
import 'package:last_national_bank/widgets/routeButton.dart';
import './login.functions.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Login Page is what I am :)"),
            RouteButtonCustom(
              goTo: () {
                goToAdminRegistration(context);
              },
              text: "Admin Registration",
            ),
            RouteButtonCustom(
              goTo: () {
                goToClientRegistration(context);
              },
              text: "Client Registration",
            ),
          ],
        ),
      ),
    );
  }
}
