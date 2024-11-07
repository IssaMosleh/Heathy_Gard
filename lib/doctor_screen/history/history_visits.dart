import 'package:flutter/material.dart';
import 'package:tess/doctor_screen/history/patient_history.dart';
import 'package:tess/doctor_screen/main.dart';


class history_visits extends StatefulWidget {
  const history_visits({Key? key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<history_visits> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> patients = [
    {
      "name": "John Doe",
      "date": "2024-01-15",
      "phone": "123-456-7890",
      "image": "images/profile_placeholder.png"
    },
    {
      "name": "Jane Smith",
      "date": "2024-02-20",
      "phone": "098-765-4321",
      "image": "images/profile_placeholder.png"
    },
    {
      "name": "Michael Johnson",
      "date": "2024-03-10",
      "phone": "555-555-5555",
      "image": "images/profile_placeholder.png"
    },
    {
      "name": "Emily Davis",
      "date": "2024-04-25",
      "phone": "444-444-4444",
      "image": "images/profile_placeholder.png"
    },
  ];

  List<Map<String, String>> searchResults = [];

  @override
  void initState() {
    super.initState();
    searchResults = patients;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text;
    setState(() {
      searchResults = query.isNotEmpty
          ? patients
              .where((patient) =>
                  patient["name"]!.toLowerCase().contains(query.toLowerCase()))
              .toList()
          : patients;
    });
  }

  void _viewHistory(Map<String, String> patient) {
    // Navigate to the PatientHistoryDetailScreen with patient details
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => patient_history_same_doctor(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Doctor_Screen()),)
        ),
        title: const Text("Patient History",style: TextStyle(color: Colors.white),),
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search patients",
                prefixIcon: Icon(Icons.search, color: Colors.blue),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.blue),
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
                  final patient = searchResults[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 3,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              // Larger circular image container with visible border
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.blue, // Border color
                                    width: 3, // Border width
                                  ),
                                  image: DecorationImage(
                                    image: AssetImage(patient["image"]!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              // Patient details
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      patient["name"]!,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      "Visit Date: ${patient["date"]}",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      "Phone: ${patient["phone"]}",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Gradient View History button positioned below details
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Colors.blue, Colors.purple],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ElevatedButton(
                              onPressed: () => _viewHistory(patient),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Text(
                                "View History",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
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