import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
      appBar: AppBar(
        title: const Text("Your Creatures"),
      ),
      body: ListView.builder(
        itemCount: ownedCreatures.length,
        itemBuilder: (context, num) {
          return ListTile(
            onTap: () => equipCreature(context, num),
            leading: Image.network(
              ownedCreatures[num].tempAsset,
              width: 50,
              height: 50,
            ),
            title: Text(ownedCreatures[num].creatureName),
            subtitle: ownedCreatures[num].status
                ? const Text('equipped', style: TextStyle(color: Colors.green))
                : null,
          );
        },
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