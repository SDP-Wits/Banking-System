@TestOn("android")
//  @Skip("Can't get android emulator running on Travis CI for automated testing")

import 'package:flutter_test/flutter_test.dart';
import 'package:last_national_bank/classes/user.class.dart';
import 'package:last_national_bank/constants/database_constants.dart';
import 'package:last_national_bank/utils/services/local_db.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  // test("With the stuff for true", () {
  //   expect(true, true);
  // });
  // await LocalDatabaseHelper.instance.deleteDatabase();

  LocalDatabaseHelper localDB = LocalDatabaseHelper.instance;

  await localDB.deleteData();

  /*
  WE DON'T USE THESE FUNCTIONS DIRECTLY, WE CALL `addUserDetails`
  which calls both user and address, this is because when you
  register you need to give an your address and user information
  therefore it does not make sense to call one directly.
  */
  test("Testing, Add User ,Add Address and Get User works and Check User",
      () async {
    await localDB.addUser(
        9999,
        "joker@gmail.com",
        "0614762496",
        "0123456789123",
        "someHashedPassword",
        84,
        "Joker",
        "Muco",
        "Luke",
        true);

    await localDB.addAddress(5, "villey", "suburger", "provs", "texas", 19);

    User user = (await localDB.getUserAndAddress())!;

    // ignore: unnecessary_null_comparison
    expect(true, user != null);

    //If one of the inputs works, then all of them do
    expect("Joker", user.firstName);
  });

  test("Testing, Get Address work", () async {
    User user = (await localDB.getUserAndAddress())!;

    expect("villey", user.address.streetName);
  });

  test("When there is Address, check if `isAddress` returns true", () async {
    bool isAddress = await localDB.isAddress();
    expect(true, isAddress);
  });

  localDB.isUser();

  test("Testing to see if deleting the user worked", () async {
    await localDB.deleteUser();
    await localDB.deleteAddress();
    //There should be no user in db therefore it should return null
    expect(null, await localDB.getUserAndAddress());
  });

  test("When there is NOT an address, check if `isAddress` returns false",
      () async {
    bool isAddress = await localDB.isAddress();
    expect(false, isAddress);
  });

  test("Adding Another User Class", () async {
    String userSuccessString = (await localDB.addUserDetails(
        2,
        "anotherOne@gmail.com",
        "0618917546",
        "0012094519874",
        "jokerv2",
        811,
        "Astro",
        "Batman",
        "Joker",
        true,
        4,
        "another Street Name",
        "another Suburb",
        "another Province",
        "Another Country",
        2));

    expect(dbSuccess, userSuccessString);
  });
}
