import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data_classes/sub classes/task_class.dart';
import 'AchivementWidget.dart';
import 'ProgressWidget.dart';
import 'ReportWidget.dart';

class TaskWidget extends StatelessWidget {
  final Task task;

  const TaskWidget({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue.withOpacity(0.1),
      elevation: 0.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Task - ${task.name}:',
              style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1A237E), fontSize:19),
            ),
            SizedBox(height: 8),
            Text(
              'Start Date: ${DateFormat('yyyy-MM-dd').format(task.startDate)}',
              style: TextStyle(color: Colors.black),
            ),
            Text(
              'Target Date: ${DateFormat('yyyy-MM-dd').format(task.targetDate)}',
              style: TextStyle(color: Colors.black),
            ),
            Text(
              'Completed: ${task.completed}',
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 8),
            Text(
              'Achievements:',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo),
            ),
            SizedBox(height: 8),
            ...task.achievements.map((achievement) => AchievementWidget(achievement: achievement)),
            SizedBox(height: 8),
            Text(
              'Report:',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo),
            ),
            SizedBox(height: 8),
            ReportWidget(report: task.report, task: task),
            SizedBox(height: 8),
            Text(
              'Progress:',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo),
            ),
            SizedBox(height: 8),
            ProgressWidget(progress: task.progress),
          ],
        ),
      ),
    );
  }
}
