import 'package:flutter/material.dart';

class FavoritenScreen extends StatelessWidget {
  const FavoritenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favoriten',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.brown[400],
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            _buildFavoriteItem('Lieblings-Workout', 'assets/icons/workout_favorite.png'),
            const SizedBox(height: 16),
            _buildFavoriteItem('Gespeicherte Rezepte', 'assets/icons/food_favorite.png'),
            const SizedBox(height: 16),
            _buildFavoriteItem('Motivationszitate', 'assets/icons/motivation.png'),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoriteItem(String title, String iconPath) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.brown[200],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset(
            iconPath,
            width: 40,
            height: 40,
          ),
          const SizedBox(width: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
