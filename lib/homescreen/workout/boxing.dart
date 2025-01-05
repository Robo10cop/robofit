import 'package:flutter/material.dart';

class BoxenScreen extends StatefulWidget {
  const BoxenScreen({super.key});

  @override
  BoxenScreenState createState() => BoxenScreenState();
}

class BoxenScreenState extends State<BoxenScreen> {
  int? selectedDuration;
  int? selectedIntensity;

  final List<int> durations = [23, 31, 39, 47, 55, 63, 71, 79];
  final List<int> intensityLevels = [1, 2, 3, 4, 5];

  void _onSelection() {
    if (selectedDuration != null && selectedIntensity != null) {
      String videoFile = _getVideoFile(selectedDuration!, selectedIntensity!);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VideoPlayerScreen(videoFile: videoFile),
        ),
      );
    }
  }

  String _getVideoFile(int duration, int intensity) {
    return 'assets/videos/boxing_${intensity}_$duration.mp4';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Boxen-Workout'),
        backgroundColor: Colors.brown[400],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Oberer kurzer Header
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Starte dein Boxen-Workout!',
                style: TextStyle(
                  fontSize: 18, // Kleinerer Font
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            // Trainingszeiten-Auswahl in drei Spalten
            const Text(
              'Wähle die Trainingszeit:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3, // 3 Spalten
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 2.5,
                children: durations.map((duration) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDuration = duration;
                      });
                      _onSelection();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: selectedDuration == duration
                            ? Colors.green[300]
                            : Colors.brown[300],
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 5,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '$duration',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 10),
            // Intensität-Auswahl in einer Reihe
            const Text(
              'Wähle die Intensität:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: intensityLevels.map((level) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIntensity = level;
                    });
                    _onSelection();
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: selectedIntensity == level
                          ? Colors.green[300]
                          : Colors.red[100 * level],
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '$level',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class VideoPlayerScreen extends StatelessWidget {
  final String videoFile;

  const VideoPlayerScreen({super.key, required this.videoFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dein Workout-Video'),
      ),
      body: Center(
        child: Text(
          'Video: $videoFile wird abgespielt',
          style: const TextStyle(fontSize: 22),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
