import 'package:flutter/material.dart';

class TrainingPlanScreen extends StatelessWidget {
  const TrainingPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Training Plan')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Choose your goals and preferences:'),
            DropdownButton<String>(
              items: const [
                DropdownMenuItem(value: '15-minute Butt', child: Text('15-minute Butt')),
                DropdownMenuItem(value: 'Full Body', child: Text('Full Body')),
              ],
              onChanged: (value) {
                // Save the selection
              },
              hint: const Text('Select Training Type'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the calendar or plan
              },
              child: const Text('Save Plan'),
            ),
          ],
        ),
      ),
    );
  }
}
