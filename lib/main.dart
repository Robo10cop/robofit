import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/intro_screen.dart'; // Import der neuen Intro-Screen-Datei

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RoboFit App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const IntroScreen(), // Starte mit der neuen Intro-Seite
    );
  }
}