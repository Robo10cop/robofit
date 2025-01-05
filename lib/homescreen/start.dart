import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StartScreen Screen'),
      ),
      body: const Center(
        child: Text('Willkommen auf der Analysis-Seite!'),
      ),
    );
  }
}