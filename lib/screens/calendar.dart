import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final Map<DateTime, List<String>> _events = {}; // Hier werden Trainingseinträge gespeichert.
  DateTime _selectedDay = DateTime.now();
  List<String> _selectedEvents = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calendar')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2100, 12, 31),
              focusedDay: _selectedDay,
              calendarFormat: CalendarFormat.month,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              eventLoader: (day) => _events[day] ?? [],
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _selectedEvents = _events[selectedDay] ?? [];
                });
              },
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _selectedEvents.isEmpty
                  ? const Center(child: Text('Keine Einträge für diesen Tag.'))
                  : ListView.builder(
                      itemCount: _selectedEvents.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const Icon(Icons.fitness_center),
                          title: Text(_selectedEvents[index]),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void addEvent(String eventTitle) {
    final DateTime today = DateTime(
      _selectedDay.year,
      _selectedDay.month,
      _selectedDay.day,
    );

    setState(() {
      if (_events[today] == null) {
        _events[today] = [eventTitle];
      } else {
        _events[today]!.add(eventTitle);
      }
    });
  }
}
