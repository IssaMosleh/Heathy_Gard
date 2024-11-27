import 'package:flutter/material.dart';
import 'package:tess/insurance_screen/claimsManagement/ClaimsManagement.dart';

class ApprovedClaimScreen extends StatelessWidget {
  final Map<String, dynamic> claim;

  ApprovedClaimScreen({super.key, required this.claim});

  final List<Map<String, dynamic>> medications = [
    {
      'name': 'Amoxicillin',
      'GTIN': '12345678901234',
      'dosage': '500mg, 2x daily',
      'cost': 20.0,
      'status': 'Approved',
    },
    {
      'name': 'Ibuprofen',
      'GTIN': '56789012345678',
      'dosage': '200mg, as needed',
      'cost': 10.0,
      'status': 'Approved',
    },
  ];

  final List<Map<String, dynamic>> labTests = [
    {
      'name': 'Blood Test',
      'CPT': '80050',
      'description': 'Routine blood panel to assess health.',
      'cost': 50.0,
      'status': 'Approved',
    },
  ];

  final List<Map<String, dynamic>> radiologyTests = [
    {
      'name': 'Chest X-ray',
      'CPT': '71020',
      'description': 'Imaging to check for lung issues.',
      'cost': 100.0,
      'status': 'Approved',
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
      title: const Text('Approved Claim Details',style: TextStyle(color: Colors.white),)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Patient Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Patient Name: ${claim['patientName']}'),
            Text('Claim ID: ${claim['id']}'),
            const Text('Doctor: Dr. Sarah Thompson'),
            const Text('Pharmacy: HealthPlus Pharmacy'),
            const Divider(height: 24, thickness: 2),

            const Text(
              'Diagnoses Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Treatment for acute pharyngitis with prescribed antibiotics and supportive medications.',
              style: TextStyle(color: Colors.black87),
            ),
            const SizedBox(height: 8),
            const Text(
              'ICD-10 Code: J02.9 - Acute Pharyngitis',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blueGrey),
            ),
            const Divider(height: 24, thickness: 2),

            const Text(
              'Visit Cost',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Total Cost: \$${calculateTotalCost().toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 16, color: Colors.blueGrey),
            ),
            const Divider(height: 24, thickness: 2),

            if (medications.isNotEmpty) ...[
              const Text(
                'Medications',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ...medications.map((med) => buildMedicationCard(context, med)),
              const Divider(height: 24, thickness: 2),
            ],

            if (labTests.isNotEmpty) ...[
              const Text(
                'Lab Tests',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ...labTests.map((lab) => buildLabCard(context, lab)),
              const Divider(height: 24, thickness: 2),
            ],

            if (radiologyTests.isNotEmpty) ...[
              const Text(
                'Radiology Tests',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ...radiologyTests.map((rad) => buildRadiologyCard(context, rad)),
              const Divider(height: 24, thickness: 2),
            ],
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
          'Approved',
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
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
          'Approved',
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
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
          'Approved',
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
