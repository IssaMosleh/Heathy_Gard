import 'package:flutter/material.dart';
import 'package:tess/insurance_screen/Hospitals/hospital_info.dart';
import 'package:tess/insurance_screen/Hospitals/show_profile_doctor.dart';
import 'package:tess/insurance_screen/main.dart';

class doctors_insurance extends StatelessWidget {
  final String hospitalName;

  const doctors_insurance({Key? key, required this.hospitalName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SearchScreen(hospitalName: hospitalName),
    );
  }
}

class SearchScreen extends StatefulWidget {
  final String hospitalName;

  const SearchScreen({Key? key, required this.hospitalName}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, dynamic>> doctors = [
    {
      "name": "Dr. Ali Ahmad",
      "specialty": "Cardiologist",
      "inNetwork": true,
      "image": "images/doctor_image.png",
      "hospital": "Jordan Hospital"
    },
    {
      "name": "Dr. Layla Yusuf",
      "specialty": "Dermatologist",
      "inNetwork": false,
      "image": "images/doctor_image.png",
      "hospital": "Jordan Hospital"
    },
    // Add more doctors with hospital and inNetwork fields as needed
  ];

  List<Map<String, dynamic>> searchResults = [];
  String? selectedSpecialty;
  List<String> recentSearches = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    filterDoctors();
  }

  void filterDoctors() {
    setState(() {
      searchResults = doctors
          .where((doctor) =>
              doctor["inNetwork"] == true &&
              doctor["hospital"] == widget.hospitalName &&
              (selectedSpecialty == null || doctor["specialty"] == selectedSpecialty) &&
              doctor["name"]!.toLowerCase().contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  void _onSearchChanged() => filterDoctors();

  void _onSearchSubmitted(String query) {
    setState(() {
      if (recentSearches.contains(query)) recentSearches.remove(query);
      recentSearches.insert(0, query);
      if (recentSearches.length > 3) recentSearches.removeLast();
    });
    filterDoctors();
  }

  void _showSpecialtyFilterDialog() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Filter by Specialty',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        _buildSpecialtyOption('Cardiologist', setState),
                        _buildSpecialtyOption('Dermatologist', setState),
                        // Add more specialties here
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        selectedSpecialty = null;
                        Navigator.pop(context);
                        filterDoctors();
                      });
                    },
                    child: const Text('Clear Filter', style: TextStyle(color: Colors.blue)),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSpecialtyOption(String specialty, StateSetter setState) {
    return RadioListTile<String>(
      title: Text(specialty),
      value: specialty,
      groupValue: selectedSpecialty,
      onChanged: (value) {
        setState(() {
          selectedSpecialty = value;
          Navigator.pop(context);
          filterDoctors();
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "All Doctors",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HospitalStatsScreen( hospitalName: "Jordan Hospital",
      totalClaims: 120,
      approvedClaims: 90,
      rejectedClaims: 30,
      totalBookings: 200,
      totalDoctors: 50,
      totalMoneySpent: 150000.0,)),
            ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list,color: Colors.white,),
            onPressed: _showSpecialtyFilterDialog,
          ),
        ],
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search doctors",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              onSubmitted: _onSearchSubmitted,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  final doctor = searchResults[index];
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10),
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(doctor["image"] ?? ""),
                      ),
                      title: Text(doctor["name"] ?? ""),
                      subtitle: Text(doctor["specialty"] ?? ""),
                      trailing: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => show_profile_doctor(),
                            ),
                          );
                        },
                        child: const Text("Show Profile"),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => show_profile_doctor(),
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

// Placeholder screen for viewing doctor's profile
class DoctorProfileScreen extends StatelessWidget {
  final Map<String, dynamic> doctor;

  const DoctorProfileScreen({Key? key, required this.doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile of ${doctor["name"]}"),
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
      body: Center(
        child: Text("Doctor profile details go here."),
      ),
    );
  }
}
