import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:main/auth.dart';

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
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => homePage(),
      ),
    );
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => homePage(),
      ),
    );
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
      body: Stack(
        children: [
          Image.asset(
            'assets/homescreen.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
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
                            builder: (context) => settings(),
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
      ),
    );
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
                child: Text("We really in beta mode rn"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
