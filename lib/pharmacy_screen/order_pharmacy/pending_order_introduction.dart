import 'package:flutter/material.dart';
import 'package:tess/pharmacy_screen/order_pharmacy/order_pharmacy.dart';
import 'package:tess/pharmacy_screen/order_pharmacy/pending_orders.dart';

class PharmacyDispenseIntroduction extends StatelessWidget {
  const PharmacyDispenseIntroduction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: 50,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)], // Updated colors
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: MaterialButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MedicationDispenseScreen()),
            );
          },
          minWidth: double.infinity,
          height: 50,
          child: const Text(
            "I Agree",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: AppBar(
          centerTitle: true,
          title: const Text(
            "Pharmacy Dispense Center",
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PharmacyOrderScreen()),
            );
            },
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)], // Updated colors
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
            border: Border.all(
              color: Colors.blue.shade200,
              width: 1.5,
            ),
          ),
          child: const SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Pharmacy Dispensing Agreement",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "By proceeding with the medication dispensing process, you agree to adhere to the following rules and guidelines:",
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
                SizedBox(height: 10),
                Text(
                  "1. Patient Verification:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Verify the patient's identity before dispensing medication. Ensure the prescription details match the patient's record.",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                SizedBox(height: 10),
                Text(
                  "2. Prescription Accuracy:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Dispense only the medication and dosage specified on the prescription. Any modifications require prior authorization from the prescriber.",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                SizedBox(height: 10),
                Text(
                  "3. Patient Confidentiality:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "All patient information is confidential and protected under HIPAA. Do not disclose any patient data unless permitted by law.",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                SizedBox(height: 10),
                Text(
                  "4. Medication Counseling:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Provide appropriate counseling to the patient on medication usage, potential side effects, and storage. Document any counseling provided.",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                SizedBox(height: 10),
                Text(
                  "5. HIPAA Compliance:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Ensure all actions comply with HIPAA regulations to safeguard patient privacy and secure medical information.",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                SizedBox(height: 10),
                Text(
                  "6. Record Keeping:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Maintain accurate records of dispensed medications, patient interactions, and any relevant notes for auditing purposes.",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
