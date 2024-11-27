import 'package:flutter/material.dart';
import 'package:tess/admin_screen/edit_profiles/edit_profiles_main.dart';
import 'package:tess/admin_screen/edit_profiles/hospital/hospital_show_details.dart';

class EditHospital extends StatelessWidget {
  const EditHospital({super.key});

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

  // Hospital data with an "inNetwork" field and city field
  final List<Map<String, dynamic>> hospitals = [
    {"name": "Jordan Hospital", "location": "Amman", "image": "images/hospital_image.png", "inNetwork": true, "city": "Amman"},
    {"name": "Specialty Hospital", "location": "Amman", "image": "images/hospital_image.png", "inNetwork": false, "city": "Amman"},
    {"name": "Al Khalidi Hospital", "location": "Amman", "image": "images/hospital_image.png", "inNetwork": true, "city": "Amman"},
    {"name": "Zarqa Governmental Hospital", "location": "Zarqa", "image": "images/hospital_image.png", "inNetwork": false, "city": "Zarqa"},
    {"name": "King Abdullah University Hospital", "location": "Irbid", "image": "images/hospital_image.png", "inNetwork": true, "city": "Irbid"},
    {"name": "Ajloun Governmental Hospital", "location": "Ajloun", "image": "images/hospital_image.png", "inNetwork": true, "city": "Ajloun"},
    {"name": "Al Karak Hospital", "location": "Karak", "image": "images/hospital_image.png", "inNetwork": false, "city": "Karak"},
    {"name": "Aqaba Hospital", "location": "Aqaba", "image": "images/hospital_image.png", "inNetwork": true, "city": "Aqaba"},
    {"name": "Madaba Governmental Hospital", "location": "Madaba", "image": "images/hospital_image.png", "inNetwork": true, "city": "Madaba"},
    {"name": "Jerash Hospital", "location": "Jerash", "image": "images/hospital_image.png", "inNetwork": false, "city": "Jerash"},
    {"name": "Salt Hospital", "location": "Salt", "image": "images/hospital_image.png", "inNetwork": true, "city": "Salt"},
    {"name": "Mafraq Hospital", "location": "Mafraq", "image": "images/hospital_image.png", "inNetwork": true, "city": "Mafraq"},
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

  void _onCardTap(Map<String, dynamic> hospital) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HospitalShowDetails()
      ),
    );
    print("Tapped on ${hospital['name']}");
  }

  // Handle city filter selection
  void _onCitySelected(String? city) {
    setState(() {
      selectedCity = city ?? "All Cities";
      _fetchAllHospitals();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Choose Hospital",
          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          
        ),
        leading: IconButton(
          onPressed: () {
             Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const edit_profiles_main()),
                  );
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple], // Gradient color from My_Info
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
                              borderRadius: BorderRadius.circular(10),
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
