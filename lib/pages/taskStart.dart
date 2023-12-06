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
    duration = countDownDuration;
  }



  //This is the main build portion
  @override
  Widget build(BuildContext context) {
    final allStrings = widget.taskList.time.split(":");
    final minutes = allStrings[1];
    return Scaffold(
        appBar: AppBar(
          title: Text("Selected Task",
              style: TextStyle(color: Colors.white, fontSize: 25),
              textAlign: TextAlign.center),

          //Here Gesture detector added so that timer can be stopped so that page can be popped without timer overflow
          leading: GestureDetector(
            child: Icon(Icons.arrow_back_outlined),
            onTap: (){
              if(timer != null){
                timer!.cancel();
              }
              Navigator.pop(context);
            },
          ),


        ),

        //Here is the body of the widget, where most of the data being displayed to the user is fomatted.
        //Start by showing the name, then description, and then calling a widget (build time) to display the current-
        //time of the timer. After the widget, there are two buttons to play/pause the timer countdown.
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


//This is the widget that will build the
  Widget buildTime(){
    final mins = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final secs = duration.inSeconds.remainder(60).toString().padLeft(2, '0');

    //This is the text box widget that
    return Text(
      '$mins:$secs',
      style: TextStyle(fontSize: 50),
    );
  }

  void startTimer(){
    if(timer == null ){
      timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
    }else if(timer!.isActive == false){
      timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
    }
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

}
