import 'package:flutter_test/flutter_test.dart';
import 'package:last_national_bank/constants/database_constants.dart';
import 'package:last_national_bank/core/SHA-256_encryption.dart';
import 'package:last_national_bank/core/registration/widgets/NewSurname.dart';
import 'package:last_national_bank/utils/services/online_db.dart';
import 'package:last_national_bank/core/registration/widgets/NewIDnum.dart';
import 'package:last_national_bank/core/registration/widgets/NewLoc.dart';
import 'package:last_national_bank/core/registration/widgets/NewPassword.dart';
import 'package:last_national_bank/core/registration/widgets/NewPassword2.dart';
import 'package:last_national_bank/core/registration/widgets/NewPhone.dart';
import 'package:last_national_bank/core/registration/widgets/newEmail.dart';
import 'package:last_national_bank/core/registration/widgets/newName.dart';
import 'package:last_national_bank/widgets/Secret.dart';
import "package:last_national_bank/core/registration/registration.functions.dart";
import "package:last_national_bank/core/registration/widgets/NewAge.dart";
import 'package:last_national_bank/utils/helpers/helper.dart';
import 'package:last_national_bank/utils/services/online_db.dart';
import 'package:last_national_bank/utils/helpers/db_helper.dart';
import 'package:last_national_bank/utils/helpers/helper.dart';
import 'package:last_national_bank/core/login/login.functions.dart';
import 'dart:async';
import 'package:last_national_bank/utils/services/online_db.dart';
import 'package:last_national_bank/classes/accountTypes.dart';
import 'dart:math';

void main() {
  List<String> phpNames = ["id", "password"];
  List<String> inputVariables = ["1234567891234", "thisisahashpassword"];

  test("Testing to see if argument maker works properly", () {
    expect(argumentMaker(phpNames: phpNames, inputVariables: inputVariables),
        "?id=1234567891234&password=thisisahashpassword");
  });

  group('testing registration page fullvalidation in registran.functions.dart',
      () {
    //setting values that are valid
    test('test to check validation works', () {
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

      expect(actual, expected);
    });

    //testing for invalid data

    //invalid passwords

    test('test to check for non-matching passwords', () {
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

      expect(actual, expected);
    });

    test('Test to see if hasInputError in surname work', () {
      bool expected = true;
      bool actual = hasInputErrorSurname("");

      expect(actual, expected);
    });

    test('Test to see if hasInputError in surname work', () {
      bool expected = false;
      bool actual = hasInputErrorSurname("someFancyPassword");

      expect(actual, expected);
    });

    //invalid name
    test('test to check for valid name', () {
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

      expect(actual, expected);
    });

    //invalid surname
    test('test to check validation works', () {
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

      expect(actual, expected);
    });

    //invalid email
    test('test to check for invalid email', () {
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

      expect(actual, expected);
    });

    //invalid id number
    test('test to check for invalid ID number', () {
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

      expect(actual, expected);
    });

    //invalid location
    test('test to check for invalid location', () {
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

      expect(actual, expected);
    });

    //invalid phone number
    test('test to check for invalid phone number', () {
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

      expect(actual, expected);
    });

    //invalid age negative
    test('test to check for valid age', () {
      Data.password1 = "password";
      Data.password2 = "password";
      Data.name = "Tristan Declan";
      Data.surname = "Bookhan";
      Data.email = "tristanbookhan@gmail.com";
      Data.idnum = "0123456789101";
      Data.loc = "62 Pine Road";
      Data.phone = "0123456789";
      Data.age = -1;

      var expected = false;

      var actual = fullvalidation();

      expect(actual, expected);
    });

    //invalid age <12>
    test('test to check for valid age', () {
      Data.password1 = "password";
      Data.password2 = "password";
      Data.name = "Tristan Declan";
      Data.surname = "Bookhan";
      Data.email = "tristanbookhan@gmail.com";
      Data.idnum = "0123456789101";
      Data.loc = "62 Pine Road";
      Data.phone = "0123456789";
      Data.age = 6;

      var expected = false;

      var actual = fullvalidation();

      expect(actual, expected);
    });

    //testing giveError function
    //valid
    test('test to check for valid data', () {
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

      expect(actual, expected);
    });
    //invalid
    test('test to check for invalid data', () {
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

      expect(actual, expected);
    });
  });

  group('testing validator for newage.dart', () {
    //valid
    test('test to check for valid age', () {
      var expected = false;

      var actual = hasInputErrorAge(21);

      expect(actual, expected);
    });
    //invalid
    test('test to check for invalid age', () {
      var expected = true;

      var actual = hasInputErrorAge(2);

      expect(actual, expected);
    });
  });

  group('testing validator for newEmail.dart', () {
    //valid
    test('test to check for valid email', () {
      var expected = false;

      var actual = hasInputErrorEmail("tristanbookhan@gmail.com");

      expect(actual, expected);
    });
    //invalid
    test('test to check for invalid email', () {
      var expected = true;

      var actual = hasInputErrorEmail("tristanbookhangmailcom");

      expect(actual, expected);
    });
  });

  group('testing validator for newIDnum.dart', () {
    //valid
    test('test to check for valid ID number', () {
      var expected = false;

      var actual = hasInputErrorId("0123456789101");

      expect(actual, expected);
    });
    //invalid
    test('test to check for invalid ID number without enough numbers', () {
      var expected = true;

      var actual = hasInputErrorId("012345678910");

      expect(actual, expected);
    });
    //invalid
    test('test to check for invalid ID number with a letter', () {
      var expected = true;

      var actual = hasInputErrorId("012345678910a");

      expect(actual, expected);
    });
  });

  group('testing validator for NewLoc.dart', () {
    //valid
    test('test to check for valid location name', () {
      var expected = false;

      var actual = hasInputErrorLoc("address");

      expect(actual, expected);
    });
    //invalid
    test('test to check for invalid location name', () {
      var expected = true;

      var actual = hasInputErrorLoc("");

      expect(actual, expected);
    });
    //valid
    test('test to check for valid number', () {
      var expected = false;

      var actual = hasInputErrorInt("0");

      expect(actual, expected);
    });
    //invalid
    test('test to check for invalid number', () {
      var expected = true;

      var actual = hasInputErrorInt("hello");

      expect(actual, expected);
    });
  });

  group('testing validator for NewName.dart', () {
    //valid
    test('test to check for valid name', () {
      var expected = false;

      var actual = hasInputErrorName("John");

      expect(actual, expected);
    });
    //invalid
    test('test to check for invalid name', () {
      var expected = true;

      var actual = hasInputErrorName("");

      expect(actual, expected);
    });
  });

  group('testing validator for NewPassword.dart', () {
    //valid
    test('test to check for valid password', () {
      var expected = false;

      var actual = hasInputErrorsPassword1("John@123");

      expect(actual, expected);
    });
    //invalid no uppercase
    test('test to check for invalid name without uppercase', () {
      var expected = true;

      var actual = hasInputErrorsPassword1("john@123");

      expect(actual, expected);
    });
    //invalid no lowercase
    test('test to check for invalid name without lowercase', () {
      var expected = true;

      var actual = hasInputErrorsPassword1("JOHN@123");

      expect(actual, expected);
    });
    //invalid no number
    test('test to check for invalid name without numbers', () {
      var expected = true;

      var actual = hasInputErrorsPassword1("John@");

      expect(actual, expected);
    });
    //invalid no special character
    test('test to check for invalid name without special character', () {
      var expected = true;

      var actual = hasInputErrorsPassword1("John123");

      expect(actual, expected);
    });
  });

  group('testing validator for NewPassword2.dart', () {
    //valid
    test('test to check for valid password2', () {
      Data.password1 = "John@123";

      var expected = false;

      var actual = hasInputErrorsPassword2("John@123");

      expect(actual, expected);
    });
    //invalid
    test('test to check for invalid password2', () {
      Data.password1 = "John@123";
      var expected = true;

      var actual = hasInputErrorsPassword2("JOhn@123");

      expect(actual, expected);
    });
  });

  group('testing validator for NewPhone.dart', () {
    //valid
    test('test to check for valid phone number', () {
      var expected = false;

      var actual = hasInputErrorPhone("0123456789");

      expect(actual, expected);
    });
    //invalid
    test('test to check for invalid phone number without enough numbers', () {
      var expected = true;

      var actual = hasInputErrorPhone("012345678");

      expect(actual, expected);
    });
    test('test to check for invalid phone number with a character in it', () {
      var expected = true;

      var actual = hasInputErrorPhone("012345678a");

      expect(actual, expected);
    });
  });

  group('testing validator for NewSurname.dart', () {
    //valid
    test('test to check for valid surname', () {
      var expected = false;

      var actual = hasInputErrorName("Doe");

      expect(actual, expected);
    });
    //invalid
    test('test to check for invalid surname', () {
      var expected = true;

      var actual = hasInputErrorName("");

      expect(actual, expected);
    });
  });

  group('testing validator for Secret.dart', () {
    //valid
    test('test to check for valid secret key', () {
      var expected = false;

      var actual = hasInputErrorsSecret("NotSecretKey");

      expect(actual, expected);
    });
    //invalid
    test('test to check for invalid secret key', () {
      var expected = true;

      var actual = hasInputErrorsSecret("");

      expect(actual, expected);
    });
  });

  test("Testing to see if seperateCardNumber works properly", () {
    String cardNumberUnspaced = "1234567891011234";
    String cardNumberSpaced = "1234 5678 9101 1234";

    expect(seperateCardNumber(cardNumberUnspaced), cardNumberSpaced);
  });

  test('test to check for null string', () {
    var expected = "null";

    var actual = doubleQuote(null);

    expect(actual, expected);
  });
  //invalid
  test('test to check for non null string', () {
    var expected = '"Hello"';

    var actual = doubleQuote("Hello");

    expect(actual, expected);
  });

  group('testing validator for login.functions.dart', () {
    //valid
    test('test to check for valid ID number', () {
      var expected = false;

      var actual = hasInputErrorID("0123456789101");

      expect(actual, expected);
    });
    //invalid
    test('test to check for invalid ID number with out enough numbers', () {
      var expected = true;

      var actual = hasInputErrorID("012345678910");

      expect(actual, expected);
    });
    //invalid
    test('test to check for invalid ID number with a letter', () {
      var expected = true;

      var actual = hasInputErrorID("012345678910a");

      expect(actual, expected);
    });

    //encryption
    test('test to check for successful hashing', () {
      String expected =
          "c23d874b10104bf157fef0fe71991615d99a8823d1eee7f8ab0dd30e953dd6df";

      String actual = encode("Joker@123");

      expect(actual, expected);
    });
  });

  group('testing password validator', () {
    //valid
    test('test to check for valid password', () {
      var expected = false;

      var actual = hasInputErrorsPassword("John@123");

      expect(actual, expected);
    });
    //invalid no uppercase
    test('test to check for invalid name without uppercase', () {
      var expected = true;

      var actual = hasInputErrorsPassword("john@123");

      expect(actual, expected);
    });
    //invalid no lowercase
    test('test to check for invalid name without lowercase', () {
      var expected = true;

      var actual = hasInputErrorsPassword("JOHN@123");

      expect(actual, expected);
    });
    //invalid no number
    test('test to check for invalid name without numbers', () {
      var expected = true;

      var actual = hasInputErrorsPassword("John@");

      expect(actual, expected);
    });
    //invalid no special character
    test('test to check for invalid name without special character', () {
      var expected = true;

      var actual = hasInputErrorsPassword("John123");

      expect(actual, expected);
    });
  });

  test('test for calling bank account types', () async {
    //adding expected data

    List<accountTypes> bankAccTypes = [];
    accountTypes accOption = accountTypes(
      accType: "Savings Account",
      accDescription:
          "This offers you a basic banking service with which you can make purchases and withdrawals.",
      accountTypeId: 1,
    );
    bankAccTypes.add(accOption);
    accOption = accountTypes(
      accType: "Current Account",
      accDescription:
          "Get easy access to your money for day-to-day expenses. You get different types of cards depending on your income bracket.",
      accountTypeId: 2,
    );
    bankAccTypes.add(accOption);
    accOption = accountTypes(
      accType: "Fixed Deposit Account",
      accDescription:
          "A savings account that you can only access when giving a certain amount of days notice. Earn more interest the longer you save.",
      accountTypeId: 3,
    );
    bankAccTypes.add(accOption);
    accOption = accountTypes(
      accType: "Business Account",
      accDescription: "A bank account for your business daily banking.",
      accountTypeId: 4,
    );
    bankAccTypes.add(accOption);

    //randomly checking a specific index to make sure it returns the right data
    Random random = new Random();
    int i = random.nextInt(4);

    var expected = bankAccTypes[i].accDescription;

    var actual = await getAccountTypes();
    // print(actual);

    expect(actual[i].accDescription, expected);
  });

  group('testing http request userLoginOnline', ()  {
    // //valid
    // test('test to check for valid user', () async {
    //   //TestWidgetsFlutterBinding.ensureInitialized();
    //   var expected = [{"clientID":"48","email":"0@gmail.com","phoneNumber":"0000000000","idNumber":"0000000000000","password":"3875034e17855bac03a3cc9e107b1d28a9b44313d381c3335588525b4e70b55b","age":"21","firstName":"Test","middleName":"","lastName":"User ","verificationStatus":"Pending","streetName":"Name","streetNumber":"0","suburb":"Suburb","province":"Province","country":"South Africa","apartmentNumber":"0"}];
    //
    //   var actual = await userLoginOnline("0000000000000",encode("Qwerty123!"),true);
    //   print(actual);
    //   expect(actual, expected);
    // });
    //invalid
    test("test to check for invalid user", () async {
      var expected = "Invalid Password";

      var actual = await userLoginOnline("0000000000000",encode("Qwert123!"),true);

      expect(actual, expected);
    });
  });

  group('testing http request getlogs', ()  {

    test("test for user without logs", () async {
      var expected = [];

      var actual = await getLogs("48");

      expect(actual, expected);
    });

    test("test for user with logs", () async {
      var expected = true;

      var actual = await getLogs("45");

      expect(actual.isNotEmpty, expected);
    });

  });



  group('testing http request makeTransfers', ()  {

    test("test for valid transfers", () async {
      var expected = dbSuccess;

      var actual = await  makeTransfer(
          "34455637975", "34455637975", "1", "test");

      expect(actual, expected);
    });

    test("test for invalid transfers", () async {
      var expected = "Failed to make transfer";

      var actual = await makeTransfer(
          "34455637975", "34455637025", "1", "test");

      expect(actual, expected);
    });

  });

  group('testing http request makePayment', ()  {

    test("test for valid payment", () async {
      var expected = dbSuccess;

      var actual = await  makePayment(
          "34455637975", "34455637975", "1", "test", "35", "Jared Govindsamy");

      expect(actual, expected);
    });

    test("test for invalid payment", () async {
      var expected = "Failed to make transfer";

      var actual = await makePayment(
          "34455637975", "34455637825", "1", "test", "35", "Jared Govindsamy");

      expect(actual, expected);
    });

  });

  group('testing http request getSpecificAccount', ()  {

    test("test for valid specific Account", () async {
      var expected = true;

      var actual = await  getSpecificAccount("34455637975");

      expect(actual.isNotEmpty, expected);
    });

    test("test for invalid specific Account", () async {
      var expected = false;

      var actual = await getSpecificAccount("0000000000000");
      expect(actual.isNotEmpty, expected);
    });
  });


  group('testing http request getUnverifiedClients', ()  {
    test("test to check for valid getUnverifiedClients", () async {
      var expected = true;

      var actual = await getUnverifiedClients();


      expect(actual.isNotEmpty, expected);
    });
  });

    group('testing http request getAccDetails', ()  {

      test("test for valid Account Details", () async {
        var expected = true;

        var actual = await  getAccountDetails("0011223344556");

        expect(actual.isNotEmpty, expected);
      });

      test("test for invalid Account Details", () async {
        var expected = false;

        var actual = await getAccountDetails("0000000000000");

        expect(actual.isNotEmpty, expected);
      });

  });

  test("test to check for valid getNumberOfAccounts", () async {
    var expected = 4;

    var actual = await getNumberOfAccounts();

    expect(actual, expected);
  });

  test("test to check for valid getNumberOfAccounts", () async {
    var expected = "Test";

    var actual = await getClientDetails("0000000000000");

    expect(actual[0].firstName, expected);
  });

  test("test to check for valid getExistingAccountTypes", () async {
    var expected = true;

    var actual = await getExistingAccountTypes(48);

    expect(actual.isEmpty, expected);
  });

  test("test to check for valid getExistingAccountTypes", () async {
    var expected = true;

    var actual = await getExistingAccountTypes(35);

    expect(actual.isNotEmpty, expected);
  });


  String firstName = "John";
  String middleNames = "Sarah Noockles";
  String lastName = "Smith";

  String ansString = "J.S.N. Smith";

  test(
      "Checking if Name Displayer works",
      () =>
          expect(getNameDisplay(firstName, middleNames, lastName), ansString));
}
