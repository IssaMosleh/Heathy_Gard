import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tess/doctor_screen/accepted_appointments/accepted_appointments.dart';
import 'package:tess/doctor_screen/appointment_doctor.dart';
import 'package:tess/doctor_screen/history/history_visits.dart';
import 'package:tess/doctor_screen/money/DoctorMoneyScreen.dart';
import 'package:tess/doctor_screen/my_hospital/my_hospital.dart';
import 'package:tess/doctor_screen/my_info/my_info_doctor.dart';
import 'package:tess/doctor_screen/notification_doctor.dart';
import 'package:tess/doctor_screen/patient_portal/patient_portal_Introduction.dart';
import 'package:tess/doctor_screen/settings_doctor.dart'; // Import for date formatting

void main() {
  runApp(const Doctor_Screen());
}

class Doctor_Screen extends StatefulWidget {
  const Doctor_Screen({Key? key}) : super(key: key);

  @override
  State<Doctor_Screen> createState() => _MainAppState();
}

class _MainAppState extends State<Doctor_Screen> {
  final double imageSize = 50.0; // Fixed image size for icons
  final double fontSize = 12.0; // Fixed font size for text labels
  final List<String> labels = [
    "My Hospitals",
    "Accepted Appointments",
    "My Info",
    "Patient Portal",
    "History",
    "Money",
  ];

  final List<String> images = [
    "images/Insurance.png",
    "images/appointment.png",
    "images/MedicalRecord.png",
    "images/PatientPortal.png",
    "images/history.png",
    "images/Claims.png",
  ];

  // Sample dynamic appointment data for cards
  final List<Map<String, String>> appointments = [
    {
      'doctorName': 'Ali Ahmed',
      'date': '2024-12-01',
      'time': '10:00 AM',
      'imagePath': 'images/patient1.jpg', // Path to the doctor's image
    },
    {
      'doctorName': 'Sara Khalil',
      'date': '2024-11-20',
      'time': '1:30 PM',
      'imagePath': 'images/patient2.jpg',
    },
    {
      'doctorName': 'John Smith',
      'date': '2024-11-15',
      'time': '9:00 AM',
      'imagePath': 'images/DoctorJohn.jpg',
    },
    {
      'doctorName': 'Fatima Noor',
      'date': '2024-11-10',
      'time': '3:00 PM',
      'imagePath': 'images/DoctorFatima.jpg',
    },
    {
      'doctorName': 'Omar Yasin',
      'date': '2024-12-05',
      'time': '8:00 AM',
      'imagePath': 'images/DoctorOmar.jpg',
    },
  ];

  // Define a date formatter
  final DateFormat dateFormat = DateFormat('MMM d, yyyy');

  // Function to handle onTap events with context
  void handleOnTap(String label, BuildContext context) {
    switch (label) {
      case "My Hospitals":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MyHospital()),
        );
        break;
      case "Accepted Appointments":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AcceptedAppointment()),
        );
        break;
      case "My Info":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const My_Info_Doctor()),
        );
        break;
      case "Patient Portal":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => patient_portal_Introduction()),
        );
        break;
      case "History":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => history_visits()),
        );
        break;
      case "Money":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DoctorMoneyScreen()),
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
                offset: Offset(0, 3),
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
                MaterialPageRoute(builder: (context) => Doctor_Screen()),
            );
                },
                icon: Image.asset('images/icon1.png', width: 30, height: 30),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => appointment_doctor()),
            );
                },
                icon: Image.asset('images/icon2.png', width: 30, height: 30),
              ),
              IconButton(
                onPressed: () {Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => notification_doctor()),
            );},
                icon: Image.asset('images/icon3.png', width: 30, height: 30),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => settings_doctor()),
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
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage("images/person.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "Hi Dr. Deyya,",
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
                                constraints: BoxConstraints(maxWidth: 500),
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
                                              child: Builder(
                                                builder: (BuildContext innerContext) {
                                                  return InkWell(
                                                    onTap: () => handleOnTap(
                                                        labels[(row * 3) + col], innerContext),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Container(
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
                                                  );
                                                },
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
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      constraints: BoxConstraints(maxWidth: 500),
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
                            "Incoming Appointments",
                            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: appointments.map((appointment) {
                                DateTime appointmentDate = DateTime.parse(appointment['date']!);
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
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(8.0),
                                          child: Image.asset(
                                            appointment['imagePath']!,
                                            height: 80,
                                            width: 120,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        Text(
                                          appointment['doctorName']!,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue[700],
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          "Date: ${dateFormat.format(appointmentDate)}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[800],
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          "Time: ${appointment['time']}",
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
