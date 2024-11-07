import 'package:flutter/material.dart';
import 'package:tess/doctor_screen/main.dart';
import 'package:tess/doctor_screen/patient_portal/patient_portal_date_picker.dart';
import 'package:tess/doctor_screen/patient_portal/patient_portal_labs.dart';
import 'package:tess/doctor_screen/patient_portal/patient_portal_show_doctor_profile.dart';

class patient_portal_tansfer_to_another_doctor extends StatelessWidget {
  const patient_portal_tansfer_to_another_doctor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SearchScreen(),
    );
  }
}

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  // Sample doctor data; replace with your database data if needed
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
  
  final List<String> recentSearches = [];
  List<Map<String, String>> searchResults = [];

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
    // Replace this with your actual database fetching logic
    setState(() {
      searchResults = doctors;
    });
  }

  void _onSearchChanged() {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      setState(() {
        searchResults = doctors
            .where((doctor) =>
                doctor["name"]!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    } else {
      setState(() {
        searchResults = doctors; // Show all if query is empty
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

  void _onViewProfileTap(Map<String, String> doctor) {
    // Handle the View Profile action here
    Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => patient_portal_show_doctor_profile()),);
  }

  void _onBookAppointmentTap(Map<String, String> doctor) {
    Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const patient_portal_date_picker()),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => patient_portal_labs()),);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          color: Colors.white,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Doctor_Screen()),);
            },
            icon: Image.asset('images/icon1.png'),
            color: Colors.white,
          )
        ],
        title: Center(
          child: Text(
            'Choose Doctor',
            style: TextStyle(color: Colors.white),
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
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
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                    onSubmitted: _onSearchSubmitted,
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () {
                    // Define action for the icon button here
                    print("Icon button tapped");
                  },
                  icon: const Icon(Icons.search),
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
                                onPressed: () => _onViewProfileTap(doctor),
                                child: const Text(
                                  "View Profile",
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                              TextButton(
                                onPressed: () => _onBookAppointmentTap(doctor),
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
