import 'dart:io'; // Import für File
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class BootyWorkoutVideoScreen extends StatefulWidget {
  final String duration;

  const BootyWorkoutVideoScreen({super.key, required this.duration});

  @override
  State<BootyWorkoutVideoScreen> createState() => _BootyWorkoutVideoScreenState();
}

class _BootyWorkoutVideoScreenState extends State<BootyWorkoutVideoScreen> {
  late Future<String> _videoUrlFuture;
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _videoUrlFuture = _getVideoUrl(); // Firebase URL laden
  }

  Future<String> _getVideoUrl() async {
    // Video-Datei basierend auf Dauer laden
    String videoFile = "bootyspezial${widget.duration.replaceAll("'", "")}.mp4";
    Reference ref = FirebaseStorage.instance.ref().child("Booty/$videoFile");

    // Hole die Download-URL von Firebase
    String url = await ref.getDownloadURL();

    // Verwende den Cache, um das Video lokal zwischenzuspeichern
    final file = await DefaultCacheManager().getSingleFile(url);
    debugPrint('Video wurde zwischengespeichert unter: ${file.path}');
    
    return file.path; // Gibt den lokalen Pfad zurück, um den Cache zu nutzen
  }

  @override
  void dispose() {
    _videoController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booty-Workout ${widget.duration}'),
        backgroundColor: Colors.brown[400],
      ),
      body: FutureBuilder<String>(
        future: _videoUrlFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Fehler beim Laden des Videos.',
                style: const TextStyle(color: Colors.red, fontSize: 18),
              ),
            );
          } else {
            final videoPath = snapshot.data!;
            _videoController = VideoPlayerController.file(File(videoPath)); // Verwende File hier
            _chewieController = ChewieController(
              videoPlayerController: _videoController!,
              autoPlay: true,
              looping: false,
              allowPlaybackSpeedChanging: true,
              autoInitialize: true, // Video wird direkt vorab geladen
              errorBuilder: (context, errorMessage) {
                return Center(
                  child: Text(
                    'Fehler: $errorMessage',
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                  ),
                );
              },
            );

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Abgespieltes Video: bootyspezial${widget.duration}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Chewie(controller: _chewieController!),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown[600],
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    ),
                    child: const Text(
                      'Training abgeschlossen',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
