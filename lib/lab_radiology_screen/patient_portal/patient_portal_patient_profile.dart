import 'package:flutter/material.dart';
import 'package:tess/lab_radiology_screen/main.dart';
import 'package:tess/lab_radiology_screen/patient_portal/patient_portal_patient_profile_history.dart';
import 'package:tess/lab_radiology_screen/patient_portal/patient_portal_patient_profile_write_prescription.dart';
import 'package:tess/lab_radiology_screen/patient_portal/patient_portal_patients.dart';


void main() {
  runApp(const patient_portal_patient_profile_LAB());
}

class patient_portal_patient_profile_LAB extends StatelessWidget {
  const patient_portal_patient_profile_LAB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Patient Profile',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color(0xFFF6F6F6), // Light grey background
      ),
      home: const PatientProfileScreen(),
    );
  }
}

class PatientProfileScreen extends StatefulWidget {
  const PatientProfileScreen({Key? key}) : super(key: key);

  @override
  _PatientProfileScreenState createState() => _PatientProfileScreenState();
}

class _PatientProfileScreenState extends State<PatientProfileScreen> {
  // Simulating a dynamic patient name coming from a database
  String patientName =
      "Mohamed Jarwan"; // Replace with actual data from a database in the future

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Doctor_LAB()),
              );
            },
            icon: Image.asset('images/icon1.png', color: Colors.white),
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const patient_portal_patients_LAB()),
            );
          },
        ),
        title: const Text(
          'Patient Profile',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.deepPurple,
                Colors.indigo
              ], // Cool gradient color for AppBar
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 40, bottom: 20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.deepPurple, Colors.indigo], // Purple gradient
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 46,
                    backgroundImage: NetworkImage(
                        'https://via.placeholder.com/150'), // Replace with actual image URL
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  patientName, // Dynamic patient name
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              children: [
                _buildGradientButton(context, 'History', onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const patient_portal_patient_profile_history_LAB()),
                  );
                }),
                const SizedBox(height: 20),
                _buildGradientButton(context, 'Upload Lab/Radiology',
                    onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            patient_portal_patient_profile_write_prescription_LAB(patientData: {
                              'patientName': 'John Doe',
                              'doctorName': 'Dr. Sarah Ahmed',
                              'visitDate': '2024-11-05',
                              'doctorSpecialty': 'Lab',
                            },
                            )),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradientButton(BuildContext context, String text,
      {required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Colors.deepPurple,
              Colors.indigo
            ], // Purple gradient for buttons
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
