import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tess/doctor_screen/mainscreendoctor.dart';
import 'package:tess/doctor_screen/patient_portal/patient_portal_Introduction.dart';
import 'package:tess/doctor_screen/patient_portal/patient_portal_patient_profile.dart';

class patient_portal_patients extends StatelessWidget {
  const patient_portal_patients({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Choose Your Patient",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ChoosePatientScreen(),
    );
  }
}

// Model for patient data
class Patient {
  final String name;
  final String date;
  final String time;
  final String imageUrl;

  Patient({required this.name, required this.date, required this.time, required this.imageUrl});
}

class ChoosePatientScreen extends StatefulWidget {
  const ChoosePatientScreen({super.key});

  @override
  _ChoosePatientScreenState createState() => _ChoosePatientScreenState();
}

class _ChoosePatientScreenState extends State<ChoosePatientScreen> {
  // Dynamic list of patients with updated dates starting from today
  List<Patient> patients = [];
  List<Patient> filteredPatients = [];
  TextEditingController searchController = TextEditingController();
  bool showTodayOnly = true;

  @override
  void initState() {
    super.initState();
    _initializeAppointments();
    _filterTodayAppointments();
    searchController.addListener(_filterPatients);
  }

  void _initializeAppointments() {
    final today = DateTime.now();
    final dateFormat = DateFormat('dd/MM/yyyy');

    // Set up appointments starting from today
    patients = [
      Patient(name: "Malek Salem", date: dateFormat.format(today), time: "8:00 AM", imageUrl: "https://via.placeholder.com/100"),
      Patient(name: "Nadia Noor", date: dateFormat.format(today.add(const Duration(days: 1))), time: "10:00 AM", imageUrl: "https://via.placeholder.com/100"),
      Patient(name: "Ahmad Ali", date: dateFormat.format(today.add(const Duration(days: 2))), time: "1:00 PM", imageUrl: "https://via.placeholder.com/100"),
      Patient(name: "Sara Khan", date: dateFormat.format(today.add(const Duration(days: 3))), time: "3:00 PM", imageUrl: "https://via.placeholder.com/100"),
      Patient(name: "John Doe", date: dateFormat.format(today.add(const Duration(days: 4))), time: "9:00 AM", imageUrl: "https://via.placeholder.com/100"),
      Patient(name: "Jane Smith", date: dateFormat.format(today.add(const Duration(days: 5))), time: "11:00 AM", imageUrl: "https://via.placeholder.com/100"),
      Patient(name: "Alex Brown", date: dateFormat.format(today.add(const Duration(days: 6))), time: "2:00 PM", imageUrl: "https://via.placeholder.com/100"),
      Patient(name: "Emily Green", date: dateFormat.format(today.add(const Duration(days: 7))), time: "4:00 PM", imageUrl: "https://via.placeholder.com/100"),
    ];
  }

  void _filterTodayAppointments() {
    final today = DateFormat('dd/MM/yyyy').format(DateTime.now());
    setState(() {
      filteredPatients = patients.where((patient) => patient.date == today).toList();
    });
  }

  void _showAllAppointments() {
    setState(() {
      filteredPatients = patients;
      showTodayOnly = false;
    });
  }

  void _filterPatients() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredPatients = (showTodayOnly ? patients.where((patient) {
        final today = DateFormat('dd/MM/yyyy').format(DateTime.now());
        return patient.date == today;
      }) : patients).where((patient) {
        return patient.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    searchController.removeListener(_filterPatients);
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Doctor_Screen()),
            );
          }, icon: Image.asset('images/icon1.png', color: Colors.white,))
        ],
        centerTitle: true,
        title: const Text("Choose Your Patient", style: TextStyle(color: Colors.white),),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const patient_portal_Introduction()),
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search patients by name",
                prefixIcon: const Icon(Icons.search),
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: () {
                if (showTodayOnly) {
                  _showAllAppointments();
                } else {
                  _filterTodayAppointments();
                  showTodayOnly = true;
                }
              },
              child: Text(showTodayOnly ? "Show All Appointments for the Week" : "Show Today's Appointments"),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: filteredPatients.length, // Number of cards based on dynamic data
              itemBuilder: (context, index) {
                final patient = filteredPatients[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const patient_portal_patient_profile()),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Circular container for the profile image
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.blueAccent, width: 2),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network(
                                  patient.imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Name: ${patient.name}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Date: ${patient.date}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Time: ${patient.time}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
