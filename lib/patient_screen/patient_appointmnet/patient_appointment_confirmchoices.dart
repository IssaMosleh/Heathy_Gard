import 'package:flutter/material.dart';
import 'package:tess/patient_screen/main.dart';
import 'package:tess/patient_screen/patient_appointmnet/patient_appointment_payment.dart';


class patient_appointment_confirmchoices extends StatelessWidget {
  const patient_appointment_confirmchoices({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ConfirmAppointmentScreen(
        location: "Shmeisani",
        service: "General Care",
        doctor: "Dr. Mohamed Jarwan",
        date: "23-10-2021",
        time: "8:00 AM - 9:00 AM",
        patient: "Othman Othman, Son",
      ),
    );
  }
}

class ConfirmAppointmentScreen extends StatelessWidget {
  final String location;
  final String service;
  final String doctor;
  final String date;
  final String time;
  final String patient;

  const ConfirmAppointmentScreen({
    super.key,
    required this.location,
    required this.service,
    required this.doctor,
    required this.date,
    required this.time,
    required this.patient,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                  Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Patient_Screen()),
                          );
              },
              icon: Image.asset('images/icon1.png'),
            )
          ],
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          title: ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds),
            child: const Text(
              "Step 4 of 4: Confirm Your Choices",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => patient_appointment_payment(doctorSpecialty: 'Dermatologist',)),
                    );
            },
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Confirm Appointment",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.5),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                    ),
                    child: Image.asset(
                      'images/hospital_image.png',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 150,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Jordan Hospital",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Divider(),
                        const SizedBox(height: 8),
                        _buildDetailItem("Location", location),
                        _buildDetailItem("Service", service),
                        _buildDetailItem("Doctor", doctor),
                        _buildDetailItem("Date", date),
                        _buildDetailItem("Time", time),
                        _buildDetailItem("Patient", patient),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: GestureDetector(
            onTap: () {
               Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Patient_Screen()),
                          );
            },
            child: Container(
              width: double.infinity,
              height: 50, // Set a minimum height for the button
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.blue, Colors.purple],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: const Center(
                child: Text(
                  "Book Now",
                  style: TextStyle(
                    fontSize: 18, // Set a readable font size
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Ensure high contrast
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title:",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Colors.blue, Colors.pink],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds),
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}