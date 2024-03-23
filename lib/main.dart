import 'package:flutter/material.dart';
import 'package:goal_setting/splash_screen.dart';
import 'theme.dart';
import 'login_page.dart';
import 'signup_page.dart'; // Import the dummy signup page

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.themeData,
      home: SplashScreen(), // Set SplashScreen as the initial route
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
      },
    );
  }
}
