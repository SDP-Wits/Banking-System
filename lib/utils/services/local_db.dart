// import 'dart:io';

// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';

// class LocalDatabaseHelper {
//   //Making only one instance of this class
//   //Need only one version of our local storage class
//   LocalDatabaseHelper._privateConstructor();
//   static final instance = LocalDatabaseHelper._privateConstructor();

//   final String _databaseName = "local" + ".db";
//   final int _databaseVersion = 1;

//   static Database? _database;

//   Future<Database> get database async {
//     if (_database != null) {
//       return _database!;
//     }

//     _database = await _createDatabase();
//     return _database!;
//   }

//   Future<Database> _createDatabase() async {
//     //Get the place to store the database
//     Directory documentDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentDirectory.path, _databaseName);
//     //path = "pathOfApp/local.db";

//     return await openDatabase(path,
//         version: _databaseVersion, onCreate: _onCreate, onUpgrade: _onUpgrade);
//   }

//   //SQL codes for making the database
//   Future<void> _onCreate(Database db, int version) async {
//     final String userTableSQL = "CREATE TABLE USER BLA BLA BLA";
//     final String accountTableSQL = "CREATE TABLE ACCOUNT blabal bla";

//     await db.rawQuery(userTableSQL);
//     await db.rawQuery(accountTableSQL);
//   }

//   //When upgrading the version of the app
//   Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
//     // if (newVersion > oldVersion) {
//     //final String tableToAddSQL = "CREATE TABLE NEWTABLE bab lalab";
//     //
//     //await db.rawQuery(tableToAddSQL)
//     // }
//     return;
//   }

//   Future<List<Map>> rawQuery(String sql) async {
//     Database db = await instance.database;
//     return await db.rawQuery(sql);

//     //assume we have user table with "idNumber" column and "hashPassword" column
//     //and "age" column
//     //we will get
//     //[
//     //  {"idNumber" : "0012515615615", "hashPassword" : "s65se1fse1fs51df6", "age" : 18},
//     //  {"idNumber" : "51681616", "hashPassword" : "dhrrhwew32523", "age" : 6262},
//     // ]
//     //
//     //List[0]["age"] == 18
//   }

//   Future<List<Map>> select(String table) async {
//     return await rawQuery("SELECT * FROM $table");

//     //"SELECT * FROM $table" == "SELECT * FROM " + table
//     //"SELECT * FROM ${doubleQuote(table)}" == "SELECT * FROM TABLE " + doubleQuote(table)
//   }

//   //Gonna needs this later on
//   String doubleQuote(String string) {
//     return '"' + string + '"';
//   }
// }
