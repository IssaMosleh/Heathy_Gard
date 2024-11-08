import 'package:flutter/material.dart';
import 'package:tess/patient_screen/main.dart';
import 'package:tess/patient_screen/patient_appointmnet/patient_appointment_choosemember.dart';
import 'package:tess/patient_screen/patient_appointmnet/patient_appointment_typeofvist.dart';



class patient_appointment_introduction extends StatelessWidget {
  const patient_appointment_introduction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool activate ; // Set this value based on your activation logic

    return Scaffold(
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: 50,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.blue, Colors.purple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: MaterialButton(
          onPressed: () {
            activate=true;
            if (activate) {
              // Navigate to FamilyMemberListScreen if access is granted
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FamilyMemberListScreen(activate: true),
                ),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => patient_appointment_typeofvist(),
                ),
              );
            }
          },
          child: const Text(
            "I Agree",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          minWidth: double.infinity,
          height: 50,
        ),
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: AppBar(
          centerTitle: true,
          title: const Text(
            "Appointment Center",
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Patient_Screen()),
              );
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
                  "User Agreement",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "By booking an appointment with a doctor through this application, you agree to the following terms and conditions:",
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
                SizedBox(height: 10),
                Text(
                  "1. Eligibility:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "You must be at least 18 years old to book an appointment. If you are under 18, parental consent is required.",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                SizedBox(height: 10),
                Text(
                  "2. Appointment Confirmation:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Booking an appointment does not guarantee confirmation. You will receive a confirmation message once the appointment is approved.",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                SizedBox(height: 10),
                Text(
                  "3. Cancellations:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Appointments must be canceled at least 24 hours in advance to avoid any penalties. Repeated cancellations or no-shows may result in restricted access to future bookings.",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                SizedBox(height: 10),
                Text(
                  "4. Arrival Time:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Please arrive at least 10 minutes prior to your scheduled appointment time. Late arrivals may lead to shorter consultation times or cancellation.",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                SizedBox(height: 10),
                Text(
                  "5. Privacy and Data:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Your personal and medical information will be handled in compliance with privacy laws. By booking, you consent to data collection for the purpose of providing medical services.",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                SizedBox(height: 10),
                Text(
                  "6. Modification of Terms:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "The app reserves the right to modify these terms at any time without prior notice. Continued use of the booking services constitutes acceptance of the modified terms.",
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

// Define AccessDeniedScreen as the alternative screen if access is denied
class AccessDeniedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Access Denied"),
      ),
      body: const Center(
        child: Text(
          "Access to family members is not enabled. Please contact support.",
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
