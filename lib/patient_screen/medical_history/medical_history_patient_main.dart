import 'package:flutter/material.dart';
import 'package:tess/patient_screen/main.dart';
import 'package:tess/patient_screen/medical_history/medical_history_patient_history.dart';
import 'package:tess/patient_screen/medical_history/medical_history_patient_lab.dart';
import 'package:tess/patient_screen/medical_history/medical_history_patient_personal.dart';
import 'package:tess/patient_screen/medical_history/medical_history_patient_radiology.dart';

class medical_history_patient_main extends StatelessWidget {
  const medical_history_patient_main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MedicalRecordScreen(),
    );
  }
}

class MedicalRecordScreen extends StatefulWidget {
  const MedicalRecordScreen({Key? key}) : super(key: key);

  @override
  _MedicalRecordScreenState createState() => _MedicalRecordScreenState();
}

class _MedicalRecordScreenState extends State<MedicalRecordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: AppBar(
          centerTitle: true,
          title: const Text(
            "Medical Record",
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            onPressed: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Patient_Screen()),
                    );            },
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
        color: Colors.grey[200],
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildOptionCard(
              imagePath: 'images/personalinfo.png',
              title: "Personal Information",
              description: "View chronic conditions, surgeries, and other details",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => medical_history_patient_personal()),
                    );         
              },
            ),
            _buildOptionCard(
              imagePath: 'images/history.png',
              title: "History",
              description: "Review past medical history",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => medical_history_patient_history()),
                    );         
              },
            ),
            _buildOptionCard(
              imagePath: 'images/labreports.png',
              title: "Lab Reports",
              description: "Access lab test results",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => medical_history_patient_lab()),
                    );         
              },
            ),
            _buildOptionCard(
              imagePath: 'images/radiology.png',
              title: "Radiology",
              description: "Check radiology images and reports",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => medical_history_patient_radiology()),
                    );         
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard({
    required String imagePath,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
