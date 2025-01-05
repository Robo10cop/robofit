import 'package:flutter/material.dart';

class TrainingScreen extends StatelessWidget {
  const TrainingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Training Session')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Start your training!'),
            ElevatedButton(
              onPressed: () {
                // Start video playback
              },
              child: const Text('Play Video'),
            ),
          ],
        ),
      ),
    );
  }
}
