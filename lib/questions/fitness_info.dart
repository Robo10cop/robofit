import 'package:flutter/material.dart';
import 'additional_info.dart';

class FitnessInfoPage extends StatefulWidget {
  final int age;
  final String gender;
  final int height;
  final int weight;

  const FitnessInfoPage({super.key, required this.age, required this.gender, required this.height, required this.weight});

  @override
  State<FitnessInfoPage> createState() => _FitnessInfoPageState();
}

class _FitnessInfoPageState extends State<FitnessInfoPage> {
  int? activityLevel; // Keine Vorauswahl
  int? lifestyleActivity; // Keine Vorauswahl
  final TextEditingController trainingFrequencyController = TextEditingController();

  void goToNextPage() {
    if (activityLevel == null || lifestyleActivity == null || int.tryParse(trainingFrequencyController.text) == null || int.parse(trainingFrequencyController.text) < 0 || int.parse(trainingFrequencyController.text) > 99) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bitte fülle alle Felder korrekt aus!')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdditionalInfoPage(
          age: widget.age,
          gender: widget.gender,
          height: widget.height,
          weight: widget.weight,
          activityLevel: activityLevel!,
          lifestyleActivity: lifestyleActivity!,
          trainingPerMonth: int.parse(trainingFrequencyController.text),
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
        title: const Text('Fitness-Level', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 32.0, left: 16.0, right: 16.0), // Mehr Abstand nach oben
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Wie aktiv ist deine berufliche Tätigkeit?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              '1 = nicht aktiv, 5 = sehr aktiv',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            buildSelectionRow(5, activityLevel, (value) {
              setState(() {
                activityLevel = value;
              });
            }),
            const SizedBox(height: 40), // Großer Abstand zur nächsten Frage
            const Text(
              'Wie aktiv ist dein Lebensstil?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              '1 = nicht aktiv, 5 = sehr aktiv',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            buildSelectionRow(5, lifestyleActivity, (value) {
              setState(() {
                lifestyleActivity = value;
              });
            }),
            const SizedBox(height: 40), // Großer Abstand zur nächsten Frage
            buildTextField('Wie oft trainierst du pro Monat?', trainingFrequencyController, TextInputType.number, ''),
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

  Widget buildSelectionRow(int maxValue, int? selectedValue, Function(int) onSelected) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        maxValue,
        (index) {
          int value = index + 1;
          bool isSelected = value == selectedValue;
          return GestureDetector(
            onTap: () => onSelected(value),
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF8C7A6B) : const Color(0xFFF5F1E8),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFF8C7A6B)),
              ),
              child: Center(
                child: Text(
                  value.toString(),
                  style: TextStyle(
                    fontSize: 18,
                    color: isSelected ? Colors.white : const Color(0xFF8C7A6B),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller, TextInputType inputType, String hintText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFF5F1E8),
          labelText: label,
          hintText: hintText,
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
