import 'package:flutter/material.dart';

class CreaturesPage extends StatefulWidget {
  @override
  _CreaturesPageState createState() => _CreaturesPageState();
}

class _CreaturesPageState extends State<CreaturesPage> {
  List<InfoCreature> ownedCreatures = [
    InfoCreature(
      creatureName: 'koala',
      tempAsset: 'https://i.pinimg.com/originals/2b/51/6d/2b516df24323c3803c66bdec7a714c20.gif',
    ),
    InfoCreature(
      creatureName: 'scooby',
      tempAsset: 'https://upload.wikimedia.org/wikipedia/en/b/b2/Pluto_%28Disney%29_transparent.png',
    ),
    InfoCreature(
      creatureName: 'dogcat',
      tempAsset: 'https://static.wikia.nocookie.net/p__/images/9/9b/CatDog_render.png/revision/latest?cb=20210110223051&path-prefix=protagonist',
    ),
    InfoCreature(
      creatureName: 'buddah cheese',
      tempAsset: 'https://cdn.pixabay.com/photo/2013/07/12/17/39/rat-152162_1280.png',
    ),
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 0.92),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, size: 35),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Let\'s pick your pet from the litter',
                    style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 35),
                  const Text(
                    'All your owned creatures',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Container(

              color: const Color.fromRGBO(243, 243,243, 1.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: ownedCreatures.length,
                primary: false,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(15),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(232, 229, 220, 1.0),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: InkWell(
                          onTap: () {
                            equipCreature(context, index);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                Image.network(
                                  ownedCreatures[index].tempAsset,
                                  width: 250,
                                  height: 100,
                                ),
                                Text(
                                  ownedCreatures[index].creatureName,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void equipCreature(BuildContext context, int num) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Equip ${ownedCreatures[num].creatureName}?"),
          actions: <Widget>[
            TextButton(
              child: const Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Yes"),
              onPressed: () {
                Navigator.of(context).pop();
                confirmEquipCreature(context, num);
              },
            ),
          ],
        );
      },
    );
  }

  void confirmEquipCreature(BuildContext context, int num) {
    setState(() {
      for (var creature in ownedCreatures) {
        creature.status = false;
      }
      ownedCreatures[num].status = true;
    });
    Navigator.of(context).pop(ownedCreatures[num]);
  }
}

class InfoCreature {
  String creatureName;
  String tempAsset;
  bool status;

  InfoCreature({
    required this.creatureName,
    required this.tempAsset,
    this.status = false,
  });
}
