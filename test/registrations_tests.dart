import 'package:last_national_bank/core/registration/widgets/NewIDnum.dart';
import 'package:last_national_bank/core/registration/widgets/NewLoc.dart';
import 'package:last_national_bank/core/registration/widgets/NewPassword.dart';
import 'package:last_national_bank/core/registration/widgets/NewPassword2.dart';
import 'package:last_national_bank/core/registration/widgets/NewPhone.dart';
import 'package:last_national_bank/core/registration/widgets/newEmail.dart';
import 'package:last_national_bank/core/registration/widgets/newName.dart';
import 'package:last_national_bank/widgets/Secret.dart';
import "package:test/test.dart";
import "package:last_national_bank/core/registration/registration.functions.dart";
import "package:last_national_bank/core/registration/widgets/NewAge.dart";

void main(){
  group('testing registration page fullvalidation in registran.functions.dart',(){
    //setting values that are valid
    test('test to check validation works',(){

      Data.password1 = "password";
      Data.password2 = "password";
      Data.name = "Tristan Declan";
      Data.surname = "Bookhan";
      Data.email = "tristanbookhan@gmail.com";
      Data.idnum = "0123456789101";
      Data.loc = "62 Pine Road";
      Data.phone = "0123456789";
      Data.age = 21;

      var expected = true;

      var actual = fullvalidation();

      expect(actual,expected);
    });

    //testing for invalid data

    //invalid passwords

    test('test to check for non-matching passwords',(){

      Data.password1 = "passwor";
      Data.password2 = "password";
      Data.name = "Tristan Declan";
      Data.surname = "Bookhan";
      Data.email = "tristanbookhan@gmail.com";
      Data.idnum = "0123456789101";
      Data.loc = "62 Pine Road";
      Data.phone = "0123456789";
      Data.age = 21;


      var expected = false;

      var actual = fullvalidation();

      expect(actual,expected);
    });

    //invalid name
    test('test to check for valid name',(){

      Data.password1 = "password";
      Data.password2 = "password";
      Data.name = "";
      Data.surname = "Bookhan";
      Data.email = "tristanbookhan@gmail.com";
      Data.idnum = "0123456789101";
      Data.loc = "62 Pine Road";
      Data.phone = "0123456789";
      Data.age = 21;

      var expected = false;

      var actual = fullvalidation();

      expect(actual,expected);
    });

    //invalid surname
    test('test to check validation works',(){

      Data.password1 = "password";
      Data.password2 = "password";
      Data.name = "Tristan Declan";
      Data.surname = "";
      Data.email = "tristanbookhan@gmail.com";
      Data.idnum = "0123456789101";
      Data.loc = "62 Pine Road";
      Data.phone = "0123456789";
      Data.age = 21;

      var expected = false;

      var actual = fullvalidation();

      expect(actual,expected);
    });

    //invalid email
    test('test to check for invalid email',(){

      Data.password1 = "password";
      Data.password2 = "password";
      Data.name = "Tristan Declan";
      Data.surname = "Bookhan";
      Data.email = "tristanbookhangmailcom";
      Data.idnum = "0123456789101";
      Data.loc = "62 Pine Road";
      Data.phone = "0123456789";
      Data.age = 21;

      var expected = false;

      var actual = fullvalidation();

      expect(actual,expected);
    });

    //invalid id number
    test('test to check for invalid ID number',(){

      Data.password1 = "password";
      Data.password2 = "password";
      Data.name = "Tristan Declan";
      Data.surname = "Bookhan";
      Data.email = "tristanbookhan@gmail.com";
      Data.idnum = "";
      Data.loc = "62 Pine Road";
      Data.phone = "0123456789";
      Data.age = 21;

      var expected = false;

      var actual = fullvalidation();

      expect(actual,expected);
    });

    //invalid location
    test('test to check for invalid location',(){

      Data.password1 = "password";
      Data.password2 = "password";
      Data.name = "Tristan Declan";
      Data.surname = "Bookhan";
      Data.email = "tristanbookhan@gmail.com";
      Data.idnum = "0123456789101";
      Data.loc = "";
      Data.phone = "0123456789";
      Data.age = 21;

      var expected = false;

      var actual = fullvalidation();

      expect(actual,expected);
    });

    //invalid phone number
    test('test to check for invalid phone number',(){

      Data.password1 = "password";
      Data.password2 = "password";
      Data.name = "Tristan Declan";
      Data.surname = "Bookhan";
      Data.email = "tristanbookhan@gmail.com";
      Data.idnum = "0123456789101";
      Data.loc = "62 Pine Road";
      Data.phone = "";
      Data.age = 21;

      var expected = false;

      var actual = fullvalidation();

      expect(actual,expected);
    });

    //invalid age negative
    test('test to check for valid age',(){

      Data.password1 = "password";
      Data.password2 = "password";
      Data.name = "Tristan Declan";
      Data.surname = "Bookhan";
      Data.email = "tristanbookhan@gmail.com";
      Data.idnum = "0123456789101";
      Data.loc = "62 Pine Road";
      Data.phone = "0123456789";
      Data.age = -1 ;

      var expected = false;

      var actual = fullvalidation();

      expect(actual,expected);
    });

    //invalid age <12>
    test('test to check for valid age',(){

      Data.password1 = "password";
      Data.password2 = "password";
      Data.name = "Tristan Declan";
      Data.surname = "Bookhan";
      Data.email = "tristanbookhan@gmail.com";
      Data.idnum = "0123456789101";
      Data.loc = "62 Pine Road";
      Data.phone = "0123456789";
      Data.age = 6 ;

      var expected = false;

      var actual = fullvalidation();

      expect(actual,expected);
    });

    //testing giveError function
    //valid
    test('test to check for valid data',(){
      Data.password1 = "password";
      Data.password2 = "password";
      Data.name = "Tristan Declan";
      Data.surname = "Bookhan";
      Data.email = "tristanbookhan@gmail.com";
      Data.idnum = "0123456789101";
      Data.loc = "62 Pine Road";
      Data.phone = "0123456789";
      Data.age = 21;
      var expected = "Proceed to next page";

      var actual = giveError();

      expect(actual,expected);
    });
    //invalid
    test('test to check for invalid data',(){

      Data.password1 = "password";
      Data.password2 = "password";
      Data.name = "Tristan Declan";
      Data.surname = "Bookhan";
      Data.email = "tristanbookhan@gmail.com";
      Data.idnum = "012345678910";
      Data.loc = "62 Pine Road";
      Data.phone = "0123456789";
      Data.age = 21;

      var expected = "Some Fields Have Errors";

      var actual = giveError();

      expect(actual,expected);
    });
  });

  group('testing validator for newage.dart',(){
    //valid
    test('test to check for valid age',(){
      var expected = false;

      var actual = hasInputErrorAge(21);

      expect(actual,expected);
    });
    //invalid
    test('test to check for invalid age',(){
      var expected = true;

      var actual = hasInputErrorAge(2);

      expect(actual,expected);
    });
  });

  group('testing validator for newEmail.dart',(){
    //valid
    test('test to check for valid email',(){
      var expected = false;

      var actual = hasInputErrorEmail("tristanbookhan@gmail.com");

      expect(actual,expected);
    });
    //invalid
    test('test to check for invalid email',(){
      var expected = true;

      var actual = hasInputErrorEmail("tristanbookhangmailcom");

      expect(actual,expected);
    });
  });

  group('testing validator for newIDnum.dart',(){
    //valid
    test('test to check for valid ID number',(){
      var expected = false;

      var actual = hasInputErrorId("0123456789101");

      expect(actual,expected);
    });
    //invalid
    test('test to check for invalid ID number without enough numbers',(){
      var expected = true;

      var actual = hasInputErrorId("012345678910");

      expect(actual,expected);
    });
    //invalid
    test('test to check for invalid ID number with a letter',(){
      var expected = true;

      var actual = hasInputErrorId("012345678910a");

      expect(actual,expected);
    });
  });

  group('testing validator for NewLoc.dart',(){
    //valid
    test('test to check for valid location name',(){
      var expected = false;

      var actual = hasInputErrorLoc("address");

      expect(actual,expected);
    });
    //invalid
    test('test to check for invalid location name',(){
      var expected = true;

      var actual = hasInputErrorLoc("");

      expect(actual,expected);
    });
    //valid
    test('test to check for valid number',(){
      var expected = false;

      var actual = hasInputErrorInt("0");

      expect(actual,expected);
    });
    //invalid
    test('test to check for invalid number',(){
      var expected = true;

      var actual = hasInputErrorInt("hello");

      expect(actual,expected);
    });
  });

  group('testing validator for NewName.dart',(){
    //valid
    test('test to check for valid name',(){
      var expected = false;

      var actual = hasInputErrorName("John");

      expect(actual,expected);
    });
    //invalid
    test('test to check for invalid name',(){
      var expected = true;

      var actual = hasInputErrorName("");

      expect(actual,expected);
    });
  });

  group('testing validator for NewPassword.dart',(){
    //valid
    test('test to check for valid password',(){
      var expected = false;

      var actual = hasInputErrorsPassword1("John@123");

      expect(actual,expected);
    });
    //invalid no uppercase
    test('test to check for invalid name without uppercase',(){
      var expected = true;

      var actual = hasInputErrorsPassword1("john@123");

      expect(actual,expected);
    });
    //invalid no lowercase
    test('test to check for invalid name without lowercase',(){
      var expected = true;

      var actual = hasInputErrorsPassword1("JOHN@123");

      expect(actual,expected);
    });
    //invalid no number
    test('test to check for invalid name without numbers',(){
      var expected = true;

      var actual = hasInputErrorsPassword1("John@");

      expect(actual,expected);
    });
    //invalid no special character
    test('test to check for invalid name without special character',(){
      var expected = true;

      var actual = hasInputErrorsPassword1("John123");

      expect(actual,expected);
    });
  });

  group('testing validator for NewPassword2.dart',(){
    //valid
    test('test to check for valid password2',(){
      Data.password1 = "John@123";

      var expected = false;

      var actual = hasInputErrorsPassword2("John@123");

      expect(actual,expected);
    });
    //invalid
    test('test to check for invalid password2',(){
      Data.password1 = "John@123";
      var expected = true;

      var actual = hasInputErrorsPassword2("JOhn@123");

      expect(actual,expected);
    });
  });

  group('testing validator for NewPhone.dart',(){
    //valid
    test('test to check for valid phone number',(){

      var expected = false;

      var actual = hasInputErrorPhone("0123456789");

      expect(actual,expected);
    });
    //invalid
    test('test to check for invalid phone number without enough numbers',(){
      var expected = true;

      var actual = hasInputErrorPhone("012345678");

      expect(actual,expected);
    });
    test('test to check for invalid phone number with a character in it',(){
      var expected = true;

      var actual = hasInputErrorPhone("012345678a");

      expect(actual,expected);
    });
  });

  group('testing validator for NewSurname.dart',(){
    //valid
    test('test to check for valid surname',(){
      var expected = false;

      var actual = hasInputErrorName("Doe");

      expect(actual,expected);
    });
    //invalid
    test('test to check for invalid surname',(){
      var expected = true;

      var actual = hasInputErrorName("");

      expect(actual,expected);
    });
  });

  group('testing validator for Secret.dart',(){
    //valid
    test('test to check for valid secret key',(){
      var expected = false;

      var actual = hasInputErrorsSecret("NotSecretKey");

      expect(actual,expected);
    });
    //invalid
    test('test to check for invalid secret key',(){
      var expected = true;

      var actual = hasInputErrorsSecret("");

      expect(actual,expected);
    });
  });

}