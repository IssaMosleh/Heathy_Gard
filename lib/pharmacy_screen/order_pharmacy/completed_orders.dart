import 'package:flutter/material.dart';

class CompletedOrderScreen extends StatefulWidget {
  final Map<String, dynamic> order;
  final String Function(String) getMedicineName;

  const CompletedOrderScreen({Key? key, required this.order, required this.getMedicineName}) : super(key: key);

  @override
  _CompletedOrderScreenState createState() => _CompletedOrderScreenState();
}

class _CompletedOrderScreenState extends State<CompletedOrderScreen> {
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
        title: Text("Completed Order Details", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildReadOnlyTextField(label: "Order ID", value: widget.order["orderId"], icon: Icons.confirmation_number),
            SizedBox(height: 12),
            _buildReadOnlyTextField(label: "Order Type", value: widget.order["orderType"], icon: Icons.assignment),
            SizedBox(height: 12),
            _buildReadOnlyTextField(label: "Doctor", value: widget.order["doctor"], icon: Icons.person),
            SizedBox(height: 12),
            _buildReadOnlyTextField(label: "Specialty", value: widget.order["specialty"], icon: Icons.local_hospital),
            SizedBox(height: 12),
            _buildReadOnlyTextField(label: "Patient", value: widget.order["patient"], icon: Icons.person_outline),
            SizedBox(height: 12),
            _buildReadOnlyTextField(label: "Date", value: widget.order["date"], icon: Icons.date_range),
            SizedBox(height: 12),
            _buildReadOnlyTextField(label: "Completed Date", value: widget.order["completedDate"], icon: Icons.check_circle),
            SizedBox(height: 12),
            _buildReadOnlyTextField(label: "Pharmacy Doctor ID", value: widget.order["pharmacyDoctorId"], icon: Icons.badge),
            SizedBox(height: 12),
            _buildReadOnlyTextField(label: "Pharmacy Doctor Name", value: widget.order["pharmacyDoctorName"], icon: Icons.person_add_alt),
            if (widget.order.containsKey("moneyPaid")) ...[
              SizedBox(height: 12),
              _buildReadOnlyTextField(label: "Money Paid", value: widget.order["moneyPaid"], icon: Icons.attach_money),
            ],
            const SizedBox(height: 24), // Extra spacing before Medications section
            const Text(
              "Medications:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            ...widget.order["medications"].asMap().entries.map<Widget>((entry) {
              int index = entry.key;
              String jtnCode = entry.value;
              String medicineName = widget.getMedicineName(jtnCode);
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: _buildReadOnlyTextField(
                  label: "Med ${index + 1}: $medicineName",
                  value: "JTN Code: $jtnCode",
                  icon: Icons.local_pharmacy,
                ),
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
