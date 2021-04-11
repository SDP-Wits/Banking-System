import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:last_national_bank/utils/helpers/helper.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../classes/user.class.dart';
import '../../constants/database_constants.dart';
import '../helpers/db_helper.dart';

class LocalDatabaseHelper {
  // #region Set Up Code

  //Making only one instance of this class
  //Need only one version of our local storage class
  LocalDatabaseHelper._privateConstructor();
  static final instance = LocalDatabaseHelper._privateConstructor();

  final String _databaseName = "local" + ".db";
  final int _databaseVersion = 1;

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _createDatabase();
    return _database!;
  }

  Future<Database> _createDatabase() async {
    //Get the place to store the database
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, _databaseName);
    //path = "pathOfApp/local.db";

    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  //SQL codes for making the database
  Future<void> _onCreate(Database db, int version) async {
    final String userTableSQL =
        "CREATE TABLE USER(userID AUTO INCREMENT PRIMARY KEY, email TEXT NOT NULL, phoneNumber TEXT NOT NULL, idNumber TEXT NOT NULL, password TEXT NOT NULL, age INTEGER NOT NULL, firstName TEXT NOT NULL, middleName TEXT, lastName TEXT NOT NULL, isAdmin INT NOT NULL)";

    final String addressTableSQL =
        "CREATE TABLE ADDRESS(addressID INT AUTO INCREMENT PRIMARY KEY, streetNumber INTEGER NOT NULL, streetName TEXT NOT NULL, suburb TEXT NOT NULL, province TEXT NOT NULL, country TEXT NOT NULL, apartmentNumber INT)";

    await db.rawQuery(userTableSQL);
    await db.rawQuery(addressTableSQL);
  }

  //When upgrading the version of the app
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // if (newVersion > oldVersion) {
    //final String tableToAddSQL = "CREATE TABLE NEWTABLE bab lalab";
    //
    //await db.rawQuery(tableToAddSQL)
    // }
    return;
  }

  Future<List<Map>> rawQuery(String sql) async {
    Database db = await instance.database;
    return await db.rawQuery(sql);
  }

  // #endregion Set Up Code
  Future<bool> deleteUser() async {
    final String sql = "DELETE FROM USER";

    await rawQuery(sql);

    return !(await isUser());
  }

  Future<bool> deleteAddress() async {
    final String sql = "DELETE FROM ADDRESS";

    await rawQuery(sql);

    return !(await isUser());
  }

  Future<void> deleteData() async {
    await deleteAddress();
    await deleteUser();
  }

  // #region User

  Future<String> addUser(
      int userID,
      String email,
      String phoneNumber,
      String idNumber,
      String password,
      int age,
      String firstName,
      String? middleName,
      String lastName,
      bool isAdmin) async {
    final String sql =
        "INSERT INTO USER(userID, email, phoneNumber, idNumber, password, age, firstName, middleName, lastName, isAdmin)" +
            "VALUES($userID, ${doubleQuote(email)}, ${doubleQuote(phoneNumber)}, ${doubleQuote(idNumber)}, ${doubleQuote(password)}, $age, ${doubleQuote(firstName)},${(middleName == null) ? "null" : doubleQuote(middleName)},${doubleQuote(lastName)}, ${isAdmin ? 1 : 0})";

    try {
      List<Map> results = await rawQuery(sql);
      if (results.isEmpty) {
        return dbSuccess;
      } else {
        return dbFailed;
      }
    } catch (error) {
      return error.toString();
    }
  }

  Future<bool> isUser() async {
    final String sql = "SELECT * FROM USER";

    List<Map> data = await rawQuery(sql);

    return data.isNotEmpty;
  }

  Future<User?> getUserAndAddress() async {
    if (await isUser()) {
      final String sqlUser = "SELECT * FROM USER LEFT JOIN ADDRESS";

      Map data = (await rawQuery(sqlUser))[0];

      return User(
          data["userID"],
          data["firstName"],
          data["middleName"],
          data["lastName"],
          data["age"],
          data["phoneNumber"],
          data["email"],
          data["idNumber"],
          data["password"],
          (data["isAdmin"] == 1) ? true : false,
          data["streetNumber"],
          data["streetName"],
          data["suburb"],
          data["province"],
          data["country"],
          data["apartmentNumber"]);
    }
    return null;
  }

  // #endregion

  // #region Address
  Future<String> addAddress(int streetNumber, String streetName, String suburb,
      String province, String country, int? apartmentNumber) async {
    final String sql =
        "INSERT INTO ADDRESS(streetNumber, streetName, suburb, province, country, apartmentNumber) VALUES($streetNumber, ${doubleQuote(streetName)}, ${doubleQuote(suburb)},${doubleQuote(province)}, ${doubleQuote(country)}, ${(apartmentNumber == null) ? null : apartmentNumber})";
    // "CREATE TABLE ADDRESS(addressID INT AUTO INCREMENT PRIMARY KEY, streetNumber INTEGER NOT NULL, streetName TEXT NOT NULL, suburb TEXT NOT NULL, province TEXT NOT NULL, country TEXT NOT NULL, apartmentNumber INT)"

    try {
      List<Map> results = await rawQuery(sql);
      if (results.isEmpty) {
        return dbSuccess;
      } else {
        return dbFailed;
      }
    } catch (error) {
      return error.toString();
    }
  }

  Future<bool> isAddress() async {
    final String sql = "SELECT * FROM ADDRESS";

    List<Map> data = await rawQuery(sql);

    return data.isNotEmpty;
  }

  // #endregion

  Future<String> addUserDetails(
      int userID,
      String email,
      String phoneNumber,
      String idNumber,
      String password,
      int age,
      String firstName,
      String? middleName,
      String lastName,
      bool isAdmin,
      int streetNumber,
      String streetName,
      String suburb,
      String province,
      String country,
      int? apartmentNumber) async {
    //Clearing up any old data
    await deleteData();

    //Adding user & address to the table
    String addressResponse = await addAddress(
        streetNumber, streetName, suburb, province, country, apartmentNumber);

    String userResponse = await addUser(userID, email, phoneNumber, idNumber,
        password, age, firstName, middleName, lastName, isAdmin);

    //Setting to see if the data was inserted correctly
    bool addressFlag = addressResponse != dbSuccess;
    bool userFlag = userResponse != dbSuccess;

    if (userFlag && addressFlag) {
      return dbFailed;
    }

    if (userFlag) {
      await deleteData();
      return dbFailed;
    }

    if (userFlag) {
      await deleteData();
      return dbFailed;
    }

    return dbSuccess;
  }

  Future<Map> selectAddress() async {
    final String sql = "SELECT * FROM ADDRESS";

    return ((await rawQuery(sql))[0]);
  }
}
