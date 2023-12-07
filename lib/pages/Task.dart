class Task{
  int? id;
  String? name;
  String? description;
  int? days;
  int? complete;
  var time;


  Task({this.id, this.name, this.description, this.time, this.days, this.complete});

  //This maps all the variables
  Task.fromMap(Map map){
    this.id = map['id'];
    this.name = map['name'];
    this.description = map['description'];
    this.time = map['time'];
    this.days = map['days'];
    this.complete = map['complete'];
  }

  Map<String,Object> toMap(){
    return{
      "id": this.id!,
      'name': this.name!,
      'description': this.description!,
      'time': this.time!,
      'days': this.days!,
      'complete': this.complete!,
    };
  }

  String toString(){
    return 'Grade[id: $id, name: $name, description: $description, time: $time, days: $days, complete: $complete]';
  }





}