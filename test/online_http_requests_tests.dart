import "package:test/test.dart";
import 'dart:async';
import 'package:last_national_bank/utils/services/online_db.dart';
import 'package:last_national_bank/classes/accountTypes.dart';
import 'dart:math';

void main(){

  //Testing adminRegisterOnline
  test('test for calling bank account types', () async {
    //adding expected data

    List<accountTypes> bankAccTypes = [];
    accountTypes accOption = accountTypes(
      accType: "Savings Account",
      accDescription: "This offers you a basic banking service with which you can make purchases and withdrawals.",
      accountTypeId: 1,
    );
    bankAccTypes.add(accOption);
    accOption = accountTypes(
      accType: "Current Account",
      accDescription: "Get easy access to your money for day-to-day expenses. You get different types of cards depending on your income bracket.",
      accountTypeId: 2,
    );
    bankAccTypes.add(accOption);
    accOption = accountTypes(
      accType: "Fixed Deposit Account",
      accDescription: "A savings account that you can only access when giving a certain amount of days notice. Earn more interest the longer you save.",
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
    int i = random.nextInt(5);

    var expected = bankAccTypes[i].accDescription;

    var actual = await getAccountTypes();
    // print(actual);

    expect(actual[i].accDescription, expected);
  });

}