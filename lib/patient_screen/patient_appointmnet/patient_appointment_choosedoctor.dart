import 'package:flutter/material.dart';
import 'package:tess/patient_screen/mainscreenpatient.dart';
import 'package:tess/patient_screen/patient_appointmnet/patient_appointment_choosedoctor_search.dart';
import 'package:tess/patient_screen/patient_appointmnet/patient_appointment_pick_date.dart';
import 'package:tess/patient_screen/patient_appointmnet/patient_appointment_selecthospital.dart';
import 'package:tess/patient_screen/patient_appointmnet/patient_appointment_viewdoctorprofile.dart';

class patient_appointment_choosedoctor extends StatefulWidget {
  const patient_appointment_choosedoctor({super.key});

  @override
  _PatientAppointmentChooseDoctorState createState() => _PatientAppointmentChooseDoctorState();
}

class _PatientAppointmentChooseDoctorState extends State<patient_appointment_choosedoctor> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DoctorListScreen(),
    );
  }
}

class DoctorListScreen extends StatefulWidget {
  const DoctorListScreen({super.key});

  @override
  _DoctorListScreenState createState() => _DoctorListScreenState();
}

class _DoctorListScreenState extends State<DoctorListScreen> {
  final List<Map<String, String>> doctors = [
    {
      "name": "Dr. Ali Ahmad",
      "specialty": "Cardiologist",
      "image": "images/doctor_image.png" // Replace with your image path
    },
    {
      "name": "Dr. Layla Yusuf",
      "specialty": "Dermatologist",
      "image": "images/doctor_image.png" // Replace with your image path
    },
    {
      "name": "Dr. Omar Khaled",
      "specialty": "Pediatrician",
      "image": "images/doctor_image.png" // Replace with your image path
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: AppBar(
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
              "Step 3 of 4: Choose Doctor",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PatientAppointmentSelectHospital()),
        );
            },
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          ),
          actions: [
            IconButton(
              onPressed: () {
              },
              icon: IconButton(onPressed: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Patient_Screen()),
                );
              }, icon: Image.asset('images/icon1.png')),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              color: Colors.black,
              height: 1.0,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    "Most Booked Doctors",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(onPressed: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const patient_appointment_choosedoctor_search()),
                    );
                  }, icon: Image.asset("images/search.png")),
                ],
              ),
              const SizedBox(height: 4),
              const Text(
                "Find the doctor you need",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: doctors.length,
                itemBuilder: (context, index) {
                  final doctor = doctors[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 3,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              doctor["image"]!,
                              height: 150,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            doctor["name"]!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            doctor["specialty"]!,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => patient_appointment_viewdoctorprofile()),
                                  );
                                },
                                child: const Text(
                                  "View Profile",
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                   Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const patient_appointment_pick_date()),
                                    );
                                },
                                child: const Text(
                                  "Book Appointment",
                                  style: TextStyle(color: Colors.green),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
