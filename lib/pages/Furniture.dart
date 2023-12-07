class Task{
  int? id;
  String? name;
  int? price;
  String? location;
  int? purchased;


  Task({this.id, this.name, this.price, this.location, this.purchased});

  //This maps all the variables
  Task.fromMap(Map map){
    id = map['id'];
    name = map['name'];
    price = map['price'];
    location = map['location'];
    purchased = map['purchased'];
  }

  Map<String,Object> toMap(){
    return{
      "id": id!,
      'name': name!,
      'price': price!,
      'location': location!,
      'purchased': purchased!,
    };
  }

  @override
  String toString(){
    return 'Grade[id: $id, name: $name, price: $price, location: $location, purchased: $purchased]';
  }





}