import 'package:flutter_test/flutter_test.dart';
import 'package:last_national_bank/utils/services/online_db.dart';

void main() {
  List<String> phpNames = ["id", "password"];
  List<String> inputVariables = ["1234567891234", "thisisahashpassword"];

  test("Testing to see if argument maker works properly", () {
    expect(argumentMaker(phpNames: phpNames, inputVariables: inputVariables),
        "?id=1234567891234&password=thisisahashpassword");
  });
}
