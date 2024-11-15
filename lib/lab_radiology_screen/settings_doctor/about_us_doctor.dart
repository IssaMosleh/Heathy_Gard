import 'package:flutter/material.dart';
import 'package:tess/lab_radiology_screen/settings_doctor.dart';


class about_us_doctor_LAB extends StatelessWidget {
  const about_us_doctor_LAB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
                  MaterialPageRoute(builder: (context) => settings_doctor_LAB()),
            );// Navigate back to the previous screen
            },
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
                "We are final-year Computer Engineering students at The Hashemite University, dedicated to making healthcare more accessible and efficient. Our journey led us to develop an Electronic Health System (EHS) tailored specifically to support health insurance needs in a university setting.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                "Our Vision",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "Our primary focus is on health insurance management, allowing patients, doctors, pharmacies, labs, and radiology departments to seamlessly interact within a single platform. We aim to enhance the healthcare experience by integrating digital solutions that streamline access to medical records, medication refills, lab reports, radiology images, and insurance claims.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                "Key Features",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "• Patients: Easily access personal medical records, track medication refills, view lab results, radiology images, and manage appointments.\n"
                "• Doctors: View patient history, manage prescriptions, access lab and radiology reports, and communicate with patients effectively.\n"
                "• Pharmacies: Process medication refill requests and keep track of patients' prescribed medications.\n"
                "• Laboratories: Provide patients and doctors with lab results and health reports directly within the app.\n"
                "• Radiology: Upload and manage radiology images, allowing patients and doctors to review imaging results securely.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                "Why Choose Our App?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "Our EHS application is designed with the needs of a university healthcare environment in mind. By consolidating health services and insurance management in a single platform, we hope to reduce the administrative burden and improve healthcare accessibility and efficiency.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                "Our Commitment",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "As aspiring engineers, we are committed to developing a reliable, secure, and user-friendly platform that addresses the challenges of modern healthcare. We believe in using technology to create a positive impact in healthcare, and this project is our first step toward achieving that goal.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              Center(
                child: const Text(
                  "Thank you for trusting us!",
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
