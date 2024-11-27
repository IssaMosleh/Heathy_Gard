import 'package:flutter/material.dart';
import 'package:tess/insurance_screen/Patients/view_patient_profile.dart';
import 'package:tess/insurance_screen/maininsurancescreen.dart';

class PatientsInsurance extends StatelessWidget {
  final String insuranceName;

  const PatientsInsurance({super.key, required this.insuranceName});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SearchScreen(insuranceName: insuranceName),
    );
  }
}

class SearchScreen extends StatefulWidget {
  final String insuranceName;

  const SearchScreen({super.key, required this.insuranceName});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, dynamic>> patients = [
    {
      "id": "PT001",
      "name": "John Doe",
      "image": "images/patient_image.png",
      "insurance": "HealthFirst"
    },
    {
      "id": "PT002",
      "name": "Alice Smith",
      "image": "images/patient_image.png",
      "insurance": "HealthFirst"
    },
    {
      "id": "PT003",
      "name": "Michael Johnson",
      "image": "images/patient_image.png",
      "insurance": "HealthPlus"
    },
    // Add more patients as needed
  ];

  List<Map<String, dynamic>> searchResults = [];
  List<String> recentSearches = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    filterPatients();
  }

  void filterPatients() {
    setState(() {
      searchResults = patients
          .where((patient) =>
              patient["insurance"] == widget.insuranceName &&
              (patient["name"]!.toLowerCase().contains(_searchController.text.toLowerCase()) ||
               patient["id"]!.toLowerCase().contains(_searchController.text.toLowerCase())))
          .toList();
    });
  }

  void _onSearchChanged() => filterPatients();

  void _onSearchSubmitted(String query) {
    setState(() {
      if (recentSearches.contains(query)) recentSearches.remove(query);
      recentSearches.insert(0, query);
      if (recentSearches.length > 3) recentSearches.removeLast();
    });
    filterPatients();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Insurance Patients",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () =>  Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const InsuranceRep_Screen()),
        ),
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search by patient name or ID",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                prefixIcon: const Icon(Icons.search),
              ),
              onSubmitted: _onSearchSubmitted,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  final patient = searchResults[index];
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10),
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(patient["image"] ?? ""),
                      ),
                      title: Text(patient["name"] ?? ""),
                      subtitle: Text("ID: ${patient["id"]}"),
                      trailing: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PatientInsurance(),
                            ),
                          );
                        },
                        child: const Text("View Profile"),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PatientInsurance(),
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

// Placeholder screen for viewing patient's profile
class PatientProfileScreen extends StatelessWidget {
  final Map<String, dynamic> patient;

  const PatientProfileScreen({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile of ${patient["name"]}"),
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
        child: Text("Details for ${patient["name"]} with ID ${patient["id"]} go here."),
      ),
    );
  }
}
