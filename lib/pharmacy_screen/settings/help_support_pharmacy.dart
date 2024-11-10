import 'package:flutter/material.dart';
import 'package:tess/pharmacy_screen/settings_pharmacy.dart';

class PharmacyHelpAndSupportScreen extends StatelessWidget {
  const PharmacyHelpAndSupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => settings_pharmacy()),
            );
        }, icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),
        title: const Text('Pharmacy Support', style: TextStyle(color: Colors.white)),
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
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Need Help? Here’s how we can assist you:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                "• Medication Queries: Get answers to your medication-related questions.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 12),
              const Text(
                "• Prescription Information: Verify and review prescriptions submitted to the pharmacy.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 12),
              const Text(
                "• Pharmacy Services: Learn about available services and policies at our pharmacy.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 12),
              const Text(
                "• Delivery Support: Get assistance with prescription deliveries.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to contact page or handle support request here
                  },
                  child: const Text("Contact Support"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    backgroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
