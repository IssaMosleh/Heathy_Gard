import 'package:flutter/material.dart';

class CompletedOrderScreen extends StatelessWidget {
  final Map<String, dynamic> order;
  final String Function(String) getMedicineName;

  const CompletedOrderScreen({Key? key, required this.order, required this.getMedicineName}) : super(key: key);

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
        title: Text("Completed Order Details",style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildReadOnlyTextField(label: "Order ID", value: order["orderId"], icon: Icons.confirmation_number),
            _buildReadOnlyTextField(label: "Order Type", value: order["orderType"], icon: Icons.assignment),
            _buildReadOnlyTextField(label: "Doctor", value: order["doctor"], icon: Icons.person),
            _buildReadOnlyTextField(label: "Specialty", value: order["specialty"], icon: Icons.local_hospital),
            _buildReadOnlyTextField(label: "Patient", value: order["patient"], icon: Icons.person_outline),
            _buildReadOnlyTextField(label: "Date", value: order["date"], icon: Icons.date_range),
            _buildReadOnlyTextField(label: "Completed Date", value: order["completedDate"], icon: Icons.check_circle),
            _buildReadOnlyTextField(label: "Pharmacy Doctor ID", value: order["pharmacyDoctorId"], icon: Icons.badge),
            _buildReadOnlyTextField(label: "Pharmacy Doctor Name", value: order["pharmacyDoctorName"], icon: Icons.person_add_alt),
            if (order.containsKey("moneyPaid"))
              _buildReadOnlyTextField(label: "Money Paid", value: order["moneyPaid"], icon: Icons.attach_money),
            const SizedBox(height: 16),
            const Text(
              "Medications:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ...order["medications"].asMap().entries.map<Widget>((entry) {
              int index = entry.key;
              String jtnCode = entry.value;
              String medicineName = getMedicineName(jtnCode);
              return _buildReadOnlyTextField(
                label: "Med ${index + 1}: $medicineName",
                value: "JTN Code: $jtnCode",
                icon: Icons.local_pharmacy,
              );
            }).toList(),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: TextFormField(
        readOnly: true,
        initialValue: value,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: icon != null ? Icon(icon) : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          isDense: true,
          contentPadding: EdgeInsets.all(8),
        ),
      ),
    );
  }
}

