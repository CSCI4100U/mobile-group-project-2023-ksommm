import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DBUtilsFurniture{
  static Future init() async{
    //set up the database
    var database = openDatabase(
      path.join(await getDatabasesPath(), 'furniture_manager.db'),
      onCreate: (db, version){
        db.execute(
            'CREATE TABLE furniture_items (id INTEGER PRIMARY KEY, name TEXT, location String, selected INT)'
        );
      },
      version: 1,
    );
    print("Created DB for furniture $database");
    return database;
  }
}