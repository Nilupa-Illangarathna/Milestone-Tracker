import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goal_setting/splash_screen.dart';
import 'package:provider/provider.dart';
import 'theme.dart';
import 'login_page.dart';
import 'signup_page.dart'; // Import the dummy signup page

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // System UI Configuration
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
      ),
    );
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky,
    );

    return MaterialApp(
      theme: AppTheme.themeData,
      home: SplashScreen(), // Set SplashScreen as the initial route
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
