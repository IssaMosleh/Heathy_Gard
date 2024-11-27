import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tess/patient_screen/appointment_main_patient.dart';
import 'package:tess/patient_screen/claim_screen/claim_patient_infroduction.dart';
import 'package:tess/patient_screen/family_members/family_members.dart';
import 'package:tess/patient_screen/medical_history/medical_history_patient_main.dart';
import 'package:tess/patient_screen/medication_patient/medication_patient_main.dart';
import 'package:tess/patient_screen/notification_patient.dart';
import 'package:tess/patient_screen/patient_appointmnet/patient_appointment_introduction.dart';
import 'package:tess/patient_screen/patient_insurance/patient_insurance.dart';
import 'package:tess/patient_screen/settings_patient.dart';


class Patient_Screen extends StatefulWidget {
  const Patient_Screen({super.key});

  @override
  State<Patient_Screen> createState() => _MainAppState();
}

class _MainAppState extends State<Patient_Screen> {
  final double imageSize = 50.0; // Fixed image size for icons
  final double fontSize = 12.0; // Fixed font size for text labels
  final List<String> labels = [
    "Insurance",
    "Appointment",
    "Medical Record",
    "Family Members",
    "Medication",
    "Claims",
  ];

  final List<String> images = [
    "images/Insurance.png",
    "images/appointment.png",
    "images/MedicalRecord.png",
    "images/FamilyMembers.png",
    "images/Medications.png",
    "images/Claims.png",
  ];

  // Sample dynamic medicine data for cards
  final List<Map<String, String>> medicines = [
    {
      'name': 'Aspirin',
      'dosage': '1x daily',
      'endDate': '2024-12-31',
      'imagePath': 'images/Aspirin.jpg', // Path to the medicine image
    },
    {
      'name': 'Ibuprofen',
      'dosage': '2x daily',
      'endDate': '2024-11-15',
      'imagePath': 'images/Ibuprofen.jpg',
    },
    {
      'name': 'Vitamin C',
      'dosage': '1x daily',
      'endDate': '2024-10-20',
      'imagePath': 'images/VitamenC.jpg',
    },
    {
      'name': 'Antibiotic',
      'dosage': '3x daily',
      'endDate': '2024-10-30',
      'imagePath': 'images/antibiotic.png',
    },
    {
      'name': 'Pain Relief',
      'dosage': '1x at night',
      'endDate': '2025-01-01',
      'imagePath': 'images/pain_relief.png',
    },
  ];

  // Define a date formatter
  final DateFormat dateFormat = DateFormat('MMM d, yyyy');

  // Function to handle onTap events
  void handleOnTap(String label) {
    switch (label) {
      case "Insurance":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const patient_insurance()),
        );
        break;
      case "Appointment":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const patient_appointment_introduction()),
        );
        break;
      case "Medical Record":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const medical_history_patient_main()),
        );
        break;
      case "Family Members":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const family_members()),
        );
        break;
      case "Medication":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const medication_patient_main()),
        );
        break;
      case "Claims":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const claim_patient_infroduction()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          margin: const EdgeInsets.symmetric(horizontal: 32.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                   Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Patient_Screen()),
                    );         
                },
                icon: Image.asset('images/icon1.png', width: 30, height: 30),
              ),
              IconButton(
                onPressed: () {
                   Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const appointment_main_patient()),
                    );         
                },
                icon: Image.asset('images/icon2.png', width: 30, height: 30),
              ),
              IconButton(
                onPressed: () {
                   Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const notification_patient()),
                    );         
                },
                icon: Image.asset('images/icon3.png', width: 30, height: 30),
              ),
              IconButton(
                onPressed: () {
                   Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const settings_patient()),
                    );         
                },
                icon: Image.asset('images/icon4.png', width: 30, height: 30),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Positioned.fill(
                        child: Image.asset(
                          "images/Vector2.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16.0, 60.0, 16.0, 20.0),
                            child: Row(
                              children: [
                                Container(
                                  height: 75, // Profile image size
                                  width: 75,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage("images/person.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Hi Deyya,",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      "Welcome back!",
                                      style: TextStyle(
                                        color: Color.fromARGB(207, 255, 255, 255),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Container(
                                constraints: const BoxConstraints(maxWidth: 500),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(24.0),
                                  border: Border.all(color: Colors.grey[300]!, width: 1),
                                ),
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: [
                                    for (int row = 0; row < 2; row++) ...[
                                      if (row > 0)
                                        const Divider(color: Colors.grey, thickness: 1),
                                      Row(
                                        children: [
                                          for (int col = 0; col < 3; col++) ...[
                                            if (col > 0)
                                              Container(
                                                width: 1,
                                                color: Colors.grey[300],
                                                height: 80,
                                              ),
                                            Expanded(
                                              child: InkWell(
                                                onTap: () => handleOnTap(labels[(row * 3) + col]),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      height: imageSize,
                                                      width: imageSize,
                                                      child: Image.asset(
                                                        images[(row * 3) + col],
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 6),
                                                    Text(
                                                      labels[(row * 3) + col],
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: fontSize,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 500),
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(color: Colors.grey[300]!, width: 1),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Latest News",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  constraints: const BoxConstraints(maxHeight: 30, maxWidth: 30),
                                  decoration: const BoxDecoration(shape: BoxShape.circle),
                                  child: Center(
                                    child: Image.asset(
                                      "images/info.png",
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Expanded(
                                  child: Text(
                                    "A new Health Insurance Application has launched in Jordan, be ready for a better health experience.",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      constraints: const BoxConstraints(maxWidth: 500),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24.0),
                        border: Border.all(color: Colors.grey[300]!, width: 1),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Active Medicines",
                            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: medicines.map((medicine) {
                                DateTime endDate = DateTime.parse(medicine['endDate']!);
                                return Padding(
                                  padding: const EdgeInsets.only(right: 12.0),
                                  child: Container(
                                    width: 150,
                                    padding: const EdgeInsets.all(12.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.1),
                                          spreadRadius: 2,
                                          blurRadius: 6,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                      border: Border.all(color: Colors.grey[300]!, width: 1),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          medicine['imagePath']!,
                                          height: 60,
                                          width: 60,
                                          fit: BoxFit.contain,
                                        ),
                                        const SizedBox(height: 12),
                                        Text(
                                          medicine['name']!,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue[700],
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          medicine['dosage']!,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[800],
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          "End: ${dateFormat.format(endDate)}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
