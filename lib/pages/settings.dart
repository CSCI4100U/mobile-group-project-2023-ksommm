import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:main/storage/firestore_service.dart';

AudioPlayer audioPlayer = AudioPlayer();
int volSlider = 50;

class SettingsPage extends StatefulWidget {
  final Function(int) playMusic;

  SettingsPage({required this.playMusic});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, size: 35),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            const Text(
              'Settings',
              style: TextStyle(fontSize: 44, fontWeight: FontWeight.bold),
            ),
            //Slider connected to main page, when adjusted will control the volume of the background music playing
            ListTile(
              title: Text('Music Volume: $volSlider'),
              subtitle: Slider(
                value: volSlider.toDouble(),
                onChanged: (newValue) {
                  setState(() {
                    volSlider = newValue.toInt();
                    audioPlayer.setVolume(volSlider / 100);
                    widget.playMusic(volSlider);
                  });
                },
                min: 0,
                max: 100,
              ),
            ),
            const Divider(),
            // Take table from sqlite and replace firestore
            ElevatedButton(
              onPressed: () {
                FirestoreService firestoreService = FirestoreService();
                firestoreService.replaceSqliteWithFirestore();
              },
              child: const Text('Save Monsters and Furniture to Cloud'),
            ),
            // Take table from firestore and replace sqlite
            ElevatedButton(
              onPressed: () {
                FirestoreService firestoreService = FirestoreService();
                firestoreService.replaceFirestoreWithSqlite();
              },
              child: const Text('Load Monsters and Furniture from Cloud'),
            ),
            const Divider(),
            ElevatedButton(
              onPressed: () {
                _showDialog(context, 'Privacy Policy',
                    'Selling back to you for \$3.99');
              },
              child: const Text('Privacy Policy'),
            ),
            ElevatedButton(
              onPressed: () {
                _showDialog(context, 'Credits', 'matthew, keeran, omar');
              },
              child: const Text('Credits'),
            ),
            const Spacer(),
            const Text(
              "We're really in beta mode right now",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
