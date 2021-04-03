import 'package:flutter/material.dart';
import 'package:last_national_bank/config/routes/router.dart';
import 'package:last_national_bank/widgets/routeButton.dart';

class ClientRegistrationPage extends StatefulWidget {
  @override
  _ClientRegistrationPageState createState() => _ClientRegistrationPageState();
}

class _ClientRegistrationPageState extends State<ClientRegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("I == ClientPage()"),
            RouteButtonCustom(
              goTo: () => goToLogin(context),
              text: "Login",
            ),
            RouteButtonCustom(
              goTo: () {
                goToAdminRegistration(context);
              },
              text: "Admin Registration",
            ),
          ],
        ),
      ),
    );
  }
}
