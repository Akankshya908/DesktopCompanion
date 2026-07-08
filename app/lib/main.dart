import 'package:flutter/material.dart';
import 'screens/home/home_screen.dart';

void main() {
  runApp(const DesktopCompanionApp());
}

class DesktopCompanionApp extends StatelessWidget {
  const DesktopCompanionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Desktop Companion',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}