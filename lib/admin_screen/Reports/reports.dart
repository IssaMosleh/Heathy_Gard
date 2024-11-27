import 'package:flutter/material.dart';
import 'package:tess/admin_screen/Reports/report_details.dart';
import 'package:tess/admin_screen/mainadminscreen.dart';

class Insurance {
  final String insuranceName;
  final double totalMoneySpent;
  final int totalClaims;

  Insurance({
    required this.insuranceName,
    required this.totalMoneySpent,
    required this.totalClaims,
  });
}

class Report_main extends StatelessWidget {
  final List<Insurance> insurances = [
    Insurance(
        insuranceName: "XYZ Health Insurance",
        totalMoneySpent: 250000.0,
        totalClaims: 128),
    Insurance(
        insuranceName: "ABC Insurance",
        totalMoneySpent: 150000.0,
        totalClaims: 90),
    // Add more insurance data as needed
  ];

  Report_main({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AdminScreen()),
              );
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        title: const Text(
          'All Insurances',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: insurances.length,
        itemBuilder: (context, index) {
          final insurance = insurances[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              title: Text(
                insurance.insuranceName,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "Total Money Spent: \$${insurance.totalMoneySpent.toStringAsFixed(2)}\n"
                "Total Claims: ${insurance.totalClaims}",
              ),
              trailing:
                  const Icon(Icons.arrow_forward_ios, color: Colors.blueAccent),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ReportsScreen(),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class InsuranceDetailsScreen extends StatelessWidget {
  final Insurance insurance;

  const InsuranceDetailsScreen({super.key, required this.insurance});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(insurance.insuranceName),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Insurance Details',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            buildDetailRow("Total Money Spent",
                "\$${insurance.totalMoneySpent.toStringAsFixed(2)}"),
            buildDetailRow("Total Claims", "${insurance.totalClaims}"),
            // Add more details or charts if necessary
          ],
        ),
      ),
    );
  }

  Widget buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
