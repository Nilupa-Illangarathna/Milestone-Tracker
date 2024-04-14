import 'dart:math';

import 'package:flutter/material.dart';
import 'package:goal_setting/data_classes/global_data_class.dart';
import 'package:goal_setting/data_instance_creation.dart';

import '../../../data_classes/sub classes/goal_class.dart';
import '../../../data_classes/sub classes/quote_class.dart';
import '../../../data_classes/sub classes/user_profile_data.dart';
import '../../../dummy_user_page.dart';
import '../../../utils/theme.dart';
import '../../../widgets/homepage/QuateWidget.dart';
import '../widgets/Goal Page.dart';


class UserHomePage extends StatefulWidget {
  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  late UserData userData;
  late List<Goal> goals7Days;
  late List<Goal> goals21Days;
  late List<Goal> customGoals;
  late Quote quote1;
  late Quote quote2;

  @override
  void initState() {
    super.initState();
    final globalData = generateRandomGlobalData();
    userData = globalData.userData;
    goals7Days = globalData.goals7Days;
    goals21Days = globalData.goals21Days;
    customGoals = globalData.customGoals;
    final random = Random();
    quote1 = globalData.quotes[random.nextInt(globalData.quotes.length)];
    quote2 = globalData.quotes[random.nextInt(globalData.quotes.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 18),
                        Text(
                          'Goal Setting',
                          style: TextStyle(
                            fontSize: 36.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A237E), // Adjusted color to a darker shade
                          ),
                        ),

                        SizedBox(height: 24),
                        // Text(
                        //   'User Details',
                        //   style: AppTheme.headerTextStyle,
                        // ),
                        // SizedBox(height: 16),
                        UserDataWidget(userData: userData),
                        SizedBox(height: 16),
                        QuoteWidget(quote: quote1),
                        SizedBox(height: 16),
                        _buildSection('Goals of 7 days', goals7Days),
                        SizedBox(height: 16),
                        _buildSection('Goals of 21 days', goals21Days),
                        SizedBox(height: 16),
                        _buildSection('Custom Goals', customGoals),
                        SizedBox(height: 16),
                        QuoteWidget(quote: quote2),
                        SizedBox(height: 0),



                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String label, List<Goal> goals) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label',
          style: AppTheme.headerTextStyle,
        ),
        SizedBox(height: 8),
        Container(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: goals.length,
            itemBuilder: (context, index) {
              final goal = goals[index];
              return Padding(
                padding: EdgeInsets.only(right: 16), // Add right padding to create the gap between items
                child: SizedBox(
                  width: null, // Allow the width to be determined by the child's content
                  child: GoalTile(goal: goal),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

}
