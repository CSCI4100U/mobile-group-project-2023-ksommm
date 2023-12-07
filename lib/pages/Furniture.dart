class Furniture{
  int? id;
  String? name;
  String? location;
  int? selected;

  Furniture({this.id, this.name, this.location, this.selected});

  //This maps all the variables
  Furniture.fromMap(Map map){
    id = map['id'];
    name = map['name'];
    location = map['location'];
    selected = map['selected'];

  }

  Map<String,Object> toMap(){
    return{
      "id": id!,
      'name': name!,
      'location': location!,
      'selected': selected!,
    };
  }

  @override
  String toString(){
    return 'Grade[id: $id, name: $name, location: $location, selected: $selected]';
  }





}