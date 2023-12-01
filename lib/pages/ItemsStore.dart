import 'package:flutter/material.dart';

class FurnitureStore extends StatelessWidget {
  final List<Item> items = [
    Item(
        tempAsset:
        'https://cdn.shoplightspeed.com/shops/623692/files/15032482/300x250x2/igneous-theory-pet-rock-craft-kit.jpg',
        name: 'rock',
        price: 25),
    Item(
        tempAsset:
        'https://cdn.shoplightspeed.com/shops/623692/files/15032482/300x250x2/igneous-theory-pet-rock-craft-kit.jpg',
        name: 'rock',
        price: 25),
    Item(
        tempAsset:
        'https://cdn.shoplightspeed.com/shops/623692/files/15032482/300x250x2/igneous-theory-pet-rock-craft-kit.jpg',
        name: 'rock',
        price: 25),
    Item(
        tempAsset:
        'https://cdn.shoplightspeed.com/shops/623692/files/15032482/300x250x2/igneous-theory-pet-rock-craft-kit.jpg',
        name: 'rock',
        price: 25),
    Item(
        tempAsset:
        'https://cdn.shoplightspeed.com/shops/623692/files/15032482/300x250x2/igneous-theory-pet-rock-craft-kit.jpg',
        name: 'rock',
        price: 25),
    Item(
        tempAsset:
        'https://cdn.shoplightspeed.com/shops/623692/files/15032482/300x250x2/igneous-theory-pet-rock-craft-kit.jpg',
        name: 'rock',
        price: 25),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Furniture Store'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return GridTile(
            child: Image.network(
              items[index].tempAsset,
              fit: BoxFit.cover,
            ),
            footer: Container(
              child: Text(
                items[index].name,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          );
        },
      ),
    );
  }
}

class Item {
  String tempAsset;
  String name;
  int price;

  Item({required this.tempAsset, required this.name, required this.price});
}
