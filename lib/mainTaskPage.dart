import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Task.dart';
import 'TaskForm.dart';
import 'TaskModel.dart';

class mainTaskPage extends StatefulWidget {
  final String? title;
  const mainTaskPage({super.key, this.title});

  @override
  State<mainTaskPage> createState() => _mainTaskPageState();
}


class _mainTaskPageState extends State<mainTaskPage> {
  List listTask =[];
  int id_counter = 0;
  int counter = 0;
  var _task = TasksModel();
  var _lastInsertedId;

  int index = 0;
  int _selectedIndex = 0;
  int selectedID = 0;

  @override
  void initState() {

    _getThingsOnStartup().then((value) async {
      print('Load done');
    });
    super.initState();

  }

  Future _getThingsOnStartup() async {
    var gradeModel = TasksModel();
    listTask =await gradeModel.getAllTasks();
    _lastInsertedId = listTask[listTask.length-1].id!;
    print(_lastInsertedId);
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    return
    Scaffold(
        appBar: AppBar(
          title: Text("Task List Page",
          style: TextStyle(color: Colors.white, fontSize: 25)),
          actions: [
            IconButton(onPressed: (){
              _deleteTask();
            },
                icon: const Icon(Icons.delete))
          ],
        ),
      body:
        Center(
          child: ListView.builder(
            itemCount: listTask.length,
            itemBuilder: (BuildContext context, int index){
              print(listTask[index]);
              return new ListTile(
                title: Text(listTask[index].name!),
                subtitle: Text(listTask[index].description! + ",  Total time set: "+ listTask[index].time!),
                onTap: (){
                  setState(() {
                    _selectedIndex = index;
                    selectedID = listTask[_selectedIndex].id;
                  });
                },
              );
            },
          )
        ),

        floatingActionButton: FloatingActionButton(
          onPressed:_navigateToTaskAdd,
          child: const Icon(Icons.add),
        ),
    );
  }

  Future _navigateToTaskAdd() async{
    print("Successfully clicked add");
   List information =  await Navigator.of(context).push(MaterialPageRoute(builder: (context) => TaskForm())) as List;
   id_counter++;
   _addList(information);

  }



  Future onGoBack(dynamic value) async {
    var gradeModel = TasksModel();
    List grades1 = await gradeModel.getAllTasks();

    listTask = grades1;
    _lastInsertedId = listTask[listTask.length - 1].id!;

    setState(() {});
    return 0;
  }

  Future _addList(List info) async{
    Task task = Task(id: _lastInsertedId + 1, name: info[0], description: info[1], time: info[2]);
    if (id_counter != null){
      task.id = id_counter;
    }
    _lastInsertedId = await _task.insertTask(task).then(onGoBack);
  }

  void _deleteTask(){
    setState(() {});
    _task.deleteTodoWithId(selectedID).then(onGoBack);
    onGoBack;

  }

}
