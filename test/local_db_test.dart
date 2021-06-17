@TestOn("android")
@Skip("Can't get android emulator running on Travis CI for automated testing")

import 'package:flutter_test/flutter_test.dart';
import 'package:last_national_bank/classes/user.class.dart';
import 'package:last_national_bank/utils/helpers/helper.dart';
import 'package:last_national_bank/utils/services/local_db.dart';
import 'package:last_national_bank/utils/services/online_db.dart';

void main() async {
  LocalDatabaseHelper localDB = LocalDatabaseHelper.instance;

  //Testing out adding user and address works
  await localDB.addUser(9999, "joker@gmail.com", "0614762496", "0123456789123",
      "someHashedPassword", 84, "Joker", "Muco", "Luke", true);

  await localDB.addAddress(5, "villey", "suburger", "provs", "texas", 19);

  test("Testing to see if add user and get user works", () async {
    User user = (await localDB.getUserAndAddress())!;

    //If one of the inputs works, then all of them do
    expect("Joker", user.firstName);

    await localDB.deleteUser();
    await localDB.deleteAddress();
  });

  test("Testing to see if deleting the user worked", () async {
    //There should be no user in db therefore it should return null
    expect(null, await localDB.getUserAndAddress());
  });
}
