import 'package:flutter/material.dart';

class AchievementsPage extends StatelessWidget {
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
