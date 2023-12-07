import 'package:flutter/material.dart';
import 'package:main/pages/FurnitureModel.dart';

import 'Furniture.dart';

class FurnitureStore extends StatelessWidget {
  final List<Item> items = [
    Item(
      tempAsset:
      'https://cdn.shoplightspeed.com/shops/623692/files/15032482/300x250x2/igneous-theory-pet-rock-craft-kit.jpg',
      name: 'Rock',
      price: 25,
    ),
    Item(
      tempAsset:
      'https://cdn.shoplightspeed.com/shops/623692/files/15032482/300x250x2/igneous-theory-pet-rock-craft-kit.jpg',
      name: 'Rock',
      price: 25,
    ),
  ];







  @override
  Widget build(BuildContext context) {



    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, size: 35),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              SizedBox(height: 25),
              const Text(
                'Furniture Store',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 25),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                              child: Image.network(
                                items[index].tempAsset,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  items[index].name,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '\$${items[index].price}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
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
