import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'infouser.dart'; // Import für die Seite zur Anpassung der Daten

class PersoenlicheEinstellungenScreen extends StatefulWidget {
  const PersoenlicheEinstellungenScreen({super.key});

  @override
  State<PersoenlicheEinstellungenScreen> createState() => _PersoenlicheEinstellungenScreenState();
}

class _PersoenlicheEinstellungenScreenState extends State<PersoenlicheEinstellungenScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isLoading = true;
  Map<String, dynamic>? userData;

  Future<void> _loadUserData() async {
    User? user = _auth.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Fehler: Kein Benutzer angemeldet!')),
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    try {
      DocumentSnapshot userDoc = await _firestore.collection('userSurveys').doc(user.uid).get();
      if (userDoc.exists) {
        setState(() {
          userData = userDoc.data() as Map<String, dynamic>;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Fehler beim Laden der Daten: $e')),
        );
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Persönliche Einstellungen',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.brown[400],
        elevation: 4,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : userData == null
              ? const Center(child: Text('Keine Daten gefunden.'))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Deine Angaben:',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      _buildInfoRow('Alter', '${userData?['age'] ?? ''} Jahre'),
                      _buildInfoRow('Geschlecht', userData?['gender'] ?? ''),
                      _buildInfoRow('Größe', '${userData?['height_cm'] ?? ''} cm'),
                      _buildInfoRow('Gewicht', '${userData?['weight_kg'] ?? ''} kg'),
                      _buildInfoRow('Berufliche Aktivität', '${userData?['activity_level'] ?? ''} / 5'),
                      _buildInfoRow('Lebensstil-Aktivität', '${userData?['lifestyle_activity'] ?? ''} / 5'),
                      _buildInfoRow('Training pro Monat', '${userData?['training_per_month'] ?? ''} Einheiten'),
                      _buildInfoRow('Raucher', (userData?['smokes'] ?? false) ? 'Ja' : 'Nein'),
                      _buildInfoRow('Wasserverbrauch', '${userData?['water_intake_liters'] ?? ''} Liter pro Tag'),
                      _buildInfoRow('Schlafdauer', '${userData?['sleep_hours'] ?? ''} Stunden pro Nacht'),
                      const SizedBox(height: 20),
                      const Text(
                        'Ziele:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 4.0,
                        children: (userData?['goals'] as List<dynamic>? ?? []).map((goal) {
                          return Chip(
                            label: Text(
                              goal,
                              style: const TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.brown[400],
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                      _buildInfoRow('Trainingsdauer', '${userData?['workout_duration_minutes'] ?? ''} Minuten'),
                      _buildInfoRow(
                          'Trainingshäufigkeit', '${userData?['training_days_per_week'] ?? ''} mal pro Woche'),
                      const SizedBox(height: 30),
                      Center(
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.brown[400],
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            onPressed: () {
                              // Navigation zur Anpassungsseite
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const InfoUserScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'Daten anpassen',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10), // Platz am unteren Rand
                    ],
                  ),
                ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
