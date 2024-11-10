import 'package:flutter/material.dart';

class PharmacyTermsOfServiceScreen extends StatelessWidget {
  const PharmacyTermsOfServiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms of Service', style: TextStyle(color: Colors.white)),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "By using our pharmacy services, you agree to the following terms:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              "• You must be 18 years or older to use our prescription services.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            const Text(
              "• We reserve the right to update these terms at any time.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            const Text(
              "• Our pharmacy is not responsible for the misuse of prescribed medication.",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
