import 'package:flutter/material.dart';

class AchievementsPage extends StatelessWidget {
class AchievementsPage extends StatefulWidget {
  @override
  _AchievementsPageState createState() => _AchievementsPageState();
}

class _AchievementsPageState extends State<AchievementsPage> {
  int maxStreak = 22;
  int totalTasksCompleted = 25;
  int totalPets = 6;

  final List<Map<String, String>> challenges = [
    {'Award Name': '5 Day Streak', 'Desc': 'example '},
    {'Award Name': '10 Day Streak', 'Desc': 'exmaple'},
    {'Award Name': '11 Day Streak', 'Desc': 'example'},
    {'Award Name': '12 Day Streak', 'Desc': 'example'},
    {'Award Name': '13 Day Streak', 'Desc': 'example'},
    {'Award Name': 'Streak I', 'Desc': 'Complete 3 Tasks In a Row'},
    {'Award Name': 'Streak II', 'Desc': 'Complete 10 Tasks In a Row'},
    {'Award Name': 'Streak III', 'Desc': 'Complete 15 Tasks In a Row'},
    {'Award Name': 'Task Completionist', 'Desc': 'Finish 10 Tasks'},
    {'Award Name': 'The Zoo', 'Desc': 'Own 5 Pets'},
  ];

  String trophyUnlocked(int index) {
    return index % 2 == 0
        ? 'assets/lockedTrophy.png'
        : 'assets/unlockedTrophy.png';
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

    if (awardName.toLowerCase().contains('task completionist') && totalTasksCompleted >= 10) {
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
      backgroundColor: const Color.fromRGBO(255, 255, 255, 0.92),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 16.0, top: 20.0, right: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(challenges[index]['Desc']!),
              ],
            ),
          );
        },
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            color: const Color.fromRGBO(243, 243, 243, 1.0),
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
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
                          radius: 50.0,
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
