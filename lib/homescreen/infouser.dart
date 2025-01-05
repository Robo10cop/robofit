import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InfoUserScreen extends StatefulWidget {
  const InfoUserScreen({super.key});

  @override
  State<InfoUserScreen> createState() => _InfoUserScreenState();
}

class _InfoUserScreenState extends State<InfoUserScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _waterIntakeController = TextEditingController();
  final TextEditingController _sleepHoursController = TextEditingController();
  bool _smokes = false; // Default auf Nein

  bool _isLoading = false;

  Future<void> _saveUserData() async {
    User? user = _auth.currentUser;
    if (user == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Fehler: Kein Benutzer angemeldet!')),
        );
      }
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Zeitstempel für den Verlauf
      final DateTime now = DateTime.now();
      final String formattedDate =
          "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

      // Neue Daten
      final newData = {
        'weight_kg': double.tryParse(_weightController.text) ?? 0.0,
        'smokes': _smokes,
        'water_intake_liters': double.tryParse(_waterIntakeController.text) ?? 0.0,
        'sleep_hours': double.tryParse(_sleepHoursController.text) ?? 0.0,
        'date': formattedDate,
      };

      // Speichern in `userSurveys/{userId}/history` für Verlauf
      await _firestore
          .collection('userSurveys')
          .doc(user.uid)
          .collection('history')
          .doc(formattedDate) // Datum als Dokumentname
          .set(newData);

      // Optional: Die neuesten Daten als aktuelle Werte setzen
      await _firestore.collection('userSurveys').doc(user.uid).update({
        'weight_kg': newData['weight_kg'],
        'smokes': newData['smokes'],
        'water_intake_liters': newData['water_intake_liters'],
        'sleep_hours': newData['sleep_hours'],
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Daten erfolgreich gespeichert!')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Fehler beim Speichern: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daten anpassen'),
        backgroundColor: Colors.brown[400],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Bitte passe deine Angaben an:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildTextField('Gewicht (kg)', _weightController, 'z. B. 70.0'),
            const SizedBox(height: 20),
            const Text(
              'Rauchstatus:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildSmokingOptions(),
            const SizedBox(height: 20),
            _buildTextField('Wasserverbrauch (Liter pro Tag)', _waterIntakeController, 'z. B. 2.5'),
            const SizedBox(height: 20),
            _buildTextField('Schlafdauer (Stunden pro Nacht)', _sleepHoursController, 'z. B. 7.5'),
            const SizedBox(height: 30),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: _saveUserData,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.brown[400],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Speichern',
                      style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  Widget _buildSmokingOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _smokes = true;
              });
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _smokes ? Colors.brown[400] : Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: _smokes ? Colors.brown : Colors.grey,
                  width: 2,
                ),
              ),
              child: const Center(
                child: Text(
                  'Ja',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _smokes = false;
              });
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: !_smokes ? Colors.brown[400] : Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: !_smokes ? Colors.brown : Colors.grey,
                  width: 2,
                ),
              ),
              child: const Center(
                child: Text(
                  'Nein',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
