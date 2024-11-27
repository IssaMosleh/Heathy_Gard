import 'package:flutter/material.dart';
import 'package:tess/patient_screen/mainscreenpatient.dart';
import 'package:tess/patient_screen/patient_appointmnet/patient_appointment_choosedoctor.dart';
import 'package:tess/patient_screen/patient_appointmnet/patient_appointment_pick_date.dart';
import 'package:tess/patient_screen/patient_appointmnet/patient_appointment_viewdoctorprofile.dart';

class patient_appointment_choosedoctor_search extends StatelessWidget {
  const patient_appointment_choosedoctor_search({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SearchScreen(),
    );
  }
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> doctors = [
    {
      "name": "Dr. Ali Ahmad",
      "specialty": "Cardiologist",
      "image": "images/doctor_image.png"
    },
    {
      "name": "Dr. Layla Yusuf",
      "specialty": "Dermatologist",
      "image": "images/doctor_image.png"
    },
    {
      "name": "Dr. Omar Khaled",
      "specialty": "Pediatrician",
      "image": "images/doctor_image.png"
    },
    {
      "name": "Dr. Sara Hassan",
      "specialty": "Orthopedic",
      "image": "images/doctor_image.png"
    },
    {
      "name": "Dr. Kamal Ali",
      "specialty": "Neurologist",
      "image": "images/doctor_image.png"
    },
    {
      "name": "Dr. Fatima Noor",
      "specialty": "Oncologist",
      "image": "images/doctor_image.png"
    },
    {
      "name": "Dr. Hani Saeed",
      "specialty": "Gastroenterologist",
      "image": "images/doctor_image.png"
    },
    {
      "name": "Dr. Rana Fares",
      "specialty": "Endocrinologist",
      "image": "images/doctor_image.png"
    },
    {
      "name": "Dr. Majed Zain",
      "specialty": "Urologist",
      "image": "images/doctor_image.png"
    },
    {
      "name": "Dr. Nadia Osman",
      "specialty": "Pulmonologist",
      "image": "images/doctor_image.png"
    },
  ];

  final List<String> recentSearches = [];
  List<Map<String, String>> searchResults = [];
  String? selectedSpecialty;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _fetchDoctors();
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _fetchDoctors() {
    setState(() {
      searchResults = doctors;
    });
  }

  void _onSearchChanged() {
    final query = _searchController.text;
    setState(() {
      searchResults = doctors
          .where((doctor) =>
              doctor["name"]!.toLowerCase().contains(query.toLowerCase()) &&
              (selectedSpecialty == null ||
                  doctor["specialty"] == selectedSpecialty))
          .toList();
    });
  }

  void _onSearchSubmitted(String query) {
    if (query.isNotEmpty) {
      setState(() {
        if (recentSearches.contains(query)) {
          recentSearches.remove(query);
        }
        recentSearches.insert(0, query);
        if (recentSearches.length > 3) {
          recentSearches.removeLast();
        }
      });
      _onSearchChanged();
    }
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.grey.shade100],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Filter by Specialty',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          _buildSpecialtyOption('Cardiologist', Icons.favorite, setState),
                          _buildSpecialtyOption('Dermatologist', Icons.brush, setState),
                          _buildSpecialtyOption('Pediatrician', Icons.child_care, setState),
                          _buildSpecialtyOption('Orthopedic', Icons.accessibility, setState),
                          _buildSpecialtyOption('Neurologist', Icons.psychology, setState),
                          _buildSpecialtyOption('Oncologist', Icons.healing, setState),
                          _buildSpecialtyOption('Gastroenterologist', Icons.restaurant, setState),
                          _buildSpecialtyOption('Endocrinologist', Icons.opacity, setState),
                          _buildSpecialtyOption('Urologist', Icons.wc, setState),
                          _buildSpecialtyOption('Pulmonologist', Icons.air, setState),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        selectedSpecialty = null;
                        Navigator.pop(context);
                        _onSearchChanged();
                      });
                    },
                    child: const Text(
                      'Clear Filter',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSpecialtyOption(String specialty, IconData icon, StateSetter setState) {
    return RadioListTile<String>(
      title: Row(
        children: [
          Icon(icon, color: Colors.blueAccent),
          const SizedBox(width: 10),
          Text(
            specialty,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
        ],
      ),
      value: specialty,
      groupValue: selectedSpecialty,
      activeColor: Colors.blueAccent,
      onChanged: (value) {
        setState(() {
          selectedSpecialty = value;
          Navigator.pop(context);
          _onSearchChanged();
        });
      },
    );
  }

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
              "Step 2 of 4: Choose Doctor",
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
                MaterialPageRoute(
                    builder: (context) => const patient_appointment_choosedoctor()),
              );
            },
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Patient_Screen()),
                );
              },
              icon: Image.asset('images/icon1.png'),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Search doctors",
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.blue.shade200),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.blue),
                      ),
                    ),
                    onSubmitted: _onSearchSubmitted,
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: _showFilterDialog,
                  icon: const Icon(Icons.filter_list),
                  color: Colors.blue,
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              "Recently Searched",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: recentSearches.map((search) {
                  return GestureDetector(
                    onTap: () => _onSearchSubmitted(search),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8.0),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.blue, Colors.purple],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        search,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const Divider(color: Colors.grey),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  final doctor = searchResults[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 3,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
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
            ),
          ],
        ),
      ),
    );
  }
}
