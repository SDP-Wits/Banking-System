// coverage:ignore-start
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:last_national_bank/classes/accountDetails.dart';
import 'package:last_national_bank/classes/user.class.dart';
import 'package:last_national_bank/config/routes/router.dart';
import 'package:last_national_bank/constants/route_constants.dart';
import 'package:last_national_bank/core/payments/payment.functions.dart';
import 'package:last_national_bank/core/transfer/widgets/scrollAccount.dart';
import 'package:last_national_bank/utils/helpers/dialogs.dart';
import 'package:last_national_bank/utils/helpers/style.dart';
import 'package:last_national_bank/utils/services/local_db.dart';
import 'package:last_national_bank/utils/services/online_db.dart';
import 'package:last_national_bank/widgets/heading.dart';
import 'package:last_national_bank/widgets/navigation.dart';
import 'package:last_national_bank/utils/helpers/back_button_helper.dart';

// Used to determine the account chosen in both scroll widgets
int accountFromIndex = 0;

class Payments extends StatefulWidget {
  const Payments({Key? key}) : super(key: key);

  @override
  _PaymentsState createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  List<accountDetails> accountsDetails = [];
  // ignore: avoid_init_to_null
  User? user = null;
  late ScrollController controller1;

  @override
  void initState() {
    controller1 = ScrollController();
    super.initState();

    BackButtonInterceptor.add(myInterceptor);

    emptyText();
    accountFromIndex = 0;

    LocalDatabaseHelper.instance.getUserAndAddress().then((user) {
      getAccountDetails(user!.idNumber).then((accounts) {
        setState(() {
          accountsDetails = accounts;
          this.user = user;
        });
      });
    });
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    return helperInterceptor(
        context: context,
        currentRoute: PaymentRoute,
        goTo: goToSelectPayment,
        info: info,
        stopDefaultButtonEvent: stopDefaultButtonEvent);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return (user != null)
        ? Scaffold(
            key: _scaffoldKey,
            drawer: Navigation(
                clientName: user!.firstName, clientSurname: user!.lastName),
            
            body: SingleChildScrollView(
              
              child: Container(
                height: size.height * 1.2,
                decoration: BoxDecoration(
                  gradient: backgroundGradient,
                ),
                
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: Icon(Icons.menu, color: Colors.white),
                        onPressed: () {
                          _scaffoldKey.currentState!.openDrawer();
                        },
                      ),
                    ),
                    
                    Heading("Payments"),
                    
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                    ),
                    
                    Text(
                      'Select account to make payment from: ',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: fontMont,
                        fontSize: 15.0,
                      ),
                    ),
                    
                    ScrollAccount(
                      acc: accountsDetails,
                      controller: controller1,
                      setIndex: getAccountFromIndex,
                    ),
                    
                    // Spacing
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                    ),
                    
                    InputField(
                      text: "Amount",
                      child: TextField(
                        maxLines: 1,
                        decoration: inputInputDecoration,
                        controller: amountController,
                        onChanged: onChangeAmount,
                        textAlign: TextAlign.center,
                        style: inputTextStyle,
                      ),
                    ),
                    
                    InputField(
                      text: "Recipient Account Number",
                      child: TextField(
                        maxLength: 11,
                        decoration: inputInputDecoration,
                        controller: receiptentAccountNumberController,
                        onChanged: onChangeReceipent,
                        textAlign: TextAlign.center,
                        style: inputTextStyle,
                      ),
                    ),
                    
                    InputField(
                      text: "Reference Name",
                      child: TextField(
                        // maxLength: 11,
                        decoration: inputInputDecoration,
                        controller: referenceNameController,
                        onChanged: onChangeReferenceName,
                        textAlign: TextAlign.center,
                        style: inputTextStyle,
                      ),
                    ),
                    
                    TextButton(
                      // onPressed: ()=>{submitPayment(user!, accountsDetails[indexToUse])},
                      onPressed: () {
                        submitPayment(user!, accountsDetails[accountFromIndex])
                            .then((success) {
                          if (success) {
                            setState(() {
                              accountsDetails[accountFromIndex]
                                  .currentBalance -= double.parse(amountText);

                              emptyText();
                              accountFromIndex = 0;
                            });

                            goToTimelineDialog(context);
                          }
                        });
                      },
                      
                      child: Container(
                        width: size.width * 0.5,
                        padding: EdgeInsets.all(15),
                        
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black54,
                                blurRadius:
                                    10.0, // has the effect of softening the shadow
                                spreadRadius:
                                    1.0, // has the effect of extending the shadow
                                offset: Offset(
                                  5.0, // horizontal, move right 10
                                  5.0, // vertical, move down 10
                                ),
                              ),
                            ]),
                        
                        child: Text(
                          "Send",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.teal,
                            fontSize: 18.0,
                            fontFamily: fontMont,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : buildLoadingScreen(context);
  }
}

class InputField extends StatelessWidget {
  final String text;
  final Widget child;

  InputField({required this.text, required this.child});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        Container(
          width: size.width * 0.9,
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.only(
              topLeft: borderRadius,
              topRight: borderRadius,
            ),
          ),
          
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontFamily: fontMont,
              fontSize: 15.0,
            ),
          ),
        ),
        
        Container(
          width: size.width * 0.9,
          margin: EdgeInsets.only(bottom: 15.0),
          padding: EdgeInsets.all(5),
          
          decoration: BoxDecoration(
            boxShadow: [
              
              BoxShadow(
                color: Colors.white24,
                offset: Offset(4.0, 2.0), //(x,y)
                blurRadius: 6.0,
              ),
              
              BoxShadow(
                color: Colors.white24,
                offset: Offset(-4.0, 2.0), //(x,y)
                blurRadius: 6.0,
              ),
            ],
            
            color: Colors.white,
            
            borderRadius: BorderRadius.only(
              bottomLeft: borderRadius,
              bottomRight: borderRadius,
              // topRight: borderRadius,
            ),
          ),
          
          child: Container(width: (size.width * 0.9), child: child),
        ),
      ],
    );
  }
}

var inputTextStyle = TextStyle(
  color: Colors.black,
  fontFamily: fontMont,
  fontSize: 16.0,
);

var inputInputDecoration = InputDecoration(
  enabledBorder: InputBorder.none,
  focusedBorder: InputBorder.none,
);

const borderRadius = Radius.circular(15.0);

void getAccountFromIndex(int newIndex) {
  accountFromIndex = newIndex;
}
// coverage:ignore-end
