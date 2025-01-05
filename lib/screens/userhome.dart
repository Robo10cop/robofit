import 'package:flutter/material.dart';
// Importiere deine Zielseiten
import 'package:robofitapp/homescreen/workout.dart';
import 'package:robofitapp/homescreen/start.dart';
import 'package:robofitapp/homescreen/kalender.dart';
import 'package:robofitapp/homescreen/food.dart';
import 'package:robofitapp/homescreen/benutzer.dart';
import 'package:robofitapp/homescreen/analysis.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Benutzer-Startseite'),
        backgroundColor: Colors.brown[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          children: [
            _buildMenuItem(
              context,
              "Workout",
              "assets/images/workout.png",
              Colors.brown.shade100,
              WorkoutScreen(), // ohne const
            ),
            _buildMenuItem(
              context,
              "Kalender",
              "assets/images/kalender.png",
              Colors.brown.shade200,
              KalenderScreen(), // ohne const
            ),
            _buildMenuItem(
              context,
              "Analysis",
              "assets/images/analysis.png",
              Colors.grey.shade200,
              AnalysisScreen(), // ohne const
            ),
            _buildMenuItem(
              context,
              "Food",
              "assets/images/food.png",
              Colors.brown.shade100,
              FoodScreen(), // ohne const
            ),
            _buildMenuItem(
              context,
              "Start",
              "assets/images/start.png",
              Colors.grey.shade300,
              StartScreen(), // ohne const
            ),
            _buildMenuItem(
              context,
              "Benutzer",
              "assets/images/user.png",
              Colors.brown.shade200,
              BenutzerScreen(), // ohne const
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
      BuildContext context, String title, String imagePath, Color color, Widget targetScreen) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => targetScreen),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((0.1 * 255).toInt()), // Alpha-Wert für 10% Deckkraft
              blurRadius: 6.0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 80,
              height: 80,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
