import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/cupertino.dart';
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
          title: Text("Add Task",
              style: TextStyle(color: Colors.white, fontSize: 25),
          textAlign: TextAlign.center),
        ),
        body: Column(
          children: [
            Padding(
                padding: EdgeInsets.only(top: 100, bottom: 20, left: 15, right: 15),
                child:
                Text("Enter the name or title of task!: ")
            ),
            Padding(
                padding:EdgeInsets.only(top: 0, bottom: 20, left: 15, right: 15),
                child:
                TextField(
                  decoration: InputDecoration(
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
            Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20, left: 15, right: 15),
                child:
                Text("Enter the description of the task: ")
            ),
            Padding(
                padding:EdgeInsets.only(top: 0, bottom: 20, left: 15, right: 15),
                child:
                TextField(
                  decoration: InputDecoration(
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
            Padding(
                padding:EdgeInsets.only(top: 0, bottom: 20, left: 15, right: 15),
                child:
                  ElevatedButton(
                    onPressed: () async{
                      var duration = await showDurationPicker(context: context, initialTime: Duration(minutes: 30));

                      durationSelected = duration;

                      if(durationSelected != Null){
                        //Prints the time selected to the Snackbar if time is not null
                        ScaffoldMessenger.of(context).showSnackBar((
                            SnackBar(
                                content:Text("Time selected: $duration")

                            )));
                      }
                    },
                    child: Text("Choose time limit"),
                  )
            ),





            ElevatedButton(
                onPressed: _addTask,
                child: Icon(Icons.save_outlined))
          ],
        ),
      );
  }


  Future _addTask() async{

    if(name == null){
      ScaffoldMessenger.of(context).showSnackBar((
          SnackBar(
              content:Text("Please enter a name")

          )));
    }else if(description == null){
      ScaffoldMessenger.of(context).showSnackBar((
          SnackBar(
              content:Text("Please enter a description")

          )));
    }else if(durationSelected == null){
      ScaffoldMessenger.of(context).showSnackBar((
          SnackBar(
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
