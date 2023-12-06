import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:main/pages/achievements.dart';
import 'package:main/pages/creatures.dart';
import 'package:main/pages/ItemsStore.dart';
import 'package:main/pages/settings.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:convert';

import 'mainTaskPage.dart';
import 'settings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? homePageBackgroundImage;
  InfoCreature? equippedCreature;

  @override
  Widget build(BuildContext context) {
    playMusic(0);
    return Scaffold(
      body: FutureBuilder(
        future: getLocationAndWeather(),
        builder: (context, snapshot) {
          if (!snapshot.hasData && !snapshot.hasError) {
            return Image.asset(
              'assets/background.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            );
          }
          if (snapshot.hasError) {
            return Text('We messed up: ${snapshot.error}');
          } else {
            String weatherStats = snapshot.data?['weatherResults'] as String;
            String coords = snapshot.data?['location'] as String;
            String backgroundScreen = snapshot.data?['imageAsset'] as String;
            String creatureSelected = equippedCreature?.tempAsset ??
                snapshot.data?['imageAsset'] as String;

            return Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Image.asset(
                        backgroundScreen,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (equippedCreature != null)
                      Center(
                        child: Transform.translate(
                          offset: Offset(0.0, 5.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                equippedCreature!.tempAsset,
                                width: 200,
                                height: 250,
                              ),
                            ],
                          ),
                        ),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          flex: 2,
                          child: ElevatedButton(
                            onPressed: () async {
                              final selectedCreature =
                              await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => CreaturesPage(),
                                ),
                              );
                              if (selectedCreature != null) {
                                setState(() {
                                  equippedCreature = selectedCreature;
                                });
                              }
                            },
                            child:
                            Text('Pets', style: TextStyle(fontSize: 12.0)),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => FurnitureStore(),
                                ),
                              );
                            },
                            child: Text('Furniture',
                                style: TextStyle(fontSize: 12.0)),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => mainTaskPage(),
                                ),
                              );
                            },
                            child:
                            Text('Tasks', style: TextStyle(fontSize: 12.0)),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => AchievementsPage(),
                                ),
                              );
                            },
                            child: Text('Trophys',
                                style: TextStyle(fontSize: 12.0)),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      SettingsPage(playMusic: (volSlider) {
                                        playMusic:
                                        (volSlider);
                                      }),
                                ),
                              );
                            },
                            child: Text('Settings',
                                style: TextStyle(fontSize: 12.0)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Future<Map<String, dynamic>> getLocationAndWeather() async {
    var perms = await Permission.location.request();
    Position pos;
    if (perms == PermissionStatus.granted) {
      pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    }
    else {
      throw Exception("No location available");
    }

    String ourSecretAPIKey = 'd4d679ec60a64104b28103140231011';
    String urlAPI =
        'http://api.weatherapi.com/v1/current.json?key=$ourSecretAPIKey&q=${pos
        .latitude},${pos.longitude}';

    final response = await http.get(Uri.parse(urlAPI));
    if (response.statusCode == 200) {
      var apiOutput = json.decode(response.body);

      String condition = apiOutput['current']['condition']['text'];
      String backgroundImage = determineImage(condition);

      String location = '${pos.latitude}, ${pos.longitude}';

      return {
        'weatherResults': 'Condition: $condition',
        'imageAsset': backgroundImage,
        'location': location
      };
    } else {
      throw Exception('API failed us :( ');
    }
  }

  String determineImage(String condition) {
    List<String> clear = ['Sunny', 'Clear'];
    List<String> cloudy = [
      'Partly cloudy',
      'Cloudy',
      'Overcast',
      'Mist',
      'Fog',
      'Freezing fog'
    ];

    List<String> snow = [
      'Patchy snow possible',
      'Patchy sleet possible',
      'Blowing snow',
      'Blizzard',
      'Light sleet',
      'Moderate or heavy sleet',
      'Patchy light snow',
      'Light snow',
      'Patchy moderate snow',
      'Moderate snow',
      'Patchy heavy snow',
      'Heavy snow',
      'Patchy light snow with thunder',
      'Moderate or heavy snow with thunder',
      'Light snow showers',
      'Moderate or heavy snow showers'
    ];

    List<String> rain = [
      'Thundery outbreaks possible',
      'Patchy light drizzle',
      'Light drizzle',
      'Freezing drizzle',
      'Heavy freezing drizzle',
      'Patchy light rain',
      'Light rain',
      'Moderate rain at times',
      'Moderate rain',
      'Heavy rain at times',
      'Heavy rain',
      'Light freezing rain',
      'Moderate or heavy freezing rain',
      'Ice pellets',
      'Light rain shower',
      'Moderate or heavy rain shower',
      'Torrential rain shower',
      'Light sleet showers',
      'Moderate or heavy sleet showers',
      'Light showers of ice pellets',
      'Moderate or heavy showers of ice pellets',
      'Patchy light rain with thunder',
      'Moderate or heavy rain with thunder'
    ];

    if (clear.contains(condition)) {
      return 'assets/clearSky.png';
    } else if (cloudy.contains(condition)) {
      return 'assets/cloudy.png';
    } else if (snow.contains(condition)) {
      return 'assets/snowing.png';
    } else if (rain.contains(condition)) {
      return 'assets/raining.png';
    } else {
      return 'assets/catLol.png';
    }
  }

  Future<void> playMusic(int volSlider) async {
    if (!audioPlayer.playing) {
      await audioPlayer.setAsset('assets/backgroundAudio.wav');
      audioPlayer.play();
      audioPlayer.setVolume(volSlider / 100);
      audioPlayer.setLoopMode(LoopMode.one);
    }
  }
}
