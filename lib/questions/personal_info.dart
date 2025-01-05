import 'package:flutter/material.dart';
import 'fitness_info.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key});

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  String selectedGender = 'weiblich'; // Standardwert auf weiblich

  void _goToNextPage() {
    int? age = int.tryParse(ageController.text);
    int? height = int.tryParse(heightController.text);
    int? weight = int.tryParse(weightController.text);

    if (age == null || age < 0 || age > 150 || height == null || height < 50 || height > 250 || weight == null || weight < 15 || weight > 300) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Bitte füllen Sie alle Felder korrekt aus!'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FitnessInfoPage(
          age: age,
          gender: selectedGender,
          height: height,
          weight: weight,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F3ED), // Beige Hintergrundfarbe
      appBar: AppBar(
        backgroundColor: const Color(0xFF8C7A6B),
        title: const Text('Persönliche Informationen', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bitte fülle deine Informationen aus:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            buildTextField('Alter', ageController, TextInputType.number, hint: "z. B. 25"),
            buildDropdown('Geschlecht', ['weiblich', 'männlich'], (value) {
              setState(() {
                selectedGender = value ?? 'weiblich';
              });
            }),
            buildTextField('Größe (in cm)', heightController, TextInputType.number, hint: "z. B. 170"),
            buildTextField('Gewicht (in kg)', weightController, TextInputType.number, hint: "z. B. 65"),
            const Spacer(),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8C7A6B), // Dunkler Beigeton
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: _goToNextPage,
                  child: const Text('Weiter', style: TextStyle(fontSize: 18)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller, TextInputType inputType, {String hint = ''}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFF5F1E8), // Hellbeiges Eingabefeld
          labelText: label,
          hintText: hint,
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

  Widget buildDropdown(String label, List<String> options, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF8C7A6B))),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F1E8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButtonFormField<String>(
              value: selectedGender,
              items: options.map((value) => DropdownMenuItem(value: value, child: Text(value))).toList(),
              onChanged: onChanged,
              decoration: const InputDecoration.collapsed(hintText: ''),
            ),
          ),
        ],
      ),
    );
  }
}
