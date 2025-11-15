import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/add_mood_page.dart';
import 'pages/quotes_page.dart';

void main() {
  runApp(MoodMateApp());
}

class MoodMateApp extends StatelessWidget {
  const MoodMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MoodMate',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: 'RobotoCustom',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/add': (context) => AddMoodPage(),
        '/quotes': (context) => QuotesPage(),
      },
    );
  }
}
