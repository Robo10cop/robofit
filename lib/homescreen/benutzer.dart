import 'package:flutter/material.dart';

// Importiere Zielseiten
import 'benutzerdaten_aendern.dart';
import 'persoenliche_einstellungen.dart';
import 'favoriten.dart';

class BenutzerScreen extends StatelessWidget {
  const BenutzerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Benutzer Einstellungen',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18), // Smaller title
        ),
        backgroundColor: Colors.brown[400],
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0), // Reduced overall padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSimpleButton(
              context,
              'Benutzerdaten ändern',
              Colors.brown.shade300,
              BenutzerdatenAendernScreen(),
            ),
            const SizedBox(height: 8), // Smaller spacing between buttons
            _buildSimpleButton(
              context,
              'Persönliche Einstellungen',
              Colors.brown.shade400,
              const PersoenlicheEinstellungenScreen(),
            ),
            const SizedBox(height: 8),
            _buildSimpleButton(
              context,
              'Favoriten',
              Colors.brown.shade200,
              const FavoritenScreen(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSimpleButton(
      BuildContext context, String title, Color color, Widget targetScreen) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => targetScreen),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16), // Button padding
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8.0), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(20), // Soft shadow
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center( // Center the text in the button
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16, // Slightly smaller text
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
