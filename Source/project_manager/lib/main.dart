import 'package:flutter/material.dart';
import 'package:load/load.dart';
import 'package:project_manager/Screens/Login/login_screen.dart';
import 'package:project_manager/constants.dart';

void main() => runApp(LoadingProvider(
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project Manager',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
    );
  }
}
