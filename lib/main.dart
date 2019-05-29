import 'package:flutter/material.dart';
import 'package:launchpad_university_v2/screens/login.dart';
import 'package:launchpad_university_v2/color.dart';
import 'package:launchpad_university_v2/screens/profile.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
  ThemeData buildTheme() {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      accentColor: myAccentColor,
      primaryColor: myPrimaryColor,
      buttonColor: myPrimaryColor,
      scaffoldBackgroundColor: myBackground,
      cardColor: myBackground,
    );
  }
  final ThemeData myTheme = buildTheme();

    return MaterialApp(
      title: 'Launchpad University',
      debugShowCheckedModeBanner: false,
      theme: myTheme,
      home: LoginPage(),
    );
  }
}
