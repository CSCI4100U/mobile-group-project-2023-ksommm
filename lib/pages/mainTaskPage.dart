import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:main/pages/taskStart.dart';

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
  int id_counter = 0;
  int _selectedIndex = 0;
  int selectedID = 0;

  @override
  void initState() {
    _getThingsOnStartup().then((value) async {
      print('Load done');
    });
    super.initState();
  }

  //On start up,
  Future _getThingsOnStartup() async {
    listTask =await _taskModel.getAllTasks();
    if(listTask.length!=0){
      _lastInsertedId = listTask[listTask.length-1].id!;
    }
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          title: const Text("Task List Page",
              style: TextStyle(color: Colors.white, fontSize: 25)),
          actions: [
            TextButton(
              child: Text("Autocomplete Tasks"),
              onPressed: (){
                for(int i = 0; i < listTask.length; i ++ ){
                  listTask[i].days = 7;
                  listTask[i].complete = 1;
                }
                checkIfAllTasksDone();
                setState(() {

                });
              }, ),
            IconButton(onPressed: (){
              _deleteTask();
            },
                icon: const Icon(Icons.delete)
            ),

          ],
        ),
        body:
        Center(
          //Listview here will simply list all of the different tasks collected earlier during the init state, or if the
          //page has been rebuilt with a new updated list.
            child:
            ListView.builder(
              itemCount: listTask.length,
              itemBuilder: (BuildContext context, int index){
                return ListTile(
                  title: Text(listTask[index].name!),
                  subtitle: Text("Description: " + listTask[index].description! + "\nTotal time set: "+ listTask[index].time.split(":")[1] + " mins \nTotal amount of days completed: " + listTask[index].days!.toString()),

                  //This long press will open up and allow user to start the specific task based on the selected index.
                  onLongPress: (){
                    _selectedIndex = index;
                    if(listTask[_selectedIndex].complete != 1) {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) =>
                          TaskStart(taskList: listTask[_selectedIndex])))
                          .then(onGoBack);
                      checkIfAllTasksDone();

                    }else{
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Completed!"),
                            content: Text("You have already completed this task for the week"),
                            actions: [
                              TextButton(
                                  onPressed: (){
                                    Navigator.pop(context);
                                    checkIfAllTasksDone();
                                  },
                                  child: Text("Back"))
                            ],
                          )
                      );
                    }
                    },

                  //Here on tap we just update the current selected index so that it can be referenced when deleting later.
                  onTap:(){
                    _selectedIndex = index;
                    selectedID = listTask[_selectedIndex].id;
                  }
                );
              },
            ),
        ),

        //This floatingActionButton is used to start the process of adding a new task
        floatingActionButton: FloatingActionButton(
          onPressed:_navigateToTaskAdd,
          child: const Icon(Icons.add),
        ),

      );
  }

  //This function call the TaskForm page to get the information required for the task.
  //After information is collected such as id and name, etc. the information is passed to a new function to add to the database later.
  Future _navigateToTaskAdd() async{
    List information =  (await Navigator.of(context).push(MaterialPageRoute(builder: (context) => TaskForm())) as List);
    id_counter++;
    _addList(information);

  }

  //This onGoBack function is used to update the list and to set the lastInsertedID correctly for when the page is reset
  //This function had to be specifically created for delete, so that it can be called and update the list now without the
  //task that was just deleted.
  Future onGoBack(dynamic value) async {
    listTask = await _taskModel.getAllTasks();
    if(listTask.length > 0){
      _lastInsertedId = listTask[listTask.length - 1].id!;
    } else {
      _lastInsertedId = 0;
    }
    setState(() {});
    return 0;
  }

  //Here is the function for adding the task to the list.
  //The task is created with the information gathered and the add task from TaskModel is called.
  Future _addList(List info) async{
    if (_lastInsertedId == null) {
      _lastInsertedId = 0;
    }
    Task task = Task(id: _lastInsertedId + 1, name: info[0], description: info[1], time: info[2], days: 0, complete: 0);
    if (id_counter != null) {
      task.id = id_counter;
    }
    _lastInsertedId = await _taskModel.insertTask(task).then(onGoBack);
    _lastInsertedId = await _taskModel.insertTask(task).then(onGoBack);
  }

  //Here is task delete task is run. Called from the TaskModel.
  void _deleteTask(){
    _taskModel.deleteTodoWithId(selectedID).then(onGoBack);
  }


  //This function checks if
  void checkIfAllTasksDone(){
    int howManyDone = 0;
    for(int i = 0; i < listTask.length; i ++ ){
      if(listTask[i].complete ==1){
        howManyDone++;
      }
    }

    if(howManyDone == listTask.length){
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Congratulations"),
            content: Text("Click the button below to claim your pet!"),
            actions: [
              TextButton(
                  onPressed: (){
                    print("Run the code here");
                    Navigator.pop(context);
                  },
                  child: Text("Claim!"))
            ],
          )
      );
    }

  }

}
