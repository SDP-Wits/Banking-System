/*import "package:test/test.dart";
import 'package:last_national_bank/core/login/login.functions.dart';

void main(){
  group('testing validator for login.functions.dart',(){
    //valid
    test('test to check for valid ID number',(){
      var expected = false;

      var actual = hasInputErrorID("0123456789101");

      expect(actual,expected);
    });
    //invalid
    test('test to check for invalid ID number with out enough numbers',(){
      var expected = true;

      var actual = hasInputErrorID("012345678910");

      expect(actual,expected);
    });
    //invalid
    test('test to check for invalid ID number with a letter',(){
      var expected = true;

      var actual = hasInputErrorID("012345678910a");

      expect(actual,expected);
    });
  });

  group('testing password validator',(){
    //valid
    test('test to check for valid password',(){
      var expected = false;

      var actual = hasInputErrorsPassword("John@123");

      expect(actual,expected);
    });
    //invalid no uppercase
    test('test to check for invalid name without uppercase',(){
      var expected = true;

      var actual = hasInputErrorsPassword("john@123");

      expect(actual,expected);
    });
    //invalid no lowercase
    test('test to check for invalid name without lowercase',(){
      var expected = true;

      var actual = hasInputErrorsPassword("JOHN@123");

      expect(actual,expected);
    });
    //invalid no number
    test('test to check for invalid name without numbers',(){
      var expected = true;

      var actual = hasInputErrorsPassword("John@");

      expect(actual,expected);
    });
    //invalid no special character
    test('test to check for invalid name without special character',(){
      var expected = true;

      var actual = hasInputErrorsPassword("John123");

      expect(actual,expected);
    });
  });

}
*/