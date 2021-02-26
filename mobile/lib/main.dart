import 'package:flutter/material.dart';
// import 'dashboardScreen.dart';
import 'loginScreen.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dashboardScreen.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AutoAcceptor',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      // dashboard: DashboardScreen(),
    );
  }
}

// class LoggedInApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'AutoAcceptor',
//       debugShowCheckedModeBanner: false,
//       // home: LoginScreen(),
//       home: DashboardScreen(),
//     );
//   }
// }
