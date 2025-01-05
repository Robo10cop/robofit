import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmailAendernScreen extends StatefulWidget {
  const EmailAendernScreen({super.key});

  @override
  State<EmailAendernScreen> createState() => _EmailAendernScreenState();
}

class _EmailAendernScreenState extends State<EmailAendernScreen> {
  final TextEditingController _emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _updateEmail() async {
    String newEmail = _emailController.text.trim();
    if (newEmail.isNotEmpty) {
      try {
        await _auth.currentUser?.verifyBeforeUpdateEmail(newEmail);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('E-Mail-Bestätigungslink gesendet.')),
          );
          Navigator.pop(context);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Fehler: ${e.toString()}')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("E-Mail-Adresse ändern")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: "Neue E-Mail-Adresse",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateEmail,
              child: const Text("Speichern"),
            ),
          ],
        ),
      ),
    );
  }
}
