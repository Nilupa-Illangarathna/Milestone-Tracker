// Import necessary packages
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../../data_state/dataState.dart';
import '../../../data_classes/sub classes/achievement_class.dart';
import '../../../data_classes/sub classes/goal_class.dart';
import '../../../data_classes/sub classes/progress_class.dart';
import '../../../data_classes/sub classes/report_class.dart';
import '../../../data_classes/sub classes/task_class.dart';

// Define the SetGoalPage StatefulWidget
class SetGoalPage extends StatefulWidget {
  @override
  _SetGoalPageState createState() => _SetGoalPageState();
}

// Define the _SetGoalPageState State class
class _SetGoalPageState extends State<SetGoalPage> {
  // Define variables to store goal-related data
  String name = '';
  DateTime? startDate;
  DateTime? targetDate;
  String description = '';
  String imageURL = '';
  String goalID = Uuid().v4(); // Generate a UUID for the goal ID
  int remainingDays = 0;

  // Define a list to store tasks
  List<Task> tasks = [];

  // Define a GlobalKey for the form
  final _formKey = GlobalKey<FormState>();

  // Define a GlobalKey for the task form
  final _taskFormKey = GlobalKey<FormState>();

  // Controller for the task name input field
  final _taskNamesController = TextEditingController();

  // Controller for the task days input field
  final _taskDaysController = TextEditingController();

  // Controller for the task descriptiuon input field
  final _taskDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold body
      body: Stack(
        children: [
          Container(
            height:MediaQuery.of(context).size.height,
            width:MediaQuery.of(context).size.width,
            padding:EdgeInsets.only(right:100, top:20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Opacity(
                  opacity: 0.6, // Set the opacity value as desired
                  child: Image.asset(
                    'assets/images/set_goals_background2.png', // Replace 'your_image.png' with your image asset path
                    fit: BoxFit.fill, // Adjust the fit as needed
                  ),
                ),
              ],
            ),
          ),
          Container(
            height:MediaQuery.of(context).size.height,
            width:MediaQuery.of(context).size.width,
            padding:EdgeInsets.only(left:100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Opacity(
                  opacity: 0.6, // Set the opacity value as desired
                  child: Image.asset(
                    'assets/images/set_goals_background.png', // Replace 'your_image.png' with your image asset path
                    fit: BoxFit.fill, // Adjust the fit as needed
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: SingleChildScrollView(
              // padding: EdgeInsets.symmetric(vertical: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Add Goals',
                      style: TextStyle(
                        fontSize: 36.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A237E),
                      ),
                    ),
                  ),
                  SizedBox(height: 32), // Spacer
                  // Goal form
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Goal input fields
                          _buildInputField(
                            labelText: 'Name',
                            onChanged: (value) => name = value,
                          ),
                          SizedBox(height: 10.0), // Spacer
                          _buildInputField(
                            labelText: 'Start Date',
                            readOnly: true,
                            onTap: () => _selectDate(context, true),
                            suffixIcon: Icons.calendar_today,
                            value: startDate != null ? DateFormat('MMM dd, yyyy').format(startDate!) : null,
                          ),
                          SizedBox(height: 10.0), // Spacer
                          _buildInputField(
                            labelText: 'Target Date',
                            readOnly: true,
                            onTap: () => _selectDate(context, false),
                            suffixIcon: Icons.calendar_today,
                            value: targetDate != null ? DateFormat('MMM dd, yyyy').format(targetDate!) : null,
                          ),
                          SizedBox(height: 10.0), // Spacer
                          _buildInputField(
                            labelText: 'Description',
                            maxLines: null,
                            onChanged: (value) => description = value,
                          ),
                          SizedBox(height: 10.0), // Spacer
                          _buildInputField(
                            labelText: 'Image URL',
                            onChanged: (value) async {
                              imageURL = value;
                              // Verify image URL existence
                              if (value.isNotEmpty) {
                                bool exists = await _verifyImageURL(value);
                                if (!exists) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Image URL does not exist')),
                                  );
                                }
                              }
                            },
                          ),
                          SizedBox(height: 32.0), // Spacer
                          // Add Tasks Button




                          // Remaining Time
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                'Remaining Time: $remainingDays days',
                                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0), // Spacer
                          // Task List View
                          if (tasks.isNotEmpty) _buildTaskList(),



                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0), // Spacer
                  Center(
                    child: SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate() && _validateDateInterval()) {
                            // Show task input form
                            _showTaskInputForm();
                          }
                        },
                        child: Text('Add Tasks'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build task list
  SizedBox _buildTaskList() {
    return SizedBox(
      height: 180.0, // Set the height of the horizontal list view
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // Set the scroll direction to horizontal
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          Task task = tasks[index];
          return Container(
            width: MediaQuery.of(context).size.width * 2/3 - 32.0, // Calculate the width of the container
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical:8), // Set the horizontal margin

            child: ElevatedContainer( // Wrap the Container with ElevatedContainer
              borderRadius: BorderRadius.circular(16.0), // Add border radius
              elevation: 1, // Add elevation
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(task.name),
                  subtitle: Text(
                        'Start Date: ${DateFormat('MMM dd, yyyy').format(task.startDate)}\n'
                        'End Date: ${DateFormat('MMM dd, yyyy').format(task.targetDate)}\n'
                        'Description: ${task.achievements[0].description}',


                  ),
                ),
              ),
            ),
          );
        },
      ),
    )
    ;
  }

  // Build input field widget
  Widget _buildInputField({
    required String labelText,
    String? value,
    bool readOnly = false,
    Function(String)? onChanged,
    Function()? onTap,
    IconData? suffixIcon,
    int? maxLines,
  }) {
    return Container(

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey[200],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: labelText,
                  border: InputBorder.none,
                  suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
                ),
                readOnly: readOnly,
                initialValue: value,
                onChanged: onChanged,
                onTap: onTap as void Function()?,
                maxLines: maxLines,
              ),
            ),
            if (value != null && value.isNotEmpty) // Display selected date if not null
              Text(
                value,
                style: TextStyle(color: Colors.grey[700]),
              ),
          ],
        ),
      ),
    );
  }

  // Select date function
  void _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        if (isStartDate) {
          startDate = pickedDate;
        } else {
          targetDate = pickedDate;
          remainingDays = targetDate!.difference(startDate!).inDays;
        }
      });
    }
  }

// Show task input form
  void _showTaskInputForm() {
    showDialog(
      context: context,
      builder: (context) => Container(
        child: AlertDialog(
          title: Text('Add New Task'),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _taskFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _taskNamesController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Enter task name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        _taskNamesController.text='';
                      }
                    },
                  ),
                  SizedBox(height:16),
                  TextFormField(
                    controller: _taskDaysController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Enter number of days'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid number of days';
                      }
                      int days = int.tryParse(value) ?? 0;
                      if (days <= 0 || days > remainingDays) {
                        return 'Invalid number of days';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height:16),
                  TextFormField(
                    controller: _taskDescriptionController,
                    decoration: InputDecoration(labelText: 'Achievement description'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        _taskDescriptionController.text='';
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                String taskID = Uuid().v4(); // Generate a UUID for the goal ID
                if (_taskFormKey.currentState!.validate()) {
                  int days = int.parse(_taskDaysController.text);
                  DateTime taskEndDate = startDate!.add(Duration(days: days));
                  setState(() {
                    tasks.add(Task(
                      goalID: goalID,
                      taskID: taskID, // Generate a new UUID for the task ID
                      name: _taskNamesController.text == ""? 'Task ${tasks.length + 1}' : _taskNamesController.text,
                      startDate: startDate!,
                      targetDate: taskEndDate,
                      completed: false,
                      achievements: _taskDescriptionController.text == ""? []:
                      [
                        Achievement(
                            goalID: goalID,
                            taskId: taskID,
                            name: '',
                            description: _taskDescriptionController.text,
                            dateEarned: taskEndDate
                        )
                      ], // Empty achievements list
                      report: Report(
                        goalID: goalID,
                        taskId: taskID,
                        dateRangeStart: DateTime.now(),
                        dateRangeEnd:  DateTime.now(),
                        statistics: {},
                      ), // Empty report
                      progress: Progress(
                          goalID: goalID,
                          taskId: taskID,
                          date: DateTime.now(),
                          value: 0
                      ), // Empty progress
                    ));
                    remainingDays -= days;
                  });
                  Navigator.of(context).pop();
                  if(remainingDays==0){
                    // Create the Goal object
                    Goal goal = Goal(
                      id: goalID,
                      name: name,
                      startDate: startDate!,
                      targetDate: targetDate!,
                      ImageURL: imageURL,
                      description: description,
                      tasks: tasks,
                    );

                    setState(() {
                      // Print the Goal object's data
                      global_user_data_OBJ.addGoalAndAppendArray(newGoal:goal); //TODO
                    });
                    goal.printData();
                  }
                }
              },
              child: Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }


  // Verify image URL existence
  Future<bool> _verifyImageURL(String url) async {
    // Implementation to verify image URL existence
    return true; // Placeholder return value
  }

  // Validate date interval
  bool _validateDateInterval() {
    if (startDate == null || targetDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select both start date and target date')),
      );
      return false;
    }

    if (targetDate!.isBefore(startDate!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Target date should be after start date')),
      );
      return false;
    }

    return true;
  }
}







class ElevatedContainer extends StatelessWidget {
  final Widget child;
  final double elevation;
  final Color? color;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  ElevatedContainer({
    required this.child,
    this.elevation = 1,
    this.color,
    this.borderRadius,
    this.margin,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: color ?? Theme.of(context).canvasColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: elevation,
            blurRadius: elevation,
            offset: Offset(0, elevation), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: child,
      ),
    );
  }
}