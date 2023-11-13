class Task{
  int? id;
  String? name;
  String? description;
  var time;

  Task({this.id, this.name, this.description, this.time});

  //This maps all the variables
  Task.fromMap(Map map){
    this.id = map['id'];
    this.name = map['name'];
    this.description = map['description'];
    this.time = map['time'];
  }

  Map<String,Object> toMap(){
    return{
      "id": this.id!,
      'name': this.name!,
      'description': this.description!,
      'time': this.time!
    };
  }

  String toString(){
    return 'Grade[id: $id, name: $name, description: $description, time: $time]';
  }





}