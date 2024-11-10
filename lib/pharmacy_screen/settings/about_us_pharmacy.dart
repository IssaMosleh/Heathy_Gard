import 'package:flutter/material.dart';
import 'package:tess/pharmacy_screen/settings_pharmacy.dart';

class AboutUsPharmacy extends StatelessWidget {
  const AboutUsPharmacy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AboutUsScreen(),
    );
  }
}

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: AppBar(
          centerTitle: true,
          title: const Text(
            "About Us",
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => settings_pharmacy()),
              );
            }, // Navigate back to the settings screen
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
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
      ),
      body: Container(
        height: MediaQuery.of(context).size.height - kToolbarHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.5),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "About Us",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "We are a pharmacy dedicated to providing high-quality medications and services to our community. Our focus is on enhancing healthcare accessibility, delivering medications, and supporting our patients with care and attention.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                "Our Vision",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "Our vision is to make healthcare services and medication management accessible to everyone. We aim to create a seamless experience where patients, doctors, and pharmacists can connect easily through a single platform.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                "Key Services",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "• Prescription medication delivery and refills.\n"
                "• Medication counseling and advice.\n"
                "• Health checks and personalized pharmacy services.\n"
                "• Insurance processing for prescribed medications.\n"
                "• Pharmacist consultations and patient education.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                "Why Choose Our Pharmacy?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "Our pharmacy is committed to making the process of managing health and medications easier for patients. By integrating the latest technology, we ensure fast service, reliability, and safety in all our processes.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                "Our Commitment",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "We strive to provide the highest level of service and care to our patients. With a customer-first approach, we are always working to improve our services, ensuring our patients have access to the medications and healthcare services they need.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  "Thank you for trusting us with your healthcare needs!",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
