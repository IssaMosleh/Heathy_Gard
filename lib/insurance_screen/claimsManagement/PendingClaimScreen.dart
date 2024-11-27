import 'package:flutter/material.dart';
import 'package:tess/insurance_screen/claimsManagement/ClaimsManagement.dart';
import 'package:tess/insurance_screen/claimsManagement/Reject_Screen.dart';

class PendingClaimScreen extends StatefulWidget {
  final Map<String, dynamic> claim;
  const PendingClaimScreen({super.key, required this.claim});

  @override
  _PendingClaimScreenState createState() => _PendingClaimScreenState();
}

class _PendingClaimScreenState extends State<PendingClaimScreen> {
  bool isApproveAllEnabled = false;
  bool isApproveSelectedEnabled = false;
  bool isVisitApproved = false;

  final List<Map<String, dynamic>> medications = [
    {
      'name': 'Amoxicillin',
      'GTIN': '12345678901234',
      'dosage': '500mg, 2x daily',
      'cost': 20.0,
      'status': 'Pending',
      'selected': true,  // Default to selected
    },
    {
      'name': 'Ibuprofen',
      'GTIN': '56789012345678',
      'dosage': '200mg, as needed',
      'cost': 10.0,
      'status': 'Pending',
      'selected': true,  // Default to selected
    },
  ];

  final List<Map<String, dynamic>> labTests = [
    {
      'name': 'Blood Test',
      'CPT': '80050',
      'description': 'Routine blood panel to assess health.',
      'cost': 50.0,
      'status': 'Pending',
      'selected': true,  // Default to selected
    },
  ];

  final List<Map<String, dynamic>> radiologyTests = [
    {
      'name': 'Chest X-ray',
      'CPT': '71020',
      'description': 'Imaging to check for lung issues.',
      'cost': 100.0,
      'status': 'Pending',
      'selected': true,  // Default to selected
    },
  ];

  double baseVisitCost = 100.0;

  @override
  void initState() {
    super.initState();
    updateButtonStates();  // Initialize button states
  }

  void updateButtonStates() {
    setState(() {
      bool allSelected = allItemsSelected();
      bool anySelected = anyItemsSelected();

      isApproveAllEnabled = allSelected;
      isApproveSelectedEnabled = anySelected && !allSelected;
    });
  }

  bool allItemsSelected() {
    return medications.every((med) => med['selected']) &&
           labTests.every((lab) => lab['selected']) &&
           radiologyTests.every((rad) => rad['selected']);
  }

  bool anyItemsSelected() {
    return medications.any((med) => med['selected']) ||
           labTests.any((lab) => lab['selected']) ||
           radiologyTests.any((rad) => rad['selected']);
  }

  double calculateTotalCost() {
    double medsCost = medications
        .where((med) => med['selected'])
        .fold(0, (sum, med) => sum + med['cost']);
    double labsCost = labTests
        .where((lab) => lab['selected'])
        .fold(0, (sum, lab) => sum + lab['cost']);
    double radiologyCost = radiologyTests
        .where((rad) => rad['selected'])
        .fold(0, (sum, rad) => sum + rad['cost']);
    return baseVisitCost + medsCost + labsCost + radiologyCost;
  }

  void toggleSelection(Map<String, dynamic> item) {
    setState(() {
      item['selected'] = !item['selected'];
    });
    updateButtonStates();
  }

  void approveVisitOnly(BuildContext context) {
    setState(() {
      isVisitApproved = true;
    Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ClaimsManagementScreen()),
            );
    },
);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Visit approved only.')),
    );
  }

  void approveAll(BuildContext context) {
    setState(() {
      isVisitApproved = true;  // Approve the visit itself
      
      for (var med in medications) {
        med['status'] = 'Approved';
        med['selected'] = true;  // Ensure it remains selected after approval
      }
      
      for (var lab in labTests) {
        lab['status'] = 'Approved';
        lab['selected'] = true;
      }
      
      for (var rad in radiologyTests) {
        rad['status'] = 'Approved';
        rad['selected'] = true;
      }

      updateButtonStates();  // Update button states based on new selections
    Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ClaimsManagementScreen()),
            );
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('All items approved, including visit, meds, labs, and radiology.')),
    );
  }

  void approveOnlySelected(BuildContext context) {
    setState(() {
      isVisitApproved = true;  // Approve the visit when any item is approved
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ClaimsManagementScreen()),
    );
    }
    );

    String approvalMessage = 'Selected Items:\n\n';

    medications.where((med) => med['selected']).forEach((med) {
      med['status'] = 'Approved';
      approvalMessage += '- ${med['name']} (Medication)\n';
    });

    labTests.where((lab) => lab['selected']).forEach((lab) {
      lab['status'] = 'Approved';
      approvalMessage += '- ${lab['name']} (Lab Test)\n';
    });

    radiologyTests.where((rad) => rad['selected']).forEach((rad) {
      rad['status'] = 'Approved';
      approvalMessage += '- ${rad['name']} (Radiology Test)\n';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(approvalMessage)),
    );
  }

  void rejectAll(BuildContext context) {
    setState(() {
      for (var med in medications) {
        med['status'] = 'Rejected';
      }
      for (var lab in labTests) {
        lab['status'] = 'Rejected';
      }
      for (var rad in radiologyTests) {
        rad['status'] = 'Rejected';
      }
      isVisitApproved = false;
      updateButtonStates();
    Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RejectScreen()),
            );
    }
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('All items in claim rejected.')),
    );
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
        title: const Text('Pending Claim Details',style: TextStyle(color: Colors.white),)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Patient Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Patient Name: ${widget.claim['patientName']}'),
            Text('Claim ID: ${widget.claim['id']}'),
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

            // Visit Cost
            const Text(
              'Visit Cost',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Total Cost: \$${calculateTotalCost().toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 16, color: Colors.blueGrey),
            ),
            const Divider(height: 24, thickness: 2),

            // Medications Section
            if (medications.isNotEmpty) ...[
              const Text(
                'Medications',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ...medications.map((med) => buildMedicationCard(context, med)),
              const Divider(height: 24, thickness: 2),
            ],

            // Labs Section
            if (labTests.isNotEmpty) ...[
              const Text(
                'Lab Tests',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ...labTests.map((lab) => buildLabCard(context, lab)),
              const Divider(height: 24, thickness: 2),
            ],

            // Radiology Section
            if (radiologyTests.isNotEmpty) ...[
              const Text(
                'Radiology Tests',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ...radiologyTests.map((rad) => buildRadiologyCard(context, rad)),
              const Divider(height: 24, thickness: 2),
            ],

            // Buttons Section
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: !isVisitApproved ? () => approveVisitOnly(context) : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    child: Text('Approve Visit Only'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: isApproveAllEnabled ? () => approveAll(context) : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    child: Text('Approve All'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: isApproveSelectedEnabled ? () => approveOnlySelected(context) : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    child: Text('Approve Only Selected'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => rejectAll(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    child: Text('Reject All'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMedicationCard(BuildContext context, Map<String, dynamic> med) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: CheckboxListTile(
        value: med['selected'],
        onChanged: (_) => toggleSelection(med),
        title: Text(med['name']),
        subtitle: Text('GTIN: ${med['GTIN']}, Dosage: ${med['dosage']}'),
      ),
    );
  }

  Widget buildLabCard(BuildContext context, Map<String, dynamic> lab) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: CheckboxListTile(
        value: lab['selected'],
        onChanged: (_) => toggleSelection(lab),
        title: Text(lab['name']),
        subtitle: Text('CPT: ${lab['CPT']}, ${lab['description']}'),
      ),
    );
  }

  Widget buildRadiologyCard(BuildContext context, Map<String, dynamic> rad) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: CheckboxListTile(
        value: rad['selected'],
        onChanged: (_) => toggleSelection(rad),
        title: Text(rad['name']),
        subtitle: Text('CPT: ${rad['CPT']}, ${rad['description']}'),
      ),
    );
  }
}
