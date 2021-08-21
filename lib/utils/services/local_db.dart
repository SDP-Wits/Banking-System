//NOTE TO MARKER

/*
We ignoring this class from coveralls as we cannot test the local DB
as it can ONLY run on Android & iOS devices,
WE DID do a test file for this under the test folder
We run the local db test file on our machines THROUGH AN EMULATOR
(since it is dependant on either Android or iOS)
We are unable to do it on Travis CI as it runs on a windows/linux server
and does NOT start up an android emulator
*/

// coverage:ignore-start
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:last_national_bank/utils/helpers/ignore_helper.dart';
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

  // ignore: avoid_init_to_null
  static User? _user = null;

  Future<Database?> get database async {
    //If web, don't create database
    if (kIsWeb) {
      return null;
    }

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

  Future<void> deleteDatabase() async {
    return await this.deleteDatabase();
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
    Database db = (await instance.database)!;
    return await db.rawQuery(sql);
  }

  // #endregion Set Up Code

  //Delete the User inside the User Table
  Future<bool> deleteUser() async {
    if (kIsWeb) {
      _user = null;
      return true;
    }

    final String sql = "DELETE FROM USER";

    await rawQuery(sql);

    return !(await isUser());
  }

  //Delete the User's Address inside the Address Table
  Future<bool> deleteAddress() async {
    if (kIsWeb) {
      _user = null;
      return true;
    }

    final String sql = "DELETE FROM ADDRESS";

    await rawQuery(sql);

    return !(await isUser());
  }

  //Deletes the User's address and user data
  Future<void> deleteData() async {
    await deleteAddress();
    await deleteUser();
  }

  // #region User

  //Add User to Local DB
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
    //If web
    if (kIsWeb) {
      return dbSuccess;
    }

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

  //Checks to see if the local DB contains a user
  Future<bool> isUser() async {
    //If web
    if (kIsWeb) {
      return (_user != null);
    }

    final String sql = "SELECT * FROM USER";

    List<Map> data = await rawQuery(sql);

    return data.isNotEmpty;
  }

  //Gives back a User object, with address information
  Future<User?> getUserAndAddress() async {
    //If web
    if (kIsWeb) {
      return _user;
    }

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

  //Adds Address
  Future<String> addAddress(int streetNumber, String streetName, String suburb,
      String province, String country, int? apartmentNumber) async {
    //If web
    if (kIsWeb) {
      return dbSuccess;
    }

    final String sql =
        "INSERT INTO ADDRESS(streetNumber, streetName, suburb, province, country, apartmentNumber) VALUES($streetNumber, ${doubleQuote(streetName)}, ${doubleQuote(suburb)},${doubleQuote(province)}, ${doubleQuote(country)}, ${(apartmentNumber == null) ? null : apartmentNumber})";

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

  //Checks to see if there is an Address
  Future<bool> isAddress() async {
    //If web
    if (kIsWeb) {
      return (_user != null);
    }

    final String sql = "SELECT * FROM ADDRESS";

    List<Map> data = await rawQuery(sql);

    return data.isNotEmpty;
  }

  // #endregion

  //Adds User & Address to Database one time
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
    toastyPrint("sup bro outside");
    //If web
    if (kIsWeb) {
      toastyPrint("sup bro");
      _user = User(
        userID,
        firstName,
        middleName,
        lastName,
        age,
        phoneNumber,
        email,
        idNumber,
        "",
        isAdmin,
        streetNumber,
        streetName,
        suburb,
        province,
        country,
        apartmentNumber,
      );
      return dbSuccess;
    }

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

  //Get the address of the user
  Future<Map> selectAddress() async {
    if (kIsWeb) {
      return (_user == null) ? {} : _user!.address.toMap();
    }

    final String sql = "SELECT * FROM ADDRESS";

    return ((await rawQuery(sql))[0]);
  }
}
// coverage:ignore-end
