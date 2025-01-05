import 'package:flutter/material.dart';
import 'summary.dart';

class GoalsInfoPage extends StatefulWidget {
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

  const GoalsInfoPage({
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
  });

  @override
  State<GoalsInfoPage> createState() => _GoalsInfoPageState();
}

class _GoalsInfoPageState extends State<GoalsInfoPage> {
  final List<String> goals = [
    'Gewichtsverlust',
    'Muskelaufbau',
    'Booty-Workout',
    'Ausdauer steigern',
    'Schnellkraft verbessern',
    'Stress abbauen',
    'Allgemeine Fitness verbessern',
    'Kraft-Ausdauer optimieren',
  ];

  final List<String> selectedGoals = [];
  final TextEditingController workoutDurationController = TextEditingController();
  final TextEditingController trainingDaysPerWeekController = TextEditingController();

  void _toggleGoal(String goal) {
    setState(() {
      selectedGoals.contains(goal) ? selectedGoals.remove(goal) : selectedGoals.add(goal);
    });
  }

  void _goToNextPage() {
    if (int.tryParse(workoutDurationController.text) == null ||
        int.parse(workoutDurationController.text) < 5 ||
        int.parse(workoutDurationController.text) > 180 ||
        int.tryParse(trainingDaysPerWeekController.text) == null ||
        int.parse(trainingDaysPerWeekController.text) < 0 ||
        int.parse(trainingDaysPerWeekController.text) > 40) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bitte füllen Sie alle Felder korrekt aus!')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SummaryPage(
          age: widget.age,
          gender: widget.gender,
          height: widget.height,
          weight: widget.weight,
          activityLevel: widget.activityLevel,
          lifestyleActivity: widget.lifestyleActivity,
          trainingPerMonth: widget.trainingPerMonth,
          smokes: widget.smokes,
          waterIntake: widget.waterIntake,
          sleepHours: widget.sleepHours,
          selectedGoals: selectedGoals,
          workoutDuration: int.parse(workoutDurationController.text),
          trainingDaysPerWeek: int.parse(trainingDaysPerWeekController.text),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F3ED),
      appBar: AppBar(
        backgroundColor: const Color(0xFF8C7A6B),
        title: const Text('Ziele und Training', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 24.0, left: 16.0, right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Was sind deine Ziele?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: goals.map((goal) {
                return FilterChip(
                  label: Text(goal),
                  selected: selectedGoals.contains(goal),
                  onSelected: (_) => _toggleGoal(goal),
                  selectedColor: const Color(0xFF8C7A6B),
                  backgroundColor: const Color(0xFFF5F1E8),
                  labelStyle: TextStyle(
                    color: selectedGoals.contains(goal) ? Colors.white : const Color(0xFF8C7A6B),
                    fontWeight: FontWeight.bold,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 32),
            buildTextField('Gewünschte Dauer eines Workouts (in Minuten)', workoutDurationController, TextInputType.number),
            const SizedBox(height: 24),
            buildTextField('Wie oft möchtest du pro Woche trainieren?', trainingDaysPerWeekController, TextInputType.number),
            const Spacer(),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8C7A6B),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: _goToNextPage,
                  child: const Text('Weiter zur Zusammenfassung', style: TextStyle(fontSize: 18)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller, TextInputType inputType) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFF5F1E8),
          labelText: label,
          labelStyle: const TextStyle(color: Color(0xFF8C7A6B)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF8C7A6B), width: 1.5),
          ),
        ),
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
