import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/userhome.dart'; // Angepasster Pfad zur UserHomeScreen

class SummaryPage extends StatefulWidget {
  final int age;
  final String gender;
  final int height;
  final int weight;
  final int activityLevel;
  final int lifestyleActivity;
  final int trainingPerMonth;
  final bool smokes;
  final double waterIntake;
  final double sleepHours;
  final List<String> selectedGoals;
  final int workoutDuration;
  final int trainingDaysPerWeek;

  const SummaryPage({
    super.key,
    required this.age,
    required this.gender,
    required this.height,
    required this.weight,
    required this.activityLevel,
    required this.lifestyleActivity,
    required this.trainingPerMonth,
    required this.smokes,
    required this.waterIntake,
    required this.sleepHours,
    required this.selectedGoals,
    required this.workoutDuration,
    required this.trainingDaysPerWeek,
  });

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  bool _isLoading = false;

  Future<void> saveData() async {
    setState(() {
      _isLoading = true;
    });

    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final User? user = FirebaseAuth.instance.currentUser;

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
      await firestore.collection('userSurveys').doc(user.uid).set({
        'age': widget.age,
        'gender': widget.gender,
        'height_cm': widget.height,
        'weight_kg': widget.weight,
        'activity_level': widget.activityLevel,
        'lifestyle_activity': widget.lifestyleActivity,
        'training_per_month': widget.trainingPerMonth,
        'smokes': widget.smokes,
        'water_intake_liters': widget.waterIntake,
        'sleep_hours': widget.sleepHours,
        'goals': widget.selectedGoals,
        'workout_duration_minutes': widget.workoutDuration,
        'training_days_per_week': widget.trainingDaysPerWeek,
        'surveyCompleted': true, // Markiere den Fragebogen als abgeschlossen
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Daten erfolgreich gespeichert!')),
      );

      // Navigation zur `UserHomeScreen` nach erfolgreichem Speichern
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const UserHomeScreen()),
        (route) => false,
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Fehler beim Speichern: $e')),
      );
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
      backgroundColor: const Color(0xFFF7F3ED),
      appBar: AppBar(
        backgroundColor: const Color(0xFF8C7A6B),
        title: const Text('Zusammenfassung', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Deine Angaben:',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            buildSummaryTile('Alter', '${widget.age} Jahre'),
            buildSummaryTile('Geschlecht', widget.gender),
            buildSummaryTile('Größe', '${widget.height} cm'),
            buildSummaryTile('Gewicht', '${widget.weight} kg'),
            buildSummaryTile('Berufliche Aktivität', '${widget.activityLevel} / 5'),
            buildSummaryTile('Lebensstil-Aktivität', '${widget.lifestyleActivity} / 5'),
            buildSummaryTile('Training pro Monat', '${widget.trainingPerMonth} Einheiten'),
            buildSummaryTile('Raucher', widget.smokes ? 'Ja' : 'Nein'),
            buildSummaryTile('Wasserverbrauch', '${widget.waterIntake} Liter pro Tag'),
            buildSummaryTile('Schlafdauer', '${widget.sleepHours} Stunden pro Nacht'),
            const SizedBox(height: 20),
            const Text(
              'Ziele:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: widget.selectedGoals.map((goal) {
                return Chip(
                  label: Text(
                    goal,
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: const Color(0xFF8C7A6B),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            buildSummaryTile('Trainingsdauer', '${widget.workoutDuration} Minuten'),
            buildSummaryTile('Trainingshäufigkeit', '${widget.trainingDaysPerWeek} mal pro Woche'),
            const Spacer(),
            Center(
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8C7A6B),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: saveData,
                        child: const Text(
                          'Daten speichern',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSummaryTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF8C7A6B)),
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
