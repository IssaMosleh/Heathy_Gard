import 'package:flutter/material.dart';
import 'package:tess/patient_screen/patient_appointmnet/patient_appointment_choosedoctor_search.dart';
import 'package:tess/patient_screen/patient_appointmnet/patient_appointment_pick_date.dart';

class patient_appointment_viewdoctorprofile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DoctorProfileScreen(),
    );
  }
}

// Doctor Model
class Doctor {
  final String name;
  final String specialty;
  final String introduction;
  final List<String> qualifications;
  final String phoneNumber;
  final String email;
  final String address;
  final Map<String, String> workingHours;

  Doctor({
    required this.name,
    required this.specialty,
    required this.introduction,
    required this.qualifications,
    required this.phoneNumber,
    required this.email,
    required this.address,
    required this.workingHours,
  });
}

// Mock Data
Doctor mockDoctor = Doctor(
  name: "Dr. Mohamed Jarwan",
  specialty: "Cardiology",
  introduction: "Dr. Mohamed Jarwan specialized in Cardiology, especially in diabetes in over 7 years. He took part in professional training courses in USA.",
  qualifications: [
    "PhD in Oncology, University of Cambridge",
    "Fellow of the Royal College of Physicians (FRCP)"
  ],
  phoneNumber: "0782933735",
  email: "deyaawork54@gmail.com",
  address: "Zarqa - Jabal Al-Shamaly",
  workingHours: {
    "Monday to Friday": "9:00 AM - 5:00 PM",
    "Saturday": "10:00 AM - 2:00 PM",
    "Sunday": "Closed"
  },
);

class DoctorProfileScreen extends StatefulWidget {
  @override
  _DoctorProfileScreenState createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  final Doctor doctor = mockDoctor; // Using mock data

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          // Smaller Header with Gradient and Profile Information
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => patient_appointment_choosedoctor_search()),
                          );
                      }, // Empty function for now
                      child: Icon(Icons.arrow_back_ios, color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 5.0),
                CircleAvatar(
                  radius: 50.0, // Reduced radius for smaller header
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 45.0,
                    backgroundImage: AssetImage('assets/doctor_image.png'),
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  doctor.name,
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 3.0),
                Text(
                  doctor.specialty,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          
          // Main Content with White Background
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.0),
                    _buildSectionTitle('Introduction'),
                    Text(
                      doctor.introduction,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 20.0),
                    _buildSectionTitle('Qualifications'),
                    for (var qualification in doctor.qualifications)
                      _buildBulletPoint(qualification),
                    SizedBox(height: 20.0),
                    _buildSectionTitle('Contact Information'),
                    _buildBulletPoint('Phone Number: ${doctor.phoneNumber}'),
                    _buildBulletPoint('Email: ${doctor.email}'),
                    _buildBulletPoint('Office Address: ${doctor.address}'),
                    SizedBox(height: 20.0),
                    _buildSectionTitle('Working Hours'),
                    for (var entry in doctor.workingHours.entries)
                      _buildBulletPoint('${entry.key}: ${entry.value}'),
                    SizedBox(height: 30.0),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 60.0,
          child: Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 100.0, vertical: 12.0),
                backgroundColor: Colors.blueAccent,
              ),
              onPressed: () {
                Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => patient_appointment_pick_date()),
                          );
              },
              child: Text(
                'continue',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('•', style: TextStyle(fontSize: 18.0)),
          SizedBox(width: 8.0),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }
}