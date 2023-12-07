import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DBUtilsCreature{
  static Future init() async{
    //set up the database
    var database = openDatabase(
      path.join(await getDatabasesPath(), 'creature_manager.db'),
      onCreate: (db, version){
        db.execute(
            'CREATE TABLE creature_items (id INTEGER PRIMARY KEY, name TEXT, asset TEXT, obtained INT)'
        );
      },
      version: 1,
    );
    print("Created DB $database");
    return database;
  }
}