import 'package:sqflite/sqflite.dart';
import '../storage/db_utils_furniture.dart';
import 'Furniture.dart';
import 'package:main/storage/furniture_references.dart';

class FurnituresModel {
  Future<int> insertFurniture(Furniture furniture) async {
    //This needs to be present in any queries, updates, etc.
    //you do with your database
    final db = await DBUtilsFurniture.init();
    return db.insert(
      'furniture_items',
      furniture.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future getAllFurnitures() async {
    //This needs to be present in any queries, updates, etc.
    //you do with your database
    final db = await DBUtilsFurniture.init();
    final List maps = await db.query('furniture_items');
    List result = [];
    for (int i = 0; i < maps.length; i++) {
      result.add(Furniture.fromMap(maps[i]));
    }
    return result;
  }

  Future<int> updateFurniture(Furniture furniture) async {
    final db = await DBUtilsFurniture.init();
    return db.update(
      'furniture_items',
      furniture.toMap(),
      where: 'id = ?',
      whereArgs: [furniture.id],
    );
  }

  Future<int> deleteTodoWithId(int id) async {
    //This needs to be present in any queries, updates, etc.
    //you do with your database
    final db = await DBUtilsFurniture.init();
    return db.delete(
      'furniture_items',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<bool> dbIsEmpty() async {
    List result = await getAllFurnitures();
    return (result.isEmpty);
  }

  Future addDefaultFurniture() async {
    for (int i = 0; i < defaultFurnitureList.length; i++) {
      await insertFurniture(defaultFurnitureList[i]);
    }
    return;
  }
}
