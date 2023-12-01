import 'package:flutter/material.dart';

class CreaturesPage extends StatefulWidget {
  @override
  ShowcaseCreatures createState() => ShowcaseCreatures();
}

class ShowcaseCreatures extends State<CreaturesPage> {
  late int equipSwitchMode = 0;

  final List<InfoCreature> ownedCreatures = [
    InfoCreature(
        creatureName: 'koala',
        tempAsset:
        'https://i.pinimg.com/originals/2b/51/6d/2b516df24323c3803c66bdec7a714c20.gif'),
    InfoCreature(
        creatureName: 'scooby',
        tempAsset:
        'https://upload.wikimedia.org/wikipedia/en/b/b2/Pluto_%28Disney%29_transparent.png'),
    InfoCreature(
        creatureName: 'dogcat',
        tempAsset:
        'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/ea656545-c0c2-426c-bc41-e47ce5c7a0c9/dfzuuc6-568f505e-6c77-4f57-831e-9b97d7c5a533.png?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcL2VhNjU2NTQ1LWMwYzItNDI2Yy1iYzQxLWU0N2NlNWM3YTBjOVwvZGZ6dXVjNi01NjhmNTA1ZS02Yzc3LTRmNTctODMxZS05Yjk3ZDdjNWE1MzMucG5nIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.GAHY6F6QjR-3PdnUAnUAyAVDMTolLNV41RzEJbMBPzs'),
    InfoCreature(
        creatureName: 'buddah cheese',
        tempAsset:
        'https://cdn.pixabay.com/photo/2013/07/12/17/39/rat-152162_1280.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Creatures"),
      ),
      body: ListView.builder(
        itemCount: ownedCreatures.length,
        itemBuilder: (context, num) {
          return ListTile(
            onTap: () => equipCreature(context, num),
            leading: Image(
              image: NetworkImage(ownedCreatures[num].tempAsset),
            ),
            title: Text(ownedCreatures[num].creatureName),
            subtitle: ownedCreatures[num].status
                ? Text('equipped', style: TextStyle(color: Colors.green))
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
              child: Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Yes"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
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
      if (equipSwitchMode != 0) {
        ownedCreatures[equipSwitchMode].status = false;
      }
      ownedCreatures[num].status = true;
      equipSwitchMode = num;
    });
    popupSnack(context, num);
  }

  void popupSnack(BuildContext context, int num) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${ownedCreatures[num].creatureName} has been equipped'),
        duration: const Duration(milliseconds: 600),
      ),
    );
  }
}

class InfoCreature {
  String creatureName;
  String tempAsset;
  bool status;

  InfoCreature(
      {required this.creatureName,
        required this.tempAsset,
        this.status = false});
}
