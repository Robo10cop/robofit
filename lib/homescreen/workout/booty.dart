import 'package:flutter/material.dart';
import 'booty2.dart';
import 'bootyeinzel.dart';

class BootyScreen extends StatelessWidget {
  const BootyScreen({super.key, required String duration});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booty-Workout Auswahl'),
        backgroundColor: Colors.brown[400],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Booty2Screen(duration: '',)),
                );
              },
              child: const Text('Booty-Workout Spezial'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BootyEinzelScreen()),
                );
              },
              child: const Text('Einzelübungen'),
            ),
          ],
        ),
      ),
    );
  }
}
