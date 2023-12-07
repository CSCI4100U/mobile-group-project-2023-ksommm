import 'package:main/storage/db_utils_creature.dart';
import 'package:sqflite/sqflite.dart';
import '../storage/db_utils.dart';
import 'Creature.dart';
import 'Task.dart';

class CreatureModel{
  Future<int> insertCreature(Creature creature) async{
    //This needs to be present in any queries, updates, etc.
    //you do with your database
    final db = await DBUtilsCreature.init();
    return db.insert(
      'creature_items',
      creature.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


  Future getAllCreatures() async{
    //This needs to be present in any queries, updates, etc.
    //you do with your database
    final db = await DBUtilsCreature.init();
    final List maps = await db.query('creature_items');
    List result = [];
    for (int i = 0; i < maps.length; i++){
      result.add(
          Creature.fromMap(maps[i])
      );
    }
    return result;
  }

  Future<int> updateCreature(Creature creature) async{
    final db = await DBUtilsCreature.init();
    return db.update(
      'creature_items',
      creature.toMap(),
      where: 'id = ?',
      whereArgs: [creature.id],
    );
  }


  Future<int> deleteTodoWithIdCreature(int id) async{
    //This needs to be present in any queries, updates, etc.
    //you do with your database
    final db = await DBUtilsCreature.init();
    return db.delete(
      'creature_items',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
