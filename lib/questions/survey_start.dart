import 'package:flutter/material.dart';
import 'personal_info.dart';

class SurveyStart extends StatelessWidget {
  const SurveyStart({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Bild im oberen Bereich (1/2 des Bildschirms)
          Container(
            width: double.infinity,
            height: size.height * 0.5, // Hälfte des Bildschirms
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/survey_start.png'),
                fit: BoxFit.cover, // Bild bleibt im Verhältnis und füllt den Raum
              ),
            ),
          ),
          // Unterer Bereich (1/2 des Bildschirms)
          Container(
            margin: EdgeInsets.only(top: size.height * 0.45), // Mehr Platz für das Bild
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: const Color(0xFFF4ECE2), // Helles Braun/Grau für den Hintergrund
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20), // Abstand oben
                // Begrüßungstext
                const Text(
                  'Lass mich mehr über dich erfahren!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Pacifico', // Lässige Schriftart
                    color: Colors.black87,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Spacer(), // Abstand zwischen Text und Button
                // Button "Los geht's"
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8D6E63), // Braun/Grau-Ton passend zum Bild
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PersonalInfoPage()),
                    );
                  },
                  child: const Text(
                    'Los geht\'s!',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 40), // Abstand unten
              ],
            ),
          ),
        ],
      ),
    );
  }
}
