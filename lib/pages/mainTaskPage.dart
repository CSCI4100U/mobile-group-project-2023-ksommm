import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:main/pages/taskStart.dart';
import 'package:main/storage/firestore_service.dart';

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
  List listTask = [];
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
    listTask = await gradeModel.getAllTasks();
    if (listTask.length != 0) {
      _lastInsertedId = listTask[listTask.length - 1].id!;
      print(_lastInsertedId);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task List Page",
            style: TextStyle(color: Colors.white, fontSize: 25)),
        actions: [
          IconButton(
              onPressed: () {
                _deleteTask();
              },
              icon: const Icon(Icons.delete)),
          IconButton(
              onPressed: () {
                addAllTasksToFirestore(listTask);
              },
              icon: const Icon(Icons.car_crash))
        ],
      ),
      body: Center(
          child: ListView.builder(
        itemCount: listTask.length,
        itemBuilder: (BuildContext context, int index) {
          print(listTask[index]);
          return ListTile(
            title: Text(listTask[index].name!),
            subtitle: Text(listTask[index].description! +
                ",  Total time set: " +
                listTask[index].time!),
            onLongPress: () {
              _selectedIndex = index;
              selectedID = listTask[_selectedIndex].id;
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      TaskStart(taskList: listTask[_selectedIndex])));
            },
            onTap: () {
              _selectedIndex = index;
              selectedID = listTask[_selectedIndex].id;
            },
          );
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToTaskAdd,
        child: const Icon(Icons.add),
      ),
    );
  }

  //This function call the TaskForm page to get the information required for the task.
  //After information is collected such as id and name, etc. the information is passed to a new function to add to the database later.
  Future _navigateToTaskAdd() async {
    print("Successfully clicked add");
    List information = (await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => TaskForm())) as List);
    id_counter++;
    _addList(information);
  }

  //This onGoBack function is used to update the list and to set the lastInsertedID correctly for when the page is reset
  Future onGoBack(dynamic value) async {
    var gradeModel = TasksModel();
    List grades1 = await gradeModel.getAllTasks();

    listTask = grades1;
    if (listTask.length > 0) {
      _lastInsertedId = listTask[listTask.length - 1].id!;
    } else {
      _lastInsertedId = 0;
    }
    setState(() {});
    return 0;
  }

  //Here is the function for adding the task to the list.
  //The task is created with the information gathered and the add task from the model is called.
  Future _addList(List info) async {
    if (_lastInsertedId == null) {
      _lastInsertedId = 0;
    }
    Task task = Task(
        id: _lastInsertedId + 1,
        name: info[0],
        description: info[1],
        time: info[2],
        days: 0,
        complete: 0);
    if (id_counter != null) {
      task.id = id_counter;
    }
    _lastInsertedId = await _task.insertTask(task).then(onGoBack);
  }

  //Here is task delete task is run
  void _deleteTask() {
    _task.deleteTodoWithId(selectedID).then(onGoBack);
  }

  // TODO: Delete function after testing
  void addAllTasksToFirestore(List tasks) {
    FirestoreService firestoreService = FirestoreService();
    firestoreService.addTasks(tasks);
  }
}
