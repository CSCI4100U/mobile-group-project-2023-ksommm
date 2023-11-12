import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
        debugShowCheckedModeBanner:false
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => AccessAccPage(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/catLol.png'),
            SizedBox(height: 16),
            const Text(
              'Our app lol IDK how we surviving',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class AccessAccPage extends StatelessWidget {
  const AccessAccPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top:100.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,

            children: [
              const Text("Welcome to our App!",
                  style:
                      TextStyle(
              fontSize:40, fontWeight:FontWeight.bold)),
              SizedBox(height: 36),
              Image.asset('assets/catLol.png', width: 150, height:100),
              SizedBox(
                width: 350,
                child:TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: 350,
                child:TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => homePage(),
                    ),
                  );
                },
                child: Text('Login'),
              ),
              SizedBox(height: 10),
              const Text("Don't have an account?",
                  style:
                  TextStyle(
                      fontSize:20, fontWeight:FontWeight.bold)),
              TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => createAcc(),
                        ),
                      );
                     },
                     child: Text('Create account'))
            ],

          ),
        ),
      ),
    );
  }
}

class createAcc extends StatelessWidget {
@override
Widget build(BuildContext context) {
  return  Scaffold(
    body: Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 100.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              "Create your account",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 350,
              child:TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 350,
              child:TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              "A lil bit about yourself",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 350,
              child:TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Your Name',
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 350,
              child:TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Your City',
                ),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => homePage(),
                  ),
                );
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    ),
  );
}
}




class homePage extends StatelessWidget {
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
            return Text('we messed up: ${snapshot.error}');
          }
          else {
            String weatherStats = snapshot.data?['weatherResults'] as String;
            String coords = snapshot.data?['location'] as String;
            String backgroundScreen = snapshot.data?['imageAsset'] as String;


            return Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'weatherResults: $weatherStats',
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Location: $coords',
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),

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
                                  builder: (context) => settings(),
                                ),
                              );
                            },
                            child: Text('Creatures'),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => settings(),
                                ),
                              );
                            },
                            child: Text('Furniture'),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => settings(),
                                ),
                              );
                            },
                            child: Text('Tasks'),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => achievements(),
                                ),
                              );
                            },
                            child: Text('Achievements'),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => settings(),
                                ),
                              );
                            },
                            child: Text('Settings'),
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

      return {'weatherResults': 'condition: $condition', 'imageAsset': backgroundImage, 'location': location};
    } else {
      throw Exception('api failed us :( ');
    }
  }

  String determineImage(String condition) {

    List<String> clear = ['Sunny','Clear'];
    List<String> cloudy =['Partly cloudy','Cloudy','Overcast','Mist','Fog','Freezing fog'];

    List<String> snow= ['Patchy snow possible','Patchy sleet possible','Blowing snow','Blizzard','Light sleet','Moderate or heavy sleet',
        'Patchy light snow','Light snow','Patchy moderate snow','Moderate snow',
      'Patchy heavy snow','Heavy snow','Patchy light snow with thunder','Moderate or heavy snow with thunder','Light snow showers',
          'Moderate or heavy snow showers'];

    List<String> rain =['Thundery outbreaks possible','Patchy light drizzle','Light drizzle','Freezing drizzle','Heavy freezing drizzle'
    ,'Patchy light rain','Light rain','Moderate rain at times','Moderate rain','Heavy rain at times','Heavy rain','Light freezing rain',
      'Moderate or heavy freezing rain","Moderate or heavy freezing rain','Ice pellets','Light rain shower','Moderate or heavy rain shower',
    'Torrential rain shower','Light sleet showers','Moderate or heavy sleet showers','Light showers of ice pellets','Moderate or heavy showers of ice pellets'
    ,'Patchy light rain with thunder','Moderate or heavy rain with thunder'];


    if (clear.contains(condition)) {
      return 'assets/clearSky.png';
    }
    else if(cloudy.contains(condition)){
      return 'assets/cloudy.png';
    }
    else if(snow.contains(condition)){
      return 'assets/snowing.png';
    }
    else if(rain.contains(condition)){
      return 'assets/raining.png';
    }dd 
    else {
      return 'assets/catLol.png';
    }
  }
}



class settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}
class _SettingsState extends State<settings> {
  int sliderValue1 = 0;
  int sliderValue2 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('SFX: $sliderValue1'),
            Slider(
              value: sliderValue1.toDouble(),
              onChanged: (newValue) {
                setState(() {
                  sliderValue1 = newValue.toInt();
                });
              },
              min: 0,
              max: 100,
            ),
            Text('Music: $sliderValue2'),
            Slider(
              value: sliderValue2.toDouble(),
              onChanged: (newValue) {
                setState(() {
                  sliderValue2 = newValue.toInt();
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
                child:
                  Text("We really in beta mode rn"),
              ),
              ),
          ],
        ),

      ),
    );
  }
}


class achievements extends StatelessWidget {
  final List<Map<String, String>> challenges = [

    {'Award Name': '5 Day Streak',  'Desc': 'example '},
    {'Award Name': '10 Day Streak', 'Desc': 'exmaple'},
    {'Award Name': '11 Day Streak', 'Desc': 'example'},
    {'Award Name': '12 Day Streak', 'Desc': 'example'},
    {'Award Name': '13 Day Streak', 'Desc': 'example'},
  ];


  String trophyUnlocked(int index) {
    return index % 2 == 0 ? 'assets/lockedTrophy.png' : 'assets/unlockedTrophy.png';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Achievements'),
      ),

      body: ListView.builder(
        itemCount: challenges.length,

        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(trophyUnlocked(index)),
            ),
            title: Text(
              challenges[index]['Award Name']!,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(challenges[index]['Desc']!),
              ],
            ),
          );
        },
      ),
    );
  }
}









