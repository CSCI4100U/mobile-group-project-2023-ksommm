import 'package:sqflite/sqflite.dart';
import 'db_utils.dart';
import 'Task.dart';

class TasksModel{
  Future<int> insertTask(Task task) async{
    //This needs to be present in any queries, updates, etc.
    //you do with your database
    final db = await DBUtils.init();
    return db.insert(
      'task_items',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


  Future getAllTasks() async{
    //This needs to be present in any queries, updates, etc.
    //you do with your database
    final db = await DBUtils.init();
    final List maps = await db.query('task_items');
    List result = [];
    for (int i = 0; i < maps.length; i++){
      result.add(
          Task.fromMap(maps[i])
      );
    }
    return result;
  }

  Future<int> deleteTodoWithId(int id) async{
    //This needs to be present in any queries, updates, etc.
    //you do with your database
    final db = await DBUtils.init();
    return db.delete(
      'task_items',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

}
