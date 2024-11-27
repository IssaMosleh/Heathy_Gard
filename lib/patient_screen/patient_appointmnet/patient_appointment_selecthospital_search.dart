import 'package:flutter/material.dart';
import 'package:tess/patient_screen/mainscreenpatient.dart';
import 'package:tess/patient_screen/patient_appointmnet/patient_appointment_choosedoctor.dart';
import 'package:tess/patient_screen/patient_appointmnet/patient_appointment_selecthospital.dart';


class patient_appointment_selecthospital_search extends StatelessWidget {
  const patient_appointment_selecthospital_search({super.key});

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
  // Simulate dynamic data; replace this with data fetched from your database
    final List<Map<String, String>> hospitals = [
    {"name": "Jordan Hospital", "location": "Amman", "image": "images/hospital_image.png"},
    {"name": "Specialty Hospital", "location": "Amman", "image": "images/hospital_image.png"},
    {"name": "Al Khalidi Hospital", "location": "Jabal Amman", "image": "images/hospital_image.png"},
    {"name": "Zarqa Governmental Hospital", "location": "Zarqa", "image": "images/hospital_image.png"},
    {"name": "King Abdullah University Hospital", "location": "Irbid", "image": "images/hospital_image.png"},
    {"name": "Ajloun Governmental Hospital", "location": "Ajloun", "image": "images/hospital_image.png"},
    {"name": "Al Karak Hospital", "location": "Karak", "image": "images/hospital_image.png"},
    {"name": "Aqaba Hospital", "location": "Aqaba", "image": "images/hospital_image.png"},
    {"name": "Madaba Governmental Hospital", "location": "Madaba", "image": "images/hospital_image.png"},
    {"name": "Jerash Hospital", "location": "Jerash", "image": "images/hospital_image.png"},
    {"name": "Salt Hospital", "location": "Salt", "image": "images/hospital_image.png"},
    {"name": "Mafraq Hospital", "location": "Mafraq", "image": "images/hospital_image.png"},
  ];

  final List<String> recentSearches = [];
  List<Map<String, String>> searchResults = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    // Simulate fetching data from a database on load
    _fetchHospitals();
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _fetchHospitals() {
    // Replace this with your actual database fetching logic
    setState(() {
      searchResults = hospitals;
    });
  }

  void _onSearchChanged() {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      setState(() {
        searchResults = hospitals
            .where((hospital) =>
                hospital["name"]!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    } else {
      setState(() {
        searchResults = hospitals; // Show all if query is empty
      });
    }
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

  void _onRecentSearchTapped(String query) {
    _searchController.text = query;
    _onSearchSubmitted(query);
  }

  void _onCardTap(Map<String, String> hospital) {
    Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const patient_appointment_choosedoctor()),
        );
    print("Tapped on ${hospital['name']}");
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
              "step 2 of 4: Choose Hospital",
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
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search",
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
                    onTap: () => _onRecentSearchTapped(search),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8.0),
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
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
                  final hospital = searchResults[index];
                  return GestureDetector(
                    onTap: () => _onCardTap(hospital),
                    child: Card(
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
                                hospital["image"]!,
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              hospital["name"]!,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              hospital["location"]!,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
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