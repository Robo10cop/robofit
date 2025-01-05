import 'package:flutter/material.dart';

class BootyEinzelScreen extends StatelessWidget {
  const BootyEinzelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Einzelübungen'),
        backgroundColor: Colors.brown[400],
      ),
      body: Center(
        child: const Text(
          'Hier findest du deine Booty-Einzelübungen!',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
