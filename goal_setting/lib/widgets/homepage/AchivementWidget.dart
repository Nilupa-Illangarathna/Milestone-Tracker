import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data_classes/sub classes/achievement_class.dart';

class AchievementWidget extends StatelessWidget {
  final Achievement achievement;

  const AchievementWidget({Key? key, required this.achievement}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color:Color(0xFFF8DE7E),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      child: ListTile(
        leading: _buildAwardBadge(),
        title: Text(
          achievement.name,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Description: ${achievement.description}',
              style: TextStyle(color: Colors.black),
            ),
            Text(
              'Date Earned: ${DateFormat('yyyy-MM-dd').format(achievement.dateEarned)}',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAwardBadge() {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.orange,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.star,
        color: Colors.amber,
        size: 24,
      ),
    );
  }
}