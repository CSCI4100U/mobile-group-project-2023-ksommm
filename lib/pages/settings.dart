import 'package:flutter/material.dart';
import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

AudioPlayer audioPlayer = AudioPlayer();
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
        child: Column(
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
            ),
            TextButton(
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
              },
              child: Text('Privacy Policy'),
            ),
            TextButton(
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
              },
              child: Text('Credits'),
            ),
            const Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Text("We really in beta mode rn"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
