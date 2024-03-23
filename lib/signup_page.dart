import 'package:flutter/material.dart';
import 'data_structure.dart';
import 'theme.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // Data controller for the signup form
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController marriedController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Function to handle signup button press
  void handleSignup() {
    // Get data from text controllers
    String name = nameController.text;
    int age = int.tryParse(ageController.text) ?? 0;
    bool married = marriedController.text.toLowerCase() == 'true';
    String username = usernameController.text;
    String email = emailController.text;
    String password = passwordController.text;

    // Create UserData object
    UserData userData = UserData(
      name: name,
      age: age,
      married: married,
      username: username,
      email: email,
      password: password,
    );

    // Print UserData object
    userData.printData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
              style: TextStyle(color: AppTheme.themeData.primaryColor),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: ageController,
              decoration: InputDecoration(
                labelText: 'Age',
              ),
              keyboardType: TextInputType.number,
              style: TextStyle(color: AppTheme.themeData.primaryColor),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: marriedController,
              decoration: InputDecoration(
                labelText: 'Married (true/false)',
              ),
              style: TextStyle(color: AppTheme.themeData.primaryColor),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
              ),
              style: TextStyle(color: AppTheme.themeData.primaryColor),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: AppTheme.themeData.primaryColor),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
              style: TextStyle(color: AppTheme.themeData.primaryColor),
            ),
            SizedBox(height: 36.0),
            Center(
              child: ElevatedButton(
                onPressed: handleSignup,
                child: Text('Signup'),
                style: ElevatedButton.styleFrom(
                  primary: AppTheme.themeData.primaryColor,
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account?',
                  style: Theme.of(context).textTheme.button!.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to login page
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: AppTheme.themeData.primaryColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
