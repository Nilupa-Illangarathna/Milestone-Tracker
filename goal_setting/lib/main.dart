import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goal_setting/pages/app_drawer.dart';
import 'package:goal_setting/pages/authentication/login/login_page.dart';
import 'package:goal_setting/pages/authentication/signup/signup_page.dart';
import 'package:goal_setting/pages/homepage/home_page.dart';
import 'package:goal_setting/pages/homepage/pages/set_new_goals.dart';
import 'package:goal_setting/pages/homepage/pages/user_home_page.dart';
import 'data_classes/global_data_class.dart';
import 'dummy_user_page.dart';
import 'pages/splash/splash_screen.dart';
import 'package:provider/provider.dart';
import 'utils/theme.dart';

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
      // home: UserHomePage(), // Set SplashScreen as the initial route
      //    home: SetGoalPage(),
      // initialRoute:'/home',
      initialRoute:'/splash',
      routes: {
        '/splash': (context) => SplashScreen(),

        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/home': (context) => HomePage(),

        '/page1': (context) => Page2(),
        '/page2': (context) => Page2(),
        '/page3': (context) => Page3(),
        '/page4': (context) => Page4(),

        '/AppDrawerpage1': (context) => AppDrawerPage2(),
        '/AppDrawerpage2': (context) => AppDrawerPage2(),
        '/AppDrawerpage3': (context) => AppDrawerPage3(),
        '/AppDrawerpage4': (context) => AppDrawerPage4(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}


// class GlobalDataPage extends StatefulWidget {
//   @override
//   _GlobalDataPageState createState() => _GlobalDataPageState();
// }
//
// class _GlobalDataPageState extends State<GlobalDataPage> {
//   late GlobalData globalData;
//
//   @override
//   void initState() {
//     super.initState();
//     globalData = RandomDataGenerator.generateRandomGlobalData();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Global Data Page'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 '+------------------ Global Data -------------------+',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 16),
//               UserDataWidget(userData: globalData.userData),
//               SizedBox(height: 16),
//               Text(
//                 '|        - Goals of 7 days',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 8),
//               ...globalData.goals7Days.map((goal) => GoalWidget(goal: goal)),
//               SizedBox(height: 16),
//               Text(
//                 '|        - Goals of 21 days',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 8),
//               ...globalData.goals21Days.map((goal) => GoalWidget(goal: goal)),
//               SizedBox(height: 16),
//               Text(
//                 '|        - Custom Goals',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 8),
//               ...globalData.customGoals.map((goal) => GoalWidget(goal: goal)),
//               SizedBox(height: 16),
//               Text(
//                 '|        - Quotes',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 8),
//               ...globalData.quotes.map((quote) => QuoteWidget(quote: quote)),
//               Text(
//                 '+--------------------------------------------------+',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }