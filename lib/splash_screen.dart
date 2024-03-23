import 'package:flutter/material.dart';
import 'dart:async';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _controller.repeat(reverse: true);
    Timer(
      Duration(seconds: 4), // Adjust the duration of the splash screen as needed
          () => Navigator.pushReplacementNamed(context, '/login'),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get screen width
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Lottie animation
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              width: screenWidth * 0.9, // Adjust width as needed
              child: Lottie.asset(
                'assets/lottie/animations/splash.json',
                animate: true,
                repeat: true,
                // You can remove width and height properties to let the animation fit the container
                // width: 100.0,
                // height: 100.0,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'GOAL SETTER',
              style: TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            SizedBox(height: 60.0),
          ],
        ),
      ),
    );
  }
}
