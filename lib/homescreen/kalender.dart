import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class KalenderScreen extends StatefulWidget {
  const KalenderScreen({super.key});

  @override
  State<KalenderScreen> createState() => _KalenderScreenState();
}

class _KalenderScreenState extends State<KalenderScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDate = DateTime.now();

  // Beispiel-Daten für vergangene Workouts
  final Map<DateTime, List<String>> _completedWorkouts = {
    DateTime(2024, 10, 10): ['Brusttraining', 'Cardio'],
    DateTime(2024, 10, 12): ['Beintraining'],
  };

  List<String> _getWorkoutsForDay(DateTime day) {
    return _completedWorkouts[DateUtils.dateOnly(day)] ?? [];
  }

  void _addWorkout(DateTime date, String workoutName) {
    setState(() {
      _completedWorkouts.putIfAbsent(DateUtils.dateOnly(date), () => []).add(workoutName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalender'),
        backgroundColor: Colors.brown[400],
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2022, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDate,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDate = selectedDay;
                _focusedDate = focusedDay;
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDate = focusedDay;
            },
            calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.brown,
                shape: BoxShape.circle,
              ),
              outsideDaysVisible: false,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: _buildDayView(_selectedDate),)

        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown[400],
        onPressed: () => _showAddWorkoutDialog(_selectedDate),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildDayView(DateTime date) {
    List<String> workouts = _getWorkoutsForDay(date);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Workouts am ${date.day}.${date.month}.${date.year}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          workouts.isEmpty
              ? const Text('Keine abgeschlossenen Workouts vorhanden.')
              : Column(
                  children: workouts.map((workout) {
                    return ListTile(
                      leading: const Icon(Icons.fitness_center, color: Colors.brown),
                      title: Text(workout),
                    );
                  }).toList(),
                ),
        ],
      ),
    );
  }

  void _showAddWorkoutDialog(DateTime date) {
    TextEditingController workoutController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Workout hinzufügen'),
          content: TextField(
            controller: workoutController,
            decoration: const InputDecoration(hintText: 'Workout-Name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Abbrechen'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
              onPressed: () {
                if (workoutController.text.trim().isNotEmpty) {
                  _addWorkout(date, workoutController.text.trim());
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Hinzufügen'),
            ),
          ],
        );
      },
    );
  }
}
