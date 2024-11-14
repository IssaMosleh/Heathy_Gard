import 'package:flutter/material.dart';
import 'package:tess/admin_screen/delete_users/delete_profiles_main.dart';

class EditHospital_delete extends StatelessWidget {
  const EditHospital_delete({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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

  // Hospital data with an "inNetwork" field and city field
  final List<Map<String, dynamic>> hospitals = [
    {"name": "Jordan Hospital", "location": "Amman", "image": "images/hospital_image.png", "inNetwork": true, "city": "Amman"},
    {"name": "Specialty Hospital", "location": "Amman", "image": "images/hospital_image.png", "inNetwork": false, "city": "Amman"},
    // Add more hospitals as needed...
  ];

  final List<String> cities = ["All Cities", "Amman", "Zarqa", "Irbid", "Ajloun", "Karak", "Aqaba", "Madaba", "Jerash", "Salt", "Mafraq", "Tafileh", "Balqa", "Maan"];
  String selectedCity = "All Cities";
  final List<String> recentSearches = [];
  List<Map<String, dynamic>> searchResults = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _fetchAllHospitals();
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  // Fetch all hospitals based on selected city
  void _fetchAllHospitals() {
    setState(() {
      searchResults = hospitals.where((hospital) {
        return selectedCity == "All Cities" || hospital['city'] == selectedCity;
      }).toList();
    });
  }

  void _onSearchChanged() {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      setState(() {
        searchResults = hospitals
            .where((hospital) =>
                hospital["name"]!.toLowerCase().contains(query.toLowerCase()) &&
                (selectedCity == "All Cities" || hospital['city'] == selectedCity))
            .toList();
      });
    } else {
      _fetchAllHospitals();
    }
  }

  // Handle city filter selection
  void _onCitySelected(String? city) {
    setState(() {
      selectedCity = city ?? "All Cities";
      _fetchAllHospitals();
    });
  }

  // Delete a hospital from the list
  void _deleteHospital(Map<String, dynamic> hospital) {
    setState(() {
      hospitals.remove(hospital);
      searchResults.remove(hospital);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${hospital["name"]} has been deleted')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Choose Hospital",
          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const delete_profiles_main()),
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
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return ListView(
                    children: cities.map((city) {
                      return ListTile(
                        title: Text(city),
                        onTap: () {
                          Navigator.pop(context);
                          _onCitySelected(city);
                        },
                      );
                    }).toList(),
                  );
                },
              );
            },
            icon: const Icon(Icons.filter_list, color: Colors.white),
          ),
        ],
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
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  final hospital = searchResults[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 3,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              hospital["image"]!,
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteHospital(hospital),
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
