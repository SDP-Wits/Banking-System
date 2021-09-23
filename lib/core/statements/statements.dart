import 'package:flutter/material.dart';
import 'package:last_national_bank/classes/accountTypes.dart';
import 'package:last_national_bank/core/account/accounts.dart';
import 'package:last_national_bank/core/statements/statements.function.dart';
import 'package:last_national_bank/utils/helpers/helper.dart';
import 'package:last_national_bank/utils/helpers/style.dart';
import 'package:last_national_bank/utils/services/online_db.dart';
import 'package:last_national_bank/widgets/deviceLayout.dart';
import 'package:last_national_bank/widgets/heading.dart';

class StatementsPage extends StatefulWidget {
  @override
  _StatementsPageState createState() => _StatementsPageState();
}

class _StatementsPageState extends State<StatementsPage> {
  List<accountTypes> accounts = [];
  late String selectedAccount;

  @override
  void initState() {
    super.initState();

    //TODO: accounts = await getAvaliableAccounts();
    getAccountTypes().then((_accounts) {
      setState(() {
        accounts = [..._accounts];
        selectedAccount = accounts[0].accType;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = getSize(context);
    return DeviceLayout(
      phoneLayout: (accounts.isEmpty)
          ? buildLoadingScreen(context)
          : Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
                gradient: backgroundGradient,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: Heading("Statements"),
                      margin: EdgeInsets.symmetric(vertical: 30),
                    ),
                    DropdownButton<String>(
                      value: selectedAccount,
                      onChanged: (String? accountType) {
                        setState(() {
                          if (accountType != null) {
                            selectedAccount = accountType;
                          } else {
                            selectedAccount = "";
                          }
                        });
                      },
                      style: TextStyle(
                        fontFamily: fontDefault,
                        fontSize: fontSizeSmall,
                        color: Colors.white,
                      ),
                      dropdownColor: Colors.grey,
                      items: accounts.map((e) {
                        return DropdownMenuItem<String>(
                          value: e.accType,
                          child: Text(e.accType),
                        );
                      }).toList(),
                    )
                  ],
                ),
              ),
            ),
      // ================================================================================================== //

      // ========================================== Desktop Widget ======================================= //

      // ================================================================================================== //

      desktopWidget: (accounts.isEmpty)
          ? buildLoadingScreen(context)
          : Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
                gradient: backgroundGradient,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: Heading("Statements"),
                      margin: EdgeInsets.symmetric(vertical: 30),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //Choose Account
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ...accounts.map((account) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedAccount = account.accType;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 15 + size.height * 0.015),
                                  alignment: Alignment.center,
                                  child: Container(
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      color:
                                          (selectedAccount == account.accType)
                                              ? Colors.black38
                                              : Colors.white12,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    alignment: Alignment.center,
                                    width: size.width * 0.3,
                                    child: Text(
                                      account.accType,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: fontFancy,
                                        fontSize: (size.width < tabletWidth)
                                            ? fontSizeMedium
                                            : fontSizeLarge,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(growable: false),
                            Container(
                              margin: EdgeInsets.only(bottom: 30),
                              child: TextButton(
                                onPressed: () {
                                  generatePDF();
                                },
                                child: Container(
                                  width: size.width * 0.25,
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(500),
                                    color: Colors.white70,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 1.0,
                                        offset: Offset(0, 2.5),
                                        color: Colors.black26,
                                        spreadRadius: 2.5,
                                      ),
                                    ],
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Get Statement",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: fontDefault,
                                      fontSize: fontSizeMedium,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        //Choose Date
                        Container(
                          width: size.width * 0.5,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
