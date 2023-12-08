import 'package:flutter/material.dart';
import 'package:main/pages/Furniture.dart';
import 'home.dart';
import 'package:main/pages/FurnitureModel.dart';

class FurnitureStore extends StatelessWidget {
  FurnituresModel furnitureModel = FurnituresModel();
  final List furnitureList = [];

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
              SizedBox(height: 45),
              // Futurebuilder for getting furniture attributes from sqlite
              FutureBuilder(
                  future: furnitureModel.getAllFurnitures(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error fetching data'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No images found'));
                    } else {
                      List furnitureList = snapshot.data!;

                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 8.0,
                            ),
                            itemCount: furnitureList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  _showEquipDialog(context,
                                      furnitureList[index], furnitureList);
                                },
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Expanded(
                                        child: Image.asset(
                                          'assets/images/${furnitureList[index].name}.png',
                                          width: 100,
                                          height: 100,
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              furnitureList[index].name,
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              '${furnitureList[index].location}',
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  void _showEquipDialog(
      BuildContext context, Furniture furniture, List furnitureList) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Equip Item'),
          content: Text('Do you want to equip ${furniture.name}?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Equip'),
              onPressed: () {
                // TODO: check in database if anything with same position is selected. If so, set old to selected = 0. Set new furniture to selected = 1.
                furnitureList.forEach((furnitureItem) {
                  if (furnitureItem.selected == 1 &&
                      furnitureItem.location == furniture.location) {
                    // Update 'selected' property from 1 to 0 for selected furniture item
                    furnitureItem.selected = 0;
                    furnitureModel.updateFurniture(furnitureItem);
                  }
                });
                furniture.selected = 1;
                furnitureModel.updateFurniture(furniture);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
