import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SurveyForm extends StatelessWidget {
  final String title;

  const SurveyForm({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.orange.shade900,
        centerTitle: true,
      ),
      body: const SurveyFormBody(),
    );
  }
}

class SurveyFormBody extends StatefulWidget {
  const SurveyFormBody({super.key});

  @override
  SurveyFormBodyState createState() => SurveyFormBodyState();
}

class SurveyFormBodyState extends State<SurveyFormBody> {
  final TextEditingController ageController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController occupationController = TextEditingController();
  final TextEditingController lifestyleController = TextEditingController();
  final TextEditingController smokeController = TextEditingController();
  final TextEditingController healthIssuesController = TextEditingController();
  final TextEditingController trainingController = TextEditingController();
  final TextEditingController sportController = TextEditingController();
  final TextEditingController waterController = TextEditingController();
  final TextEditingController sleepController = TextEditingController();
  final TextEditingController goalsController = TextEditingController();
  final TextEditingController trainingPreferenceController = TextEditingController();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool _isLoading = false;

  Future<void> saveSurveyData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await firestore.collection('userSurveys').add({
        'age': int.tryParse(ageController.text) ?? 0,
        'gender': genderController.text,
        'height_cm': double.tryParse(heightController.text) ?? 0.0,
        'weight_kg': double.tryParse(weightController.text) ?? 0.0,
        'occupation': occupationController.text,
        'lifestyle': lifestyleController.text,
        'smoke': smokeController.text.toLowerCase() == 'yes',
        'health_issues': healthIssuesController.text,
        'training_per_week': int.tryParse(trainingController.text) ?? 0,
        'preferred_sport': sportController.text,
        'water_intake_liters': double.tryParse(waterController.text) ?? 0.0,
        'sleep_hours': double.tryParse(sleepController.text) ?? 0.0,
        'goals': goalsController.text,
        'training_preference': trainingPreferenceController.text,
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Daten erfolgreich gespeichert!')),
        );
        Navigator.pop(context); // Leitet den Benutzer zurück zur vorherigen Seite
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bitte fülle die folgenden Felder aus:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            buildModernTextField('Alter', ageController, TextInputType.number),
            buildModernTextField('Geschlecht', genderController, TextInputType.text),
            buildModernTextField('Größe (in cm)', heightController, TextInputType.number),
            buildModernTextField('Gewicht (in kg)', weightController, TextInputType.number),
            buildModernTextField('Beruf', occupationController, TextInputType.text),
            buildModernTextField('Lebensstil (z.B. Aktiv, Sitzend)', lifestyleController, TextInputType.text),
            buildModernTextField('Rauchst du? (Ja/Nein)', smokeController, TextInputType.text),
            buildModernTextField('Hast du gesundheitliche Probleme?', healthIssuesController, TextInputType.text),
            buildModernTextField('Wie oft trainierst du pro Woche?', trainingController, TextInputType.number),
            buildModernTextField('Bevorzugte Sportart/Aktivität', sportController, TextInputType.text),
            buildModernTextField('Wie viel Wasser trinkst du täglich (in Litern)?', waterController, TextInputType.number),
            buildModernTextField('Wie viele Stunden schläfst du durchschnittlich?', sleepController, TextInputType.number),
            buildModernTextField('Ziele (z.B. Gewichtsverlust, Muskelaufbau)', goalsController, TextInputType.text),
            buildModernTextField('Wie möchtest du trainieren?', trainingPreferenceController, TextInputType.text),
            const SizedBox(height: 20),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange[900],
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: saveSurveyData,
                      child: const Text(
                        'Absenden',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  // Moderneres Eingabefeld mit abgerundeten Ecken und Schatten
  Widget buildModernTextField(String label, TextEditingController controller, TextInputType inputType) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          controller: controller,
          keyboardType: inputType,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
