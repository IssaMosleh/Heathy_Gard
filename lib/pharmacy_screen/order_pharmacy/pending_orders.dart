import 'package:flutter/material.dart';
import 'package:tess/pharmacy_screen/mainscreenpharmacy.dart';
import 'package:tess/pharmacy_screen/order_pharmacy/ChangeMedication.dart';
import 'package:tess/pharmacy_screen/order_pharmacy/pending_order_introduction.dart';

class MedicationDispenseScreen extends StatefulWidget {
  const MedicationDispenseScreen({super.key});

  @override
  _MedicationDispenseScreenState createState() => _MedicationDispenseScreenState();
}

class _MedicationDispenseScreenState extends State<MedicationDispenseScreen> {
  final TextEditingController _patientNameController = TextEditingController();
  final TextEditingController _patientIdController = TextEditingController();
  final TextEditingController _doctorNameController = TextEditingController();
  final TextEditingController _doctorIdController = TextEditingController();
  final TextEditingController _pharmacyNameController = TextEditingController();
  final TextEditingController _pharmacyIdController = TextEditingController();
  final TextEditingController _insuranceCompanyController = TextEditingController();
  final TextEditingController _insuranceIdController = TextEditingController();
  final TextEditingController _medicationStatusController = TextEditingController();
  final TextEditingController _gtinCodesController = TextEditingController();

  // List of medications with GTIN codes, medication names, and doses
  List<Map<String, String>> medications = [
    {"gtinCode": "GTIN123456789012", "medicationName": "Ibuprofen 200mg", "dose": "Take 2 tablets daily"},
    {"gtinCode": "GTIN987654321098", "medicationName": "Amoxicillin 500mg", "dose": "Take 1 tablet every 8 hours"}
  ];

  @override
  void initState() {
    super.initState();

    // Set default values for demonstration purposes
    _patientNameController.text = "John Doe";
    _patientIdController.text = "P12345";
    _doctorNameController.text = "Dr. Smith";
    _doctorIdController.text = "D67890";
    _pharmacyNameController.text = "Health Pharmacy";
    _pharmacyIdController.text = "PH1234";
    _insuranceCompanyController.text = "Global Insurance";
    _insuranceIdController.text = "INS4567";
    _medicationStatusController.text = "Medication has been dispensed";
    _gtinCodesController.text = "GTIN123456789012, GTIN987654321098"; // Example GTIN codes
  }

  void _requestMedicationChange() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Medication change request sent. Patient needs to revisit doctor.")),
    );
    
    // Navigate to the PendingOrderIntroduction screen for a medication change request
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MedicationChangeReasonScreen()),
    );
  }

  void _confirmDispense() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Medication dispensing confirmed.")),
    );
    
    // Navigate to the PendingOrderIntroduction screen to finalize the dispense
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Pharmacy_Screen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Medication Dispense", style: TextStyle(color: Colors.white)),
        leading: IconButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PharmacyDispenseIntroduction()),
          ),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildReadOnlyTextField("Patient Name", _patientNameController),
            const SizedBox(height: 12),
            _buildReadOnlyTextField("Patient ID", _patientIdController),
            const SizedBox(height: 12),
            _buildReadOnlyTextField("Doctor Name", _doctorNameController),
            const SizedBox(height: 12),
            _buildReadOnlyTextField("Doctor ID", _doctorIdController),
            const SizedBox(height: 12),
            _buildReadOnlyTextField("Pharmacy Name", _pharmacyNameController),
            const SizedBox(height: 12),
            _buildReadOnlyTextField("Pharmacy ID", _pharmacyIdController),
            const SizedBox(height: 12),
            _buildReadOnlyTextField("Insurance Company", _insuranceCompanyController),
            const SizedBox(height: 12),
            _buildReadOnlyTextField("Insurance ID", _insuranceIdController),
            const SizedBox(height: 12),
            _buildReadOnlyTextField("Medication Status", _medicationStatusController, hintText: "Medication has been dispensed"),
            const SizedBox(height: 12),
            _buildReadOnlyTextField("GTIN Codes", _gtinCodesController, hintText: "GTIN123456789012, GTIN987654321098"),
            const SizedBox(height: 24),

            // Display each medication with GTIN code, medication name, and dose
            const Text("Medications:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ...medications.map((medication) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("GTIN: ${medication['gtinCode']}"),
                  Text("Medication: ${medication['medicationName']}"),
                  Text("Dose: ${medication['dose']}"),
                  const SizedBox(height: 12),
                ],
              );
            }),

            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _requestMedicationChange,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                    backgroundColor: Colors.orange,
                  ),
                  child: const Text("Change Medication", style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: _confirmDispense,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                    backgroundColor: Colors.green,
                  ),
                  child: const Text("Confirm Dispense", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReadOnlyTextField(String label, TextEditingController controller, {String? hintText}) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        isDense: true,
        contentPadding: const EdgeInsets.all(12),
      ),
    );
  }
}
