import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NameAendernScreen extends StatefulWidget {
  const NameAendernScreen({super.key});

  @override
  State<NameAendernScreen> createState() => _NameAendernScreenState();
}

class _NameAendernScreenState extends State<NameAendernScreen> {
  final TextEditingController _nameController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _updateName() async {
    String newName = _nameController.text.trim();
    if (newName.isNotEmpty) {
      try {
        await _auth.currentUser?.updateDisplayName(newName);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Benutzername erfolgreich geändert.')),
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
      appBar: AppBar(title: const Text("Benutzernamen ändern")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Neuer Benutzername",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateName,
              child: const Text("Speichern"),
            ),
          ],
        ),
      ),
    );
  }
}
