import 'package:flutter_test/flutter_test.dart';
import 'package:last_national_bank/utils/helpers/helper.dart';

void main() {
  String firstName = "John";
  String middleNames = "Sarah Noockles";
  String lastName = "Smith";

  String ansString = "J.S.N. Smith";

  test(
      "Checking if Name Displayer works",
      () =>
          expect(getNameDisplay(firstName, middleNames, lastName), ansString));
}
