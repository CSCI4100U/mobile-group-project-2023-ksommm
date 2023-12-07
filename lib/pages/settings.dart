import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

AudioPlayer audioPlayer = AudioPlayer();
int volSlider=50;

class SettingsPage extends StatefulWidget {
  final Function(int) playMusic;

  SettingsPage({required this.playMusic});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int volSlider = 50;

/*
  @override
  void initState() {
    super.initState();
    initializeAudioPlayer();
  }
  void initializeAudioPlayer() async {
    if (!audioPlayer.playing) {
      await audioPlayer.setAsset('assets/backgroundAudio.wav');
      audioPlayer.setVolume(volSlider / 100);
      audioPlayer.setLoopMode(LoopMode.one);
    }
  }

 */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Music: $volSlider'),
            Slider(
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
            TextButton(
            const Text(
              'Settings',
              style: TextStyle(fontSize: 44, fontWeight: FontWeight.bold),
            ),
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
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Privacy Policy'),
                      content: const Text('Selling back to you for \$3.99'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Close'),
                        ),
                      ],
                    );
                  },
                );
                _showDialog(context, 'Privacy Policy', 'Selling back to you for \$3.99');
              },
              child: Text('Privacy Policy'),
              child: const Text('Privacy Policy'),
            ),
            TextButton(
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Credits'),
                      content: Text('matthew,keeran,omar'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Close'),
                        ),
                      ],
                    );
                  },
                );
                _showDialog(context, 'Credits', 'matthew, keeran, omar');
              },
              child: Text('Credits'),
              child: const Text('Credits'),
            ),
            const Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Text("We really in beta mode rn"),
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
