import 'package:flutter/material.dart';

class AchievementsPage extends StatefulWidget {
  @override
  _AchievementsPageState createState() => _AchievementsPageState();
}

class _AchievementsPageState extends State<AchievementsPage> {
  //predetermined stats for now
  int maxStreak = 22;
  int totalTasksCompleted = 25;
  int totalPets = 6;

  final List<Map<String, String>> challenges = [
    {'Award Name': 'Streak I', 'Desc': 'Complete 3 Tasks In a Row'},
    {'Award Name': 'Streak II', 'Desc': 'Complete 10 Tasks In a Row'},
    {'Award Name': 'Streak III', 'Desc': 'Complete 15 Tasks In a Row'},
    {'Award Name': 'Task Master', 'Desc': 'Finish 10 Tasks'},
    {'Award Name': 'The Zoo', 'Desc': 'Own 5 Pets'},
  ];
//Determines whether the users stats have the nessecary requirements to complete the challenges
  //Returns image to determine its completion
  String trophyUnlocked(int index, String awardName) {
    if (awardName.toLowerCase().contains('streak i') && maxStreak >= 3) {
      return 'assets/unlockedTrophy.png';
    }

    if (awardName.toLowerCase().contains('streak ii') && maxStreak >= 10) {
      return 'assets/unlockedTrophy.png';
    }

    if (awardName.toLowerCase().contains('streak iii') && maxStreak >= 15) {
      return 'assets/unlockedTrophy.png';
    }

    if (awardName.toLowerCase().contains('Task Master') && totalTasksCompleted >= 10) {
      return 'assets/unlockedTrophy.png';
    }

    if (awardName.toLowerCase().contains('the zoo') && totalPets >= 5) {
      return 'assets/unlockedTrophy.png';
    }

    return 'assets/lockedTrophy.png';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 0.92),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 16.0, top: 20.0, right: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, size: 35),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const Text(
                  'Your',
                  style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const Text(
                  'Achievements',
                  style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            color: const Color.fromRGBO(243, 243, 243, 1.0),
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 6.0,
                mainAxisSpacing: 6.0,
              ),
              itemCount: challenges.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(challenges[index]['Award Name']!),
                          content: Text(challenges[index]['Desc']!),
                          actions: [
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
                  },
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 20.0,
                          backgroundImage: AssetImage(trophyUnlocked(index, challenges[index]['Award Name']!)),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          challenges[index]['Award Name']!,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );

  }
}
