import 'dart:io';

import '../../constants/database_constants.dart';
import '../helpers/db_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

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
        "CREATE TABLE USER(userID AUTO INCREMENT PRIMARY KEY, email TEXT NOT NULL, phoneNumber TEXT, id TEXT NOT NULL, password TEXT NOT NULL, age INTEGER NOT NULL, firstName TEXT NOT NULL, middleName TEXT, lastName TEXT NOT NULL, isAdmin INT NOT NULL)";

    await db.rawQuery(userTableSQL);
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
  Future<String> addUser(
      int userID,
      String email,
      String phoneNumber,
      String idNumber,
      String password,
      int age,
      String firstName,
      String middleName,
      String lastName,
      bool isAdmin) async {
    final String sql =
        "INSERT INTO USER(userID, email, phoneNumber, id, password, age, firstName, middleName, lastName, isAdmin)" +
            "VALUES($userID, ${doubleQuote(email)}, ${doubleQuote(phoneNumber)}, ${doubleQuote(idNumber)}, ${doubleQuote(password)}, $age, ${doubleQuote(firstName)},${doubleQuote(middleName)},${doubleQuote(lastName)}, ${isAdmin ? 1 : 0})";

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
}
