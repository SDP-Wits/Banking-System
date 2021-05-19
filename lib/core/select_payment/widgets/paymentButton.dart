import 'package:flutter/material.dart';
import 'package:last_national_bank/utils/helpers/style.dart';
import 'package:last_national_bank/utils/helpers/icons.dart';
import 'package:animate_do/animate_do.dart';

// ignore: camel_case_types
class paymentButton extends StatefulWidget {
  final Function onTap;
  final String buttonTitle;
  final String buttonDescription;
  final IconData? buttonIcon;

  // Pass in parameters so that two different buttons can be created using same widget
  paymentButton({required this.onTap, required this.buttonDescription, required this.buttonTitle, required this.buttonIcon});

  @override
  _paymentButtonState createState() => _paymentButtonState();
}


// ignore: camel_case_types
class _paymentButtonState extends State<paymentButton> {
  
  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        bottom: 20,
        right: 1,
      ),

      child: Container(
        // Width, height and allignment of button
        alignment: Alignment.center,
        height: 200,
        width: 360,
        // Shadows of button
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 8.0, // has the effect of softening the shadow
              spreadRadius: 0.5, // has the effect of extending the shadow
              offset: Offset(
                5.0, // horizontal, move right 10
                5.0, // vertical, move down 10
              ),
            ),
          ],

          // Colour and radius of button
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),

        
        child: TextButton(

          // Getting onTap from parameter - when button is clicked, do..
          onPressed: () {
            this.widget.onTap();
          },

          // Column: Title, Description, Animations
          child: Column(
            
            children: <Widget>[

              // TITLE
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 20,
                  ),

                  child: Text(
                    widget.buttonTitle, // Parameter                  
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 30,
                      fontFamily: fontMont,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                ),
              ),

              // DESCRIPTION                
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 30,
                  ),

                  child: Text(
                    widget.buttonDescription, // Parameter                    
                      style: TextStyle(
                        color: Colors.teal,
                        fontSize: 15,
                        fontFamily: fontMont,
                      ),
                  ),

                ),
              ),

              // ANIMATIONS
              Row(
                children: [

                  // First icon
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 30,
                        left: 80,
                      ),

                      child: Icon(
                        widget.buttonIcon,
                        color: Colors.black,
                        size: 35.0,                
                      ),

                    ),
                  ),

                  // Animated icon
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        left: 60,
                      ),

                      child: FadeInLeft(
                        child: Money(), // Create widget (below)
                        duration: const Duration(milliseconds: 3000),
                        from: (75), // Start position
                        delay: const Duration(milliseconds: 500),
                      ),

                    ),
                  ),

                  // Last icon
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 30,
                        left: 0,
                      ),

                      child: Icon(
                        widget.buttonIcon,
                        color: Colors.black,
                        size: 35.0,                
                      ),

                    ),
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

// Create animiation icon
class Money extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 50,
      height: 50,
      child: Icon(
          iconFamily.money_bill_wave,
          color: Colors.green,
          size: 20.0,                
      ),
    );
  }
}
