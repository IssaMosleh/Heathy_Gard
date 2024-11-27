import 'package:flutter/material.dart';
import 'package:tess/insurance_screen/claimsManagement/ClaimsManagement.dart';

class RejectedClaimScreen extends StatelessWidget {
  final Map<String, dynamic> claim;

  RejectedClaimScreen({super.key, required this.claim});

  final String rejectionReason = 'Non-Approved Medication';
  final String rejectionDescription = 'This claim was rejected because one or more medications prescribed are not covered under the current policy. To avoid future rejections, please ensure that all treatments, medications, and services are in line with the policy coverage details.';

  final List<Map<String, dynamic>> medications = [
    {
      'name': 'Amoxicillin',
      'GTIN': '12345678901234',
      'dosage': '500mg, 2x daily',
      'cost': 20.0,
      'status': 'Rejected',
    },
    {
      'name': 'Ibuprofen',
      'GTIN': '56789012345678',
      'dosage': '200mg, as needed',
      'cost': 10.0,
      'status': 'Rejected',
    },
  ];

  final List<Map<String, dynamic>> labTests = [
    {
      'name': 'Blood Test',
      'CPT': '80050',
      'description': 'Routine blood panel to assess health.',
      'cost': 50.0,
      'status': 'Rejected',
    },
  ];

  final List<Map<String, dynamic>> radiologyTests = [
    {
      'name': 'Chest X-ray',
      'CPT': '71020',
      'description': 'Imaging to check for lung issues.',
      'cost': 100.0,
      'status': 'Rejected',
    },
  ];

  double baseVisitCost = 100.0;

  double calculateTotalCost() {
    double medsCost = medications.fold(0, (sum, med) => sum + med['cost']);
    double labsCost = labTests.fold(0, (sum, lab) => sum + lab['cost']);
    double radiologyCost = radiologyTests.fold(0, (sum, rad) => sum + rad['cost']);
    return baseVisitCost + medsCost + labsCost + radiologyCost;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
           Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ClaimsManagementScreen()),
        );
        }, icon: const Icon(Icons.arrow_back_ios,color: Colors.white,)),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text('Rejected Claim Details',style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Claim Information
            buildSectionTitle('Claim Information'),
            buildInfoRow('Claim ID', claim['id']),
            buildInfoRow('Patient Name', claim['patientName']),
            buildInfoRow('Doctor', claim['doctorName'] ?? 'Dr. Sarah Thompson'),
            buildInfoRow('Hospital', claim['hospitalName'] ?? 'HealthPlus Hospital'),
            buildInfoRow('Date', claim['date']),
            const SizedBox(height: 20),

            // Rejection Details
            buildSectionTitle('Rejection Details'),
            buildRejectionCard(rejectionReason, rejectionDescription),
            const SizedBox(height: 20),

            // Visit Cost
            buildSectionTitle('Visit Cost'),
            Text(
              'Total Cost: \$${calculateTotalCost().toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 16, color: Colors.blueGrey),
            ),
            const Divider(height: 24, thickness: 2),

            // Medications Section
            if (medications.isNotEmpty) ...[
              buildSectionTitle('Medications'),
              ...medications.map((med) => buildMedicationCard(context, med)),
              const Divider(height: 24, thickness: 2),
            ],

            // Labs Section
            if (labTests.isNotEmpty) ...[
              buildSectionTitle('Lab Tests'),
              ...labTests.map((lab) => buildLabCard(context, lab)),
              const Divider(height: 24, thickness: 2),
            ],

            // Radiology Section
            if (radiologyTests.isNotEmpty) ...[
              buildSectionTitle('Radiology Tests'),
              ...radiologyTests.map((rad) => buildRadiologyCard(context, rad)),
              const Divider(height: 24, thickness: 2),
            ],
          ],
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRejectionCard(String reason, String description) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.red[50],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reason: $reason',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: const TextStyle(fontSize: 15, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMedicationCard(BuildContext context, Map<String, dynamic> med) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(med['name']),
        subtitle: Text('GTIN: ${med['GTIN']}, Dosage: ${med['dosage']}'),
        trailing: const Text(
          'Rejected',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildLabCard(BuildContext context, Map<String, dynamic> lab) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(lab['name']),
        subtitle: Text('CPT: ${lab['CPT']}, ${lab['description']}'),
        trailing: const Text(
          'Rejected',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildRadiologyCard(BuildContext context, Map<String, dynamic> rad) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(rad['name']),
        subtitle: Text('CPT: ${rad['CPT']}, ${rad['description']}'),
        trailing: const Text(
          'Rejected',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
