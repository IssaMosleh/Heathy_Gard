import 'package:flutter/material.dart';

class PharmacyPartnersScreen extends StatelessWidget {
  const PharmacyPartnersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Our Pharmacy Partners', style: TextStyle(color: Colors.white)),
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
              "We work with trusted pharmaceutical companies and suppliers to bring you the best in medications and healthcare products.",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 12),
            _buildPartnerCard('PharmaCorp', 'Top supplier of generic and branded medications'),
            _buildPartnerCard('MediPharm', 'Leading distributor of over-the-counter products'),
            _buildPartnerCard('HealthPlus', 'Pharmacy with a focus on wellness and preventative care'),
          ],
        ),
      ),
    );
  }

  Widget _buildPartnerCard(String name, String description) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 4,
      child: ListTile(
        title: Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text(description, style: const TextStyle(fontSize: 14)),
      ),
    );
  }
}
