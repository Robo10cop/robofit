import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final Logger _logger = Logger();

  // Add user to the Firestore collection
  Future<void> addUser(Map<String, dynamic> userData, String userId) async {
    try {
      await _db.collection('users').doc(userId).set(userData);
      _logger.i('User added successfully: $userId');
    } catch (e) {
      _logger.e('Failed to add user: $e');
    }
  }

  // Fetch a user from the Firestore collection
  Future<DocumentSnapshot> getUser(String userId) async {
    try {
      DocumentSnapshot userDoc = await _db.collection('users').doc(userId).get();
      _logger.i('User fetched successfully: $userId');
      return userDoc;
    } catch (e) {
      _logger.e('Failed to fetch user: $e');
      rethrow;
    }
  }

  // Add training data to the Firestore collection
  Future<void> addTraining(Map<String, dynamic> trainingData, String trainingId) async {
    try {
      await _db.collection('trainings').doc(trainingId).set(trainingData);
      _logger.i('Training added successfully: $trainingId');
    } catch (e) {
      _logger.e('Failed to add training: $e');
    }
  }
}
