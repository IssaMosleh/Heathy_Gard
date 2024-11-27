import 'package:flutter/material.dart';
import 'package:tess/admin_screen/edit_profiles/doctor/doctor_insurance_showdetails.dart';
import 'package:tess/admin_screen/edit_profiles/edit_profiles_main.dart';

class Doctor {
  final String id;
  final String name;
  final String specialty;
  final String imageUrl;

  Doctor({required this.id, required this.name, required this.specialty, required this.imageUrl});
}

class DoctorSearchScreen extends StatefulWidget {
  const DoctorSearchScreen({super.key});

  @override
  _DoctorSearchScreenState createState() => _DoctorSearchScreenState();
}

class _DoctorSearchScreenState extends State<DoctorSearchScreen> {
  List<Doctor> doctors = [
    Doctor(id: 'D001', name: 'Dr. John Doe', specialty: 'Cardiology', imageUrl: 'https://via.placeholder.com/150'),
    Doctor(id: 'D002', name: 'Dr. Jane Smith', specialty: 'Neurology', imageUrl: 'https://via.placeholder.com/150'),
    Doctor(id: 'D003', name: 'Dr. Alice Johnson', specialty: 'Pediatrics', imageUrl: 'https://via.placeholder.com/150'),
  ];

  String searchQuery = '';
  String selectedSpecialty = 'All';

  @override
  Widget build(BuildContext context) {
    List<Doctor> filteredDoctors = doctors
        .where((doctor) =>
            (searchQuery.isEmpty ||
                doctor.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
                doctor.id.contains(searchQuery)) &&
            (selectedSpecialty == 'All' || doctor.specialty == selectedSpecialty))
        .toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const edit_profiles_main()),
            );
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: const Text(
          "Search Doctors",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search bar
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: const LinearGradient(
                  colors: [Colors.blue, Colors.purple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: TextField(
                onChanged: (query) {
                  setState(() {
                    searchQuery = query;
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.9),
                  labelText: 'Search by name or ID',
                  labelStyle: TextStyle(color: Colors.blueGrey[800]),
                  prefixIcon: const Icon(Icons.search, color: Colors.blue),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Filter dropdown for specialty
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: const LinearGradient(
                  colors: [Colors.blue, Colors.purple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: DropdownButtonFormField<String>(
                value: selectedSpecialty,
                onChanged: (value) {
                  setState(() {
                    selectedSpecialty = value!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Filter by Specialty',
                  labelStyle: TextStyle(color: Colors.blueGrey[800]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.9),
                ),
                items: ['All', 'Cardiology', 'Neurology', 'Pediatrics']
                    .map((specialty) => DropdownMenuItem(
                          value: specialty,
                          child: Text(
                            specialty,
                            style: const TextStyle(color: Colors.blue),
                          ),
                        ))
                    .toList(),
              ),
            ),
            const SizedBox(height: 16),

            // List of doctor cards with navigation
            Expanded(
              child: ListView.builder(
                itemCount: filteredDoctors.length,
                itemBuilder: (context, index) {
                  final doctor = filteredDoctors[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(doctor.imageUrl),
                        radius: 30,
                      ),
                      title: Text(
                        doctor.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ID: ${doctor.id}',
                            style: TextStyle(
                              color: Colors.blueGrey[800],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Specialty: ${doctor.specialty}',
                            style: TextStyle(
                              color: Colors.blueGrey[800],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.blueGrey[800],
                        size: 16,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const doctor_insurance_showdetails(),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
