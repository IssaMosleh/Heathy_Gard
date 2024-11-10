import 'package:flutter/material.dart';

class ChangeHistoryScreen extends StatefulWidget {
  const ChangeHistoryScreen({Key? key}) : super(key: key);

  @override
  _ChangeHistoryScreenState createState() => _ChangeHistoryScreenState();
}

class _ChangeHistoryScreenState extends State<ChangeHistoryScreen> {
  // Mock data
  final Map<String, dynamic> order = {
    "orderId": "DOC12345",
    "orderType": "Change Meds",
    "doctor": "Dr. John Doe",
    "specialty": "Cardiology",
    "patient": "Alice Johnson",
    "date": "10 November 2023",
    "changeDate": "12 November 2023",
    "pharmacyDoctorId": "DOC678",
    "pharmacyDoctorName": "Dr. Adam Brown",
    "moneyPaid": "100 JOD",
    "medications": ["JTN123", "JTN456"],
    "reason": "Patient experienced side effects",
  };

  String getMedicineName(String jtnCode) {
    // Mock medicines for JTN codes
    final Map<String, String> medicines = {
      "JTN123": "Ibuprofen 200mg",
      "JTN456": "Amoxicillin 500mg",
      "JTN789": "Metformin 500mg",
      "JTN012": "Atorvastatin 20mg",
    };
    return medicines[jtnCode] ?? "Unknown Medicine";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white), // iOS-style back arrow icon
          onPressed: () => Navigator.of(context).pop(),
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
        title: Text("Change History", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildReadOnlyTextField(label: "Order ID", value: order["orderId"], icon: Icons.confirmation_number),
            SizedBox(height: 12),
            _buildReadOnlyTextField(label: "Order Type", value: order["orderType"], icon: Icons.assignment),
            SizedBox(height: 12),
            _buildReadOnlyTextField(label: "Doctor", value: order["doctor"], icon: Icons.person),
            SizedBox(height: 12),
            _buildReadOnlyTextField(label: "Specialty", value: order["specialty"], icon: Icons.local_hospital),
            SizedBox(height: 12),
            _buildReadOnlyTextField(label: "Patient", value: order["patient"], icon: Icons.person_outline),
            SizedBox(height: 12),
            _buildReadOnlyTextField(label: "Date", value: order["date"], icon: Icons.date_range),
            SizedBox(height: 12),
            _buildReadOnlyTextField(label: "Change Date", value: order["changeDate"], icon: Icons.check_circle),
            SizedBox(height: 12),
            _buildReadOnlyTextField(label: "Pharmacy Doctor ID", value: order["pharmacyDoctorId"], icon: Icons.badge),
            SizedBox(height: 12),
            _buildReadOnlyTextField(label: "Pharmacy Doctor Name", value: order["pharmacyDoctorName"], icon: Icons.person_add_alt),
            if (order.containsKey("moneyPaid")) ...[ // If "moneyPaid" exists, display it
              SizedBox(height: 12),
              _buildReadOnlyTextField(label: "Money Paid", value: order["moneyPaid"], icon: Icons.attach_money),
            ],
            const SizedBox(height: 24), // Extra spacing before Medications section
            const Text(
              "Medications:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            ...order["medications"].asMap().entries.map<Widget>((entry) {
              int index = entry.key;
              String jtnCode = entry.value;
              String medicineName = getMedicineName(jtnCode);
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: _buildReadOnlyTextField(
                  label: "Med ${index + 1}: $medicineName",
                  value: "JTN Code: $jtnCode",
                  icon: Icons.local_pharmacy,
                ),
              );
            }).toList(),
            SizedBox(height: 24),
            const Text(
              "Reason for Change:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            // Added multiline input and scrolling for the reason field
            TextFormField(
              initialValue: order["reason"] ?? "No reason provided", // Display the reason if available
              maxLines: 6, // Max 6 lines for reason
              minLines: 3, // Minimum 3 lines to start
              readOnly: true,
              decoration: InputDecoration(
                labelText: "Change Reason",
                prefixIcon: Icon(Icons.notes),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                isDense: true,
                contentPadding: EdgeInsets.all(12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReadOnlyTextField({
    required String label,
    required String value,
    IconData? icon,
  }) {
    return TextFormField(
      readOnly: true,
      initialValue: value,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: icon != null ? Icon(icon) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        isDense: true,
        contentPadding: EdgeInsets.all(12),
      ),
    );
  }
}
