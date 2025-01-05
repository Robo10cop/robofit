import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';

class VideoService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final Logger _logger = Logger();

  // Get video URL from Firebase Storage
  Future<String?> getVideoUrl(String videoPath) async {
    try {
      String videoUrl = await _storage.ref(videoPath).getDownloadURL();
      _logger.i('Video URL fetched successfully: $videoUrl');
      return videoUrl;
    } catch (e) {
      _logger.e('Failed to fetch video URL: $e');
      return null;
    }
  }

  // Upload a video to Firebase Storage
  Future<void> uploadVideo(String videoPath, String localFilePath) async {
    try {
      final ref = _storage.ref().child(videoPath);
      await ref.putFile(File(localFilePath));
      _logger.i('Video uploaded successfully: $videoPath');
    } catch (e) {
      _logger.e('Failed to upload video: $e');
    }
  }
}
