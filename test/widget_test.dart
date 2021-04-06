import 'package:last_national_bank/utils/services/local_db.dart';

Future<void> main() async {
  LocalDatabaseHelper localDatabaseHelper = LocalDatabaseHelper.instance;

  print("First instance query returns :");
  print((await localDatabaseHelper.addUser(
          1,
          "temp@gmail.com",
          "061494626",
          "614846846846",
          "password",
          18,
          "ardfs",
          "middle",
          "meLastName",
          true))
      .toString());

  print("====");

  print("Second instance query returns :");
  print((await localDatabaseHelper.addUser(
          1,
          "temp@gmail.com",
          "061494626",
          "614846846846",
          "password",
          18,
          "ardfs",
          "middle",
          "meLastName",
          true))
      .toString());

  print("end of perso test");
}
