import 'package:flutter/material.dart';
import 'booty_workout_video_screen.dart';

const List<String> durations = ["15'", "23'", "31'", "39'", "47'", "55'", "63'"];

class Booty2Screen extends StatelessWidget {
  const Booty2Screen({super.key, required String duration});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booty-Workout Spezial'),
        backgroundColor: Colors.brown[400],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 2.5,
          ),
          itemCount: durations.length,
          itemBuilder: (context, index) {
            final duration = durations[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BootyWorkoutVideoScreen(duration: duration),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.brown.shade300,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    duration,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
