import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Logger _logger = Logger();

  // User registration
  Future<User?> register(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _logger.i('User registered successfully: ${userCredential.user?.email}');
      return userCredential.user;
    } catch (e) {
      _logger.e('Registration failed: $e');
      return null;
    }
  }

  // User login
  Future<User?> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _logger.i('User logged in successfully: ${userCredential.user?.email}');
      return userCredential.user;
    } catch (e) {
      _logger.e('Login failed: $e');
      return null;
    }
  }

  // User logout
  Future<void> logout() async {
    try {
      await _auth.signOut();
      _logger.i('User logged out successfully');
    } catch (e) {
      _logger.e('Logout failed: $e');
    }
  }
}
