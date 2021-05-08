import 'package:flutter_test/flutter_test.dart';
import 'package:last_national_bank/utils/helpers/helper.dart';
import 'package:last_national_bank/utils/services/online_db.dart';

void main() {
  String cardNumberUnspaced = "1234567891011234";
  String cardNumberSpaced = "1234 5678 9101 1234";

  test("Testing to see if seperateCardNumber works properly", () {
    expect(seperateCardNumber(cardNumberUnspaced), cardNumberSpaced);
  });
}
