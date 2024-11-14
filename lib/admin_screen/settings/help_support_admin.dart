import 'package:flutter/material.dart';
import 'package:tess/admin_screen/settings_admin.dart';
import 'package:url_launcher/url_launcher.dart';


class help_support_admin extends StatelessWidget {
  const help_support_admin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HelpSupportScreen(),
    );
  }
}

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({Key? key}) : super(key: key);

  Future<void> _launchPhoneDialer() async {
    const phoneNumber = 'tel:0795334901';
    if (await canLaunch(phoneNumber)) {
      await launch(phoneNumber);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pharmacy Help & Support', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => settings_admin()),
            );
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Pharmacy Help & Support",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Common Queries",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                _buildFAQItem(
                  question: "How do I manage medication refills?",
                  answer:
                      "Navigate to the 'Medication Refills' section in the pharmacy dashboard to review and approve refill requests from patients.",
                ),
                _buildFAQItem(
                  question: "How do I handle a medication shortage?",
                  answer:
                      "If a medication is out of stock, you can mark it as unavailable in the system and notify the patient with alternative options.",
                ),
                _buildFAQItem(
                  question: "How can I verify a prescription?",
                  answer:
                      "Prescriptions can be verified by cross-checking the details in the 'Prescription' section of the patient's profile.",
                ),
                const SizedBox(height: 16),
                const Text(
                  "Contact Us",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: const [
                    Icon(Icons.email, color: Colors.blue),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "Email: pharmacy_support@healthapp.com",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: const [
                    Icon(Icons.phone, color: Colors.blue),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "Phone: +962 79 533 4901",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  "Submit a Support Request",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "For further assistance, please submit a detailed description of your issue. Our support team will respond promptly.",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 150,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.purple, Colors.blue],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ElevatedButton.icon(
                        icon: const Icon(
                          Icons.support_agent,
                          color: Colors.white,
                          size: 20,
                        ),
                        label: const Text(
                          "Contact Support",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: _launchPhoneDialer,
                      ),
                    ),
                    Container(
                      width: 150,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.purple, Colors.blue],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ElevatedButton.icon(
                        icon: const Icon(
                          Icons.question_answer,
                          color: Colors.white,
                          size: 20,
                        ),
                        label: const Text(
                          "FAQ Center",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          // Code to navigate to FAQ center
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFAQItem({required String question, required String answer}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            answer,
            style: const TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
