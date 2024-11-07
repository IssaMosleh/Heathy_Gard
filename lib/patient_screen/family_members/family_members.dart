import 'package:flutter/material.dart';
import 'package:tess/patient_screen/main.dart';

class family_members extends StatelessWidget {
  const family_members({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FamilyMembersScreen(familyId: 'FAMILY123'), // Pass the familyId here
    );
  }
}

class FamilyMembersScreen extends StatelessWidget {
  final String familyId;

  const FamilyMembersScreen({Key? key, required this.familyId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: AppBar(
          centerTitle: true,
          title: const Text(
            "Family Members",
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Patient_Screen()),
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
      ),
      body: FutureBuilder<List<Map<String, String>>>(
        future: fetchFamilyMembers(familyId), // Fetch data based on familyId
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No family members found"));
          } else {
            // Display the list of family members
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final member = snapshot.data![index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  elevation: 4.0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage(member['image']!),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                member['name']!,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Relationship: ${member['relationship']}",
                                style: const TextStyle(fontSize: 14, color: Colors.black54),
                              ),
                              Text(
                                "Age: ${member['age']}",
                                style: const TextStyle(fontSize: 14, color: Colors.black54),
                              ),
                              Text(
                                "Member ID: ${member['memberId']}",
                                style: const TextStyle(fontSize: 14, color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List<Map<String, String>>> fetchFamilyMembers(String familyId) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // Here, you can replace this with an actual API call or database query
    // For example, you could use http package or Firebase to fetch data based on familyId
    // For now, this is mock data

    if (familyId == 'FAMILY123') {
      return [
        {
          'name': 'John Doe',
          'relationship': 'Father',
          'age': '45',
          'memberId': 'ID123456',
          'image': 'images/father.jpg',
        },
        {
          'name': 'Jane Doe',
          'relationship': 'Mother',
          'age': '43',
          'memberId': 'ID123457',
          'image': 'images/mother.jpg',
        },
        {
          'name': 'Sam Doe',
          'relationship': 'Son',
          'age': '18',
          'memberId': 'ID123458',
          'image': 'images/son.jpg',
        },
      ];
    } else {
      // Return an empty list if no members are found
      return [];
    }
  }
}