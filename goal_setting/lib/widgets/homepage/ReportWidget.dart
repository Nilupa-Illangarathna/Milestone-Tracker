import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data_classes/sub classes/report_class.dart';
import '../../data_classes/sub classes/task_class.dart';

class ReportWidget extends StatelessWidget {
  final Report report;
  final Task task;

  const ReportWidget({Key? key, required this.report, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Format the date range start and end dates to display only the date part (yyyy-mm-dd)
    final formattedDateRangeStart = DateFormat('yyyy-MM-dd').format(report.dateRangeStart);
    final formattedDateRangeEnd = DateFormat('yyyy-MM-dd').format(report.dateRangeEnd);

    return Card(
      color: Color(0xFFC8E6C9),
      elevation: 0.0, // Remove the elevation
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), // Optional: Add rounded corners to the card
      child: Container(
        padding: const EdgeInsets.all(12.0), // Add padding for better spacing
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Task Report: ${task.name}',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo, // Adjust text color to match the theme
                  ),
                ),
              ],
            ),
            SizedBox(height: 8), // Add vertical spacing between the date range and statistics
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Start:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo, // Adjust text color to match the theme
                  ),
                ),
                Text(
                  formattedDateRangeStart, // Display formatted date range start
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'End:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo, // Adjust text color to match the theme
                  ),
                ),
                Text(
                  formattedDateRangeEnd, // Display formatted date range end
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Statistics: ${report.statistics}'),
              ],
            ),

          ],
        ),
      ),
    );
  }
}