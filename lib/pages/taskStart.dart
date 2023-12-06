import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Task.dart';

class TaskStart extends StatefulWidget {
  Task taskList;

  TaskStart({required this.taskList, super.key});

  @override
  State<TaskStart> createState() => _TaskStartState();
}

class _TaskStartState extends State<TaskStart> {
  var countDownDuration;
  Duration duration = Duration();
  Timer? timer;
  bool? isCountdown = true;

  @override
  void initState(){
    super.initState();
    final allStrings = widget.taskList.time.split(":");
    final minutes = allStrings[1];
     countDownDuration = Duration(minutes: int.parse(widget.taskList.time.split(":")[1]));
    reset();
  }


  void reset(){
    setState(() {
      duration = countDownDuration;
    });
  }

  void startTimer(){
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
  }

  void addTime(){
    final addSecond = -1;

    setState(() {
      final seconds = duration.inSeconds + addSecond;
      if(seconds < 0){
        timer?.cancel();
      }else{
        duration = Duration(seconds: seconds);
      }

    });
  }


  //This is the main build portion
  @override
  Widget build(BuildContext context) {
    print(widget.taskList);

    final allStrings = widget.taskList.time.split(":");
    final minutes = allStrings[1];
    return Scaffold(
        appBar: AppBar(
          title: Text("Selected Task",
              style: TextStyle(color: Colors.white, fontSize: 25),
              textAlign: TextAlign.center),
        ),
        body: Center(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 10),
                  child: Text("Task Name: " + widget.taskList.name!,
                    style: TextStyle(
                        fontSize: 25
                    ),),
                ),
                Padding(padding: EdgeInsets.only(top: 0),
                  child: Text("Desciption of Task: " + widget.taskList.description!,
                      style: TextStyle(
                          fontSize: 20
                      ),
                      textAlign: TextAlign.center),
                ),
                 Padding(padding: EdgeInsets.only(top: 250),
                    child: buildTime(),
                 ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(onPressed: startTimer, icon: Icon(Icons.play_circle, size: 50,)),
                    IconButton(onPressed: (){
                      setState(() {
                        timer?.cancel();
                      });
                    }, icon: Icon(Icons.stop_circle, size: 50,))
                  ],
                )


              ],
            )
        )
    );
  }

  Widget buildTime(){
    String one(int n ) => n.toString().padLeft(2, '0');
    final mins = one(duration.inMinutes.remainder(60));
    final secs = one(duration.inSeconds.remainder(60));

    return Text(
      '$mins:$secs',
      style: TextStyle(fontSize: 50),
    );
  }

}
