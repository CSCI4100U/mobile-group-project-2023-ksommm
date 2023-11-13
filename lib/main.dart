import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:main/auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:main/mainTaskPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: SplashScreen(), debugShowCheckedModeBanner: false);
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
        builder: (context) => LoginScreen(),
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
            SizedBox(height: 17),
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

// class AccessAccPage extends StatelessWidget {
//   const AccessAccPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.only(top: 100.0),
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 const Text("Welcome to our App!",
//                     style:
//                         TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
//                 SizedBox(height: 36),
//                 Image.asset('assets/catLol.png', width: 150, height: 100),
//                 SizedBox(
//                   width: 350,
//                   child: TextFormField(
//                     decoration: const InputDecoration(
//                       labelText: 'Email',
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 SizedBox(
//                   width: 350,
//                   child: TextFormField(
//                     obscureText: true,
//                     decoration: const InputDecoration(
//                       labelText: 'Password',
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => homePage(),
//                       ),
//                     );
//                   },
//                   child: Text('Login'),
//                 ),
//                 SizedBox(height: 10),
//                 const Text("Don't have an account?",
//                     style:
//                         TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                 TextButton(
//                     onPressed: () {
//                       Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (context) => createAcc(),
//                         ),
//                       );
//                     },
//                     child: Text('Create account'))
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => homePage(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => homePage(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
      return;
    }
  }

  Widget _entryField(
    String title,
    TextEditingController controller,
  ) {
    return TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: title,
        ));
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : "Error: $errorMessage");
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed:
          isLogin ? signInWithEmailAndPassword : createUserWithEmailAndPassword,
      child: Text(isLogin ? 'Login' : 'Register'),
    );
  }

  Widget _loginOrRegisterButton() {
    return TextButton(
      onPressed: () {
        setState(() {
          isLogin = !isLogin;
        });
      },
      child: Text(isLogin ? 'Register Instead' : 'Login instead'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Welcome to our App!",
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(
                    height: 160,
                    width: 160,
                    child: Image.asset('assets/catLol.png')),
                _entryField('email', _controllerEmail),
                _entryField('password', _controllerPassword),
                _errorMessage(),
                _submitButton(),
                _loginOrRegisterButton(),
              ]),
        ),
      ),
    ));
  }
}

// class createAcc extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.only(top: 100.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               const Text(
//                 "Create your account",
//                 style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 10),
//               SizedBox(
//                 width: 350,
//                 child: TextFormField(
//                   decoration: const InputDecoration(
//                     labelText: 'Email',
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               SizedBox(
//                 width: 350,
//                 child: TextFormField(
//                   obscureText: true,
//                   decoration: const InputDecoration(
//                     labelText: 'Password',
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 40),
//               const Text(
//                 "A lil bit about yourself",
//                 style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 10),
//               SizedBox(
//                 width: 350,
//                 child: TextFormField(
//                   decoration: const InputDecoration(
//                     labelText: 'Your Name',
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               SizedBox(
//                 width: 350,
//                 child: TextFormField(
//                   decoration: const InputDecoration(
//                     labelText: 'Your City',
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 40),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) => homePage(),
//                     ),
//                   );
//                 },
//                 child: Text('Submit'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

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
          } else {
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
                                  builder: (context) => creatures(),
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
                                  builder: (context) => furnitureStore(),
                                ),
                              );
                            },
                            child: Text('Furniture'),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => mainTaskPage()));
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

      return {
        'weatherResults': 'condition: $condition',
        'imageAsset': backgroundImage,
        'location': location
      };
    } else {
      throw Exception('api failed us :( ');
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
      'Moderate or heavy freezing rain","Moderate or heavy freezing rain',
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

class settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<settings> {
  int sfxVolSlider = 0;
  int volSlider = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('SFX: $sfxVolSlider'),
            Slider(
              value: sfxVolSlider.toDouble(),
              onChanged: (newValue) {
                setState(() {
                  sfxVolSlider = newValue.toInt();
                });
              },
              min: 0,
              max: 100,
            ),
            Text('Music: $volSlider'),
            Slider(
              value: volSlider.toDouble(),
              onChanged: (newValue) {
                setState(() {
                  volSlider = newValue.toInt();
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

class achievements extends StatelessWidget {
  final List<Map<String, String>> challenges = [
    {'Award Name': '5 Day Streak', 'Desc': 'example '},
    {'Award Name': '10 Day Streak', 'Desc': 'exmaple'},
    {'Award Name': '11 Day Streak', 'Desc': 'example'},
    {'Award Name': '12 Day Streak', 'Desc': 'example'},
    {'Award Name': '13 Day Streak', 'Desc': 'example'},
  ];

  String trophyUnlocked(int index) {
    return index % 2 == 0
        ? 'assets/lockedTrophy.png'
        : 'assets/unlockedTrophy.png';
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

class infoCreature {
  String creatureName;
  String tempAsset;
  bool status;

  infoCreature(
      {required this.creatureName,
      required this.tempAsset,
      this.status = false});
}

class creatures extends StatefulWidget {
  @override
  showcaseCreatures createState() => showcaseCreatures();
}

class showcaseCreatures extends State<creatures> {
  late int equipSwitchMode = 0;

  final List<infoCreature> ownedCreatures = [
    infoCreature(
        creatureName: 'koala',
        tempAsset:
            'https://i.pinimg.com/originals/2b/51/6d/2b516df24323c3803c66bdec7a714c20.gif'),
    infoCreature(
        creatureName: 'scooby',
        tempAsset:
            'https://upload.wikimedia.org/wikipedia/en/b/b2/Pluto_%28Disney%29_transparent.png'),
    infoCreature(
        creatureName: 'dogcat',
        tempAsset:
            'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/ea656545-c0c2-426c-bc41-e47ce5c7a0c9/dfzuuc6-568f505e-6c77-4f57-831e-9b97d7c5a533.png?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcL2VhNjU2NTQ1LWMwYzItNDI2Yy1iYzQxLWU0N2NlNWM3YTBjOVwvZGZ6dXVjNi01NjhmNTA1ZS02Yzc3LTRmNTctODMxZS05Yjk3ZDdjNWE1MzMucG5nIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.GAHY6F6QjR-3PdnUAnUAyAVDMTolLNV41RzEJbMBPzs'),
    infoCreature(
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
                ? Text('equiped', style: TextStyle(color: Colors.green))
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
        duration: const Duration(seconds: 3),
      ),
    );````````````````````
  }
}

class Item {
  String tempAsset;
  String name;
  int price;

  Item({required this.tempAsset, required this.name, required this.price});
}

class furnitureStore extends StatelessWidget {
  final List<Item> items = [
    Item(
        tempAsset:
            'https://cdn.shoplightspeed.com/shops/623692/files/15032482/300x250x2/igneous-theory-pet-rock-craft-kit.jpg',
        name: 'rock',
        price: 25),
    Item(
        tempAsset:
            'https://cdn.shoplightspeed.com/shops/623692/files/15032482/300x250x2/igneous-theory-pet-rock-craft-kit.jpg',
        name: 'rock',
        price: 25),
    Item(
        tempAsset:
            'https://cdn.shoplightspeed.com/shops/623692/files/15032482/300x250x2/igneous-theory-pet-rock-craft-kit.jpg',
        name: 'rock',
        price: 25),
    Item(
        tempAsset:
            'https://cdn.shoplightspeed.com/shops/623692/files/15032482/300x250x2/igneous-theory-pet-rock-craft-kit.jpg',
        name: 'rock',
        price: 25),
    Item(
        tempAsset:
            'https://cdn.shoplightspeed.com/shops/623692/files/15032482/300x250x2/igneous-theory-pet-rock-craft-kit.jpg',
        name: 'rock',
        price: 25),
    Item(
        tempAsset:
            'https://cdn.shoplightspeed.com/shops/623692/files/15032482/300x250x2/igneous-theory-pet-rock-craft-kit.jpg',
        name: 'rock',
        price: 25),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Furniture Store'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return GridTile(
            child: Image.network(
              items[index].tempAsset,
              fit: BoxFit.cover,
            ),
            footer: Container(
              child: Text(
                items[index].name,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          );
        },
      ),
    );
  }
}
