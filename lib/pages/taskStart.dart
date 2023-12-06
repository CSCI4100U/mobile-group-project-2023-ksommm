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

  //Here in the initState(), the total amount of time being started at is set for the timer to display and use later.
  @override
  void initState(){
    super.initState();
    countDownDuration = Duration(minutes: int.parse(widget.taskList.time.split(":")[1]));
    duration = countDownDuration;
  }



  //This is the main build portion
  @override
  Widget build(BuildContext context) {
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

                //Here we list the title/name of the task opened
                Padding(padding: EdgeInsets.only(top: 10),
                  child: Text("Task Name: " + widget.taskList.name!,
                    style: TextStyle(
                        fontSize: 25
                    ),),
                ),


                //Here we list the description of the task opened
                Padding(padding: EdgeInsets.only(top: 0),
                  child: Text("Desciption of Task: " + widget.taskList.description!,
                      style: TextStyle(
                          fontSize: 20
                      ),
                      textAlign: TextAlign.center),
                ),


                 //This is where the timer is built and shown on screen for display
                 Padding(padding: EdgeInsets.only(top: 250),
                    child: buildTime(),
                 ),

                //Row contains the two play and pause buttons
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


//This is the widget that will build the timer being shown
  Widget buildTime(){
    final mins = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final secs = duration.inSeconds.remainder(60).toString().padLeft(2, '0');

    //This is the text box widget that draws to the user on the page the timer count down as it gets updated.
    return Text(
      '$mins:$secs',
      style: TextStyle(fontSize: 50),
    );
  }

  //Here the timer is started, and checks are added to ensure once started it cannot be started again
  //Note: To create timer referenced following video: https://www.youtube.com/watch?v=Bw6zc1nncyA
  void startTimer(){
    if(timer == null ){
      timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
    }else if(timer!.isActive == false){
      timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
    }
  }

  //Here is where the timer gets decreased by a second which causes the timer to go down.
  void addTime(){
    final removeSecond = -1;

    setState(() {
      final seconds = duration.inSeconds + removeSecond;
      if(seconds < 0){
        timer?.cancel();
      }else{
        duration = Duration(seconds: seconds);
      }

    });
  }

}
