import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'name.dart';  // Import für die Seite zur Namensänderung
import 'email.dart'; // Import für die Seite zur E-Mail-Änderung
import 'passwort.dart'; // Import für die Seite zur Passwort-Änderung

class BenutzerdatenAendernScreen extends StatelessWidget {
  BenutzerdatenAendernScreen({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser; // Der eingeloggte Benutzer

    return Scaffold(
      appBar: AppBar(
        title: const Text('Benutzerdaten ändern'),
        backgroundColor: Colors.orange[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            // Benutzerinformationen anzeigen
            _buildUserInfoCard(user),

            const SizedBox(height: 40),
            // Button zur Namensänderung
            _buildActionButton(
              context,
              "Benutzernamen ändern",
              Icons.person,
              Colors.orange.shade600,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NameAendernScreen()),
                );
              },
            ),
            const SizedBox(height: 16),
            // Button zur E-Mail-Änderung
            _buildActionButton(
              context,
              "E-Mail-Adresse ändern",
              Icons.email,
              Colors.orange.shade700,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EmailAendernScreen()),
                );
              },
            ),
            const SizedBox(height: 16),
            // Button zur Passwortänderung
            _buildActionButton(
              context,
              "Passwort ändern",
              Icons.lock,
              Colors.orange.shade900,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PasswortAendernScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Benutzerinfo-Karte
  Widget _buildUserInfoCard(User? user) {
    String displayName = user?.displayName ?? "Kein Benutzername";
    String email = user?.email ?? "Keine E-Mail verfügbar";

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.shade100,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.orange.shade700,
                child: const Icon(Icons.person, color: Colors.white, size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      email,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Buttons zur Navigation
  Widget _buildActionButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      icon: Icon(icon, color: Colors.white),
      label: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
