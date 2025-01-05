import 'package:flutter/material.dart';
import 'package:robofitapp/homescreen/workout/booty.dart'; // Booty-Workout Spezial screen
import 'package:robofitapp/homescreen/workout/endurance.dart'; // Ausdauer screen
import 'package:robofitapp/homescreen/workout/boxing.dart'; // Boxen screen
import 'package:robofitapp/homescreen/workout/strength.dart'; // Krafttraining screen
import 'package:robofitapp/homescreen/workout/hiit.dart'; // HIIT screen
import 'package:robofitapp/homescreen/workout/speed.dart'; // Schnellkraft screen

class WorkoutScreen extends StatelessWidget {
  WorkoutScreen({super.key});

  final List<Map<String, String>> workouts = [
    {'title': 'Ausdauer', 'image': 'assets/images/endurance.png'},
    {'title': 'Booty-Workout', 'image': 'assets/images/booty.png'},
    {'title': 'Boxen', 'image': 'assets/images/boxing.png'},
    {'title': 'Krafttraining', 'image': 'assets/images/strength.png'},
    {'title': 'HIIT', 'image': 'assets/images/hiit.png'},
    {'title': 'Schnellkraft', 'image': 'assets/images/speed.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Workouts',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        backgroundColor: Colors.brown[400],
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.0,
          ),
          itemCount: workouts.length,
          itemBuilder: (context, index) {
            final workout = workouts[index];
            return _buildWorkoutCard(context, workout['title']!, workout['image']!);
          },
        ),
      ),
    );
  }

  Widget _buildWorkoutCard(BuildContext context, String title, String imagePath) {
    return GestureDetector(
      onTap: () {
        // Navigate to specific screens based on workout title
        if (title == 'Ausdauer') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AusdauerScreen(),
            ),
          );
        } else if (title == 'Booty-Workout') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BootyScreen(duration: '',),
            ),
          );
        } else if (title == 'Boxen') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const BoxenScreen(),
            ),
          );
        } else if (title == 'Krafttraining') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const StrengthScreen(),
            ),
          );
        } else if (title == 'HIIT') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HIITScreen(),
            ),
          );
        } else if (title == 'Schnellkraft') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SpeedScreen(),
            ),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.brown.shade200,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(20),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Image.asset(
                imagePath,
                width: 40,
                height: 40,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
