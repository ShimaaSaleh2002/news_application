import 'package:flutter/material.dart';
import 'package:news_app/ui/screens/home/home_screen.dart';
import 'package:news_app/ui/screens/my_theme_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MyThemeData.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName : (_)=> const HomeScreen(),
      },
    );
  }
}

