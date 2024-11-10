import 'package:flutter/material.dart';

class PharmacyPrivacyPolicyScreen extends StatelessWidget {
  const PharmacyPrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy', style: TextStyle(color: Colors.white)),
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
              "At our pharmacy, we take your privacy seriously. Here's how we handle your information:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              "• We collect personal and prescription information for processing your orders.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            const Text(
              "• Your information is kept secure, and is only shared with healthcare providers when necessary.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            const Text(
              "• We comply with privacy regulations to protect your health data.",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
