import 'package:flutter/material.dart';
import 'package:photobooth_app/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Retro Photobooth',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        scaffoldBackgroundColor: const Color(0xFFF5EFE6),
        fontFamily: 'PressStart2P',
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold, color: Color(0xFF4A4A4A)),
          titleLarge: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic, color: Color(0xFF4A4A4A)),
          bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind', color: Color(0xFF4A4A4A)),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}