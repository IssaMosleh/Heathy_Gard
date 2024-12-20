import 'package:flutter/material.dart';
import 'package:tess/pharmacy_screen/mainscreenpharmacy.dart';

class MedicationChangeReasonScreen extends StatelessWidget {
  final TextEditingController _descriptionController = TextEditingController();

  MedicationChangeReasonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Medication Change Reason", style: TextStyle(color: Colors.white)),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Please provide the reason for changing the medication:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _descriptionController,
              maxLines: 6, // Display up to 6 lines
              decoration: InputDecoration(
                labelText: "Description",
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                hintText: "Write the reason for changing the medication here...",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final reason = _descriptionController.text;
                if (reason.isNotEmpty) {
                  // Handle the logic for submitting the reason
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Reason submitted: $reason")),
                  );
                  // Navigate to another screen after submitting the reason
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Pharmacy_Screen()), // Replace NewScreen with the desired screen
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please enter a reason before submitting.")),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                backgroundColor: Colors.blue,
              ),
              child: const Text("Submit Reason", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

