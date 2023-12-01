import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:main/pages/achievements.dart';
import 'package:main/pages/creatures.dart';
import 'package:main/pages/ItemsStore.dart';
import 'package:main/pages/settings.dart';
import 'dart:convert';

import 'mainTaskPage.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getLocationAndWeather(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
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

            return Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    /*
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Weather Results: $weatherStats',
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Location: $coords',
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),

                     */
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
                // Buttons
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => CreaturesPage(),
                                ),
                              );
                            },
                            child: Text('Pets', style:TextStyle(fontSize: 12.0)),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => FurnitureStore(),
                                ),
                              );
                            },
                            child: Text('Furniture',style:TextStyle(fontSize: 12.0)),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => mainTaskPage(),
                                ),
                              );
                            },
                            child: Text('Tasks',style:TextStyle(fontSize: 12.0)),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => AchievementsPage(),
                                ),
                              );
                            },
                            child: Text('Trophys',style:TextStyle(fontSize: 12.0)),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => SettingsPage(),
                                ),
                              );
                            },
                            child: Text('Settings',style:TextStyle(fontSize: 12.0)),
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
    Position pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

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
}
