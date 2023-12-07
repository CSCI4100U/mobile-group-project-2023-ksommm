class Creature{
  int? id;
  String? name;
  String? asset;
  int? obtained;


  Creature({this.id, this.name, this.asset, this.obtained});

  //This maps all the variables
  Creature.fromMap(Map map){
    id = map['id'];
    name = map['name'];
    asset = map['asset'];
    obtained = map['obtained'];
  }

  Map<String,Object> toMap(){
    return{
      "id": id!,
      'name': name!,
      'asset': asset!,
      'obtained': obtained!,
    };
  }

  @override
  String toString(){
    return 'Grade[id: $id, name: $name, asset: $asset, obtained: $obtained]';
  }
}