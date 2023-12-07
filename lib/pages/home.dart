import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:main/pages/CreatureModel.dart';
import 'package:main/pages/achievements.dart';
import 'package:main/pages/creatures.dart';
import 'package:main/pages/ItemsStore.dart';
import 'package:main/pages/settings.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:convert';
import 'package:main/pages/FurnitureModel.dart';

import 'Creature.dart';
import 'CreatureModel.dart';
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

class FurnitureItems extends StatelessWidget {
  FurnituresModel furnitureModel = FurnituresModel();

  FurnitureItems({super.key});

  final Map<String, Offset> positionMap = {
    'left': const Offset(0, 400),
    'right': const Offset(300, 400),
    // Add more positions and their corresponding coordinates
  };

  // // Returns list of furniture items that are selected
  // List getSelected() {
  //   return furnitureList.where((furniture) => furniture.selected == 1).toList();
  // }

  @override
  Widget build(BuildContext context) {



    // This stack places all selected furniture's images on screen
    return FutureBuilder(
      future: furnitureModel.getAllFurnitures(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error fetching data'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No images found'));
        } else {
          List furnitureList = snapshot.data!;

          // // Get list of only furniture with selected == 1 for displaying
          List selectedFurniture =
          furnitureList.where((furniture) => furniture.selected == 1).toList();
          return Stack(
            // create map of selected furniture and place them based on location
            children: selectedFurniture.map((furnitureItem) {
              final String imageName = furnitureItem.name;
              final String positionString = furnitureItem.location;
              final Offset position = positionMap[positionString] ??
                  Offset
                      .zero; // Using positionMap to get the corresponding offset, defaulting to zero offset
              return Positioned(
                left: position.dx, // X-coordinate based on position
                top: position.dy, // Y-coordinate based on position
                child: Transform.scale(
                  scale: 2,
                  child: Image.asset(
                    'assets/images/$imageName.png',
                    width: 100,
                    height: 100,
                  ),
                ),
              );
            }).toList(),
          );
        }
      },
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int runCheck = 0;

  Future<void> updateList() async {
    var _creature = CreatureModel();

    List<InfoCreature> ownedCreatures = [
      InfoCreature(
        creatureName: 'koala',
        tempAsset:
            'https://i.pinimg.com/originals/2b/51/6d/2b516df24323c3803c66bdec7a714c20.gif',
      ),
      InfoCreature(
        creatureName: 'scooby',
        tempAsset:
            'https://upload.wikimedia.org/wikipedia/en/b/b2/Pluto_%28Disney%29_transparent.png',
      ),
      InfoCreature(
        creatureName: 'dogcat',
        tempAsset:
            'https://static.wikia.nocookie.net/p__/images/9/9b/CatDog_render.png/revision/latest?cb=20210110223051&path-prefix=protagonist',
      ),
      InfoCreature(
        creatureName: 'big cheese',
        tempAsset:
            'https://cdn.pixabay.com/photo/2013/07/12/17/39/rat-152162_1280.png',
      ),
    ];
    var list = await _creature.getAllCreatures();

    if (list.length == 0) {
      for (int i = 0; i < ownedCreatures.length; i++) {
        print(ownedCreatures[i].creatureName);
        print(ownedCreatures[i].tempAsset);

        Creature creature = new Creature(
            id: i + 1,
            name: ownedCreatures[i].creatureName,
            asset: ownedCreatures[i].tempAsset,
            obtained: 0);
        _creature.insertCreature(creature);
      }
    }
    setState(() {
      ownedCreatures = ownedCreatures;
    });
  }

  String? homePageBackgroundImage;
  InfoCreature? equippedCreature;
  AudioPlayer audioPlayer = AudioPlayer();

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    playMusic(50);

    return Scaffold(
      body: FutureBuilder(
        future: getLocationAndWeather(),
        builder: (context, snapshot) {
          //Determines if the API call is functional and will allow for their to be a background image
          // to display the current weather
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
            //determines if there is a creautre already equipped and if so displays it
            String creatureSelected = equippedCreature?.tempAsset ??
                snapshot.data?['imageAsset'] as String;

            if (runCheck == 0) {
              updateList().then((value) async {
                print('Load done Monster');
              });
              runCheck++;
            }

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

                  ],
                ),
                Center(child: FurnitureItems()), // TODO: PLACE FURNITURE FUTUREBUILDER IN HERE
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: Colors.blue,
                    currentIndex: _selectedIndex,
                    unselectedItemColor: Colors.white,
                    selectedItemColor: Colors.white,
                    onTap: _onItemTapped,
                    items: const <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: Icon(Icons.pets),
                        label: 'Pets',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.weekend),
                        label: 'Furniture',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.assignment),
                        label: 'Tasks',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.emoji_events),
                        label: 'Trophies',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.settings, color: Colors.white),
                        label: 'Settings',
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        _navigateToCreaturesPage();
        break;
      case 1:
        _navigateToFurnitureStore();
        break;
      case 2:
        _navigateToTasksPage();
        break;
      case 3:
        _navigateToAchievementsPage();
        break;
      case 4:
        _navigateToSettingsPage();
        break;
    }
  }
  //Loops Background Audio while the app is running
  Future<void> playMusic(int volSlider) async {
    if (!audioPlayer.playing) {
      await audioPlayer.setAsset('assets/backgroundAudio.wav');
      audioPlayer.play();
      audioPlayer.setVolume(volSlider / 100);
      audioPlayer.setLoopMode(LoopMode.one);
    }
  }
//request users for their location to be able ot get a background screen that shows their weather
  Future<Map<String, dynamic>> getLocationAndWeather() async {
    var perms = await Permission.location.request();
    Position pos;
    if (perms == PermissionStatus.granted) {
      pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } else {
      throw Exception("No location available");
    }

    String ourSecretAPIKey = 'd4d679ec60a64104b28103140231011';
    String urlAPI =
        'http://api.weatherapi.com/v1/current.json?key=$ourSecretAPIKey&q=${pos.latitude},${pos.longitude}';

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

  void _navigateToCreaturesPage() async {
    final selectedCreature = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CreaturesPage(),
      ),
    );
    if (selectedCreature != null) {
      setState(() {
        equippedCreature = selectedCreature;
      });
    }
  }

  void _navigateToFurnitureStore() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FurnitureStore(),
      ),
    );
  }

  void _navigateToTasksPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => mainTaskPage(),
      ),
    );
  }

  void _navigateToAchievementsPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AchievementsPage(),
      ),
    );
  }

  void _navigateToSettingsPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SettingsPage(playMusic: (volSlider) {
          playMusic(volSlider);
        }),
      ),
    );
  }
}
