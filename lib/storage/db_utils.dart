import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DBUtils{
  static Future init() async{
    //set up the database
    var database = openDatabase(
      path.join(await getDatabasesPath(), 'task_manager.db'),
      onCreate: (db, version){
        db.execute(
            'CREATE TABLE task_items (id INTEGER PRIMARY KEY, name TEXT, description TEXT, time TEXT, days INT, complete INT)'
        );
      },
      version: 1,
    );
    print("Created DB $database");
    return database;
  }
}