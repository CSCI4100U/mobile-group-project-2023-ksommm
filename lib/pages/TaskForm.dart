import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';

class TaskForm extends StatefulWidget {
  final String? title;
  const TaskForm({super.key, this.title});

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  List information = [];
  String? name;
  String? description;
  var durationSelected;

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          title: const Text("Add Task",
              style: TextStyle(color: Colors.white, fontSize: 25),
              textAlign: TextAlign.center),
        ),
        body:
        SingleChildScrollView(
          child: Column(
            children: [
              //Here the user is asked to enter the task name. The Textfield below is the name value and the value that is entered is saved.
              const Padding(
                  padding: EdgeInsets.only(top: 100, bottom: 20, left: 15, right: 15),
                  child:
                  Text("Enter the name or title of task!: ")
              ),
              Padding(
                  padding:const EdgeInsets.only(top: 0, bottom: 20, left: 15, right: 15),
                  child:
                  TextField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter Task Name"
                    ),
                    onChanged: (value){
                      setState(() {
                        name = value;
                      });
                    },
                  )
              ),


              //Here the user is asked to enter the task description. The Textfield below is the description value and the value that is entered is saved.
              const Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20, left: 15, right: 15),
                  child:
                  Text("Enter the description of the task: ")
              ),
              Padding(
                  padding:const EdgeInsets.only(top: 0, bottom: 20, left: 15, right: 15),
                  child:
                  TextField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter Task Description"
                    ),
                    onChanged: (value){
                      setState(() {
                        description = value;
                      });
                    },
                  )
              ),

              //Here a button is created that brings up a wheel for selecting the time. Scaffold messenger is used to show user the selected time.
              Padding(
                  padding:const EdgeInsets.only(top: 0, bottom: 20, left: 15, right: 15),
                  child:
                  ElevatedButton(
                    onPressed: () async{
                      var duration = await showDurationPicker(context: context, initialTime: const Duration(minutes: 30));
                      durationSelected = duration;

                      if(durationSelected != Null){
                        ScaffoldMessenger.of(context).showSnackBar((
                            SnackBar(
                                content:Text("Time selected: $duration")
                            )));
                      }
                    },
                    child: const Text("Choose time limit"),
                  )
              ),




              //This button calls a function to return back to main page with the entered information to save it
              ElevatedButton(
                  onPressed: _addTask,
                  child: const Icon(Icons.save_outlined))
            ],
          ),
        )

      );
  }


  //Here the addTask function is calls, where if none of the values
  //are left empty then the page gets popped with a list of the correct
  //values.
  Future _addTask() async{

    if(name == null){
      ScaffoldMessenger.of(context).showSnackBar((
          const SnackBar(
              content:Text("Please enter a name")

          )));
    }else if(description == null){
      ScaffoldMessenger.of(context).showSnackBar((
          const SnackBar(
              content:Text("Please enter a description")

          )));
    }else if(durationSelected == null){
      ScaffoldMessenger.of(context).showSnackBar((
          const SnackBar(
              content:Text("Please select a duration of time")

          )));
    }else{
      information = [];
      information.add(name);
      information.add(description);
      information.add(durationSelected.toString());

      Navigator.pop(context, information);
    }



  }
}
