import 'package:flutter/material.dart';
import 'goals_info.dart';

class AdditionalInfoPage extends StatefulWidget {
  final int age;
  final String gender;
  final int height;
  final int weight;
  final int activityLevel;
  final int lifestyleActivity;
  final int trainingPerMonth;

  const AdditionalInfoPage({
    super.key,
    required this.age,
    required this.gender,
    required this.height,
    required this.weight,
    required this.activityLevel,
    required this.lifestyleActivity,
    required this.trainingPerMonth,
  });

  @override
  State<AdditionalInfoPage> createState() => _AdditionalInfoPageState();
}

class _AdditionalInfoPageState extends State<AdditionalInfoPage> {
  bool? smokes; // Keine Vorauswahl bei "Rauchst du?"
  final TextEditingController waterController = TextEditingController();
  final TextEditingController sleepController = TextEditingController();

  void goToNextPage() {
    if (smokes == null || double.tryParse(waterController.text) == null || double.tryParse(sleepController.text) == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bitte fülle alle Felder korrekt aus!')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GoalsInfoPage(
          age: widget.age,
          gender: widget.gender,
          height: widget.height,
          weight: widget.weight,
          activityLevel: widget.activityLevel,
          lifestyleActivity: widget.lifestyleActivity,
          trainingPerMonth: widget.trainingPerMonth,
          smokes: smokes!,
          waterIntake: double.parse(waterController.text),
          sleepHours: double.parse(sleepController.text),
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
        title: const Text('Zusätzliche Informationen', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 24.0, left: 16.0, right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Rauchst du?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildToggleButton('Ja', true, smokes),
                buildToggleButton('Nein', false, smokes),
              ],
            ),
            const SizedBox(height: 32), // Abstand zur nächsten Frage
            buildTextField('Wie viel Liter Wasser trinkst du täglich?', waterController, TextInputType.number),
            const SizedBox(height: 24),
            buildTextField('Wie viele Stunden schläfst du im Durchschnitt?', sleepController, TextInputType.number),
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
                  onPressed: goToNextPage,
                  child: const Text('Weiter', style: TextStyle(fontSize: 18)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildToggleButton(String label, bool value, bool? groupValue) {
    bool isSelected = value == groupValue;
    return GestureDetector(
      onTap: () {
        setState(() {
          smokes = value;
        });
      },
      child: Container(
        width: 100,
        height: 50,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF8C7A6B) : const Color(0xFFF5F1E8),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFF8C7A6B)),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: isSelected ? Colors.white : const Color(0xFF8C7A6B),
              fontWeight: FontWeight.bold,
            ),
          ),
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
