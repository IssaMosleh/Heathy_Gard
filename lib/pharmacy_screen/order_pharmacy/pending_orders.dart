import 'package:flutter/material.dart';
import 'package:tess/pharmacy_screen/main.dart';
import 'package:tess/pharmacy_screen/order_pharmacy/ChangeMedication.dart';
import 'package:tess/pharmacy_screen/order_pharmacy/pending_order_introduction.dart';

class MedicationDispenseScreen extends StatefulWidget {
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
  final TextEditingController _jtnCodesController = TextEditingController();

  List<Map<String, String>> medications = [
    {"jtnCode": "JTN123", "dose": "Take 2 tablets daily"},
    {"jtnCode": "JTN456", "dose": "Take 1 tablet every 8 hours"}
  ];

  bool isConfirmDisabled = false;

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
    _jtnCodesController.text = "JTN123, JTN456"; // Example JTN codes
  }

  void _requestMedicationChange() {
    setState(() {
      isConfirmDisabled = true; // Disable Confirm Dispense button
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Medication change request sent. Patient needs to revisit doctor.")),
    );
    
    // Navigate to the PendingOrderIntroduction screen for a medication change request
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MedicationChangeReasonScreen()),
    );
  }

  void _confirmDispense() {
    if (!isConfirmDisabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Medication dispensing confirmed.")),
      );
      
      // Navigate to the PendingOrderIntroduction screen to finalize the dispense
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Pharmacy_Screen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Medication Dispense", style: TextStyle(color: Colors.white)),
        leading: IconButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PharmacyDispenseIntroduction()),
          ),
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
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
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildReadOnlyTextField("Patient Name", _patientNameController),
            SizedBox(height: 12),
            _buildReadOnlyTextField("Patient ID", _patientIdController),
            SizedBox(height: 12),
            _buildReadOnlyTextField("Doctor Name", _doctorNameController),
            SizedBox(height: 12),
            _buildReadOnlyTextField("Doctor ID", _doctorIdController),
            SizedBox(height: 12),
            _buildReadOnlyTextField("Pharmacy Name", _pharmacyNameController),
            SizedBox(height: 12),
            _buildReadOnlyTextField("Pharmacy ID", _pharmacyIdController),
            SizedBox(height: 12),
            _buildReadOnlyTextField("Insurance Company", _insuranceCompanyController),
            SizedBox(height: 12),
            _buildReadOnlyTextField("Insurance ID", _insuranceIdController),
            SizedBox(height: 12),
            _buildReadOnlyTextField("Medication Status", _medicationStatusController, hintText: "Medication has been dispensed"),
            SizedBox(height: 12),
            _buildReadOnlyTextField("JTN Codes", _jtnCodesController, hintText: "JTN123, JTN456"),
            SizedBox(height: 24),

            // Display each medication and its dose
            Text("Medications:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ...medications.map((medication) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Medication: ${medication['jtnCode']}"),
                  Text("Dose: ${medication['dose']}"),
                  SizedBox(height: 12),
                ],
              );
            }).toList(),

            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _requestMedicationChange,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                    backgroundColor: Colors.orange,
                  ),
                  child: Text("Change Medication", style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: isConfirmDisabled ? null : _confirmDispense,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                    backgroundColor: Colors.green,
                  ),
                  child: Text("Confirm Dispense", style: TextStyle(color: Colors.white)),
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
        contentPadding: EdgeInsets.all(12),
      ),
    );
  }
}
