import 'package:flutter/material.dart';
import 'package:tess/patient_screen/main.dart';
import 'package:tess/patient_screen/patient_appointmnet/patient_appointment_introduction.dart';
import 'package:tess/patient_screen/patient_appointmnet/patient_appointment_typeofvist.dart';

class patient_appointment_choosemember extends StatelessWidget {
  const patient_appointment_choosemember({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FamilyMemberListScreen(activate: true), // Pass activate as needed
    );
  }
}

class FamilyMemberListScreen extends StatelessWidget {
  final bool activate; // Parameter to control access

  const FamilyMemberListScreen({Key? key, required this.activate})
      : super(key: key);

  // Mock function to simulate fetching data from a database
  Future<List<Map<String, String>>> fetchFamilyMembers() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulating network delay
    return [
      {
        "name": "Ali Ahmad",
        "relationship": "Father",
        "age": "60",
        "image": "assets/images/family_member1.png"
      },
      {
        "name": "Layla Yusuf",
        "relationship": "Mother",
        "age": "58",
        "image": "assets/images/family_member2.png"
      },
      {
        "name": "Omar Khaled",
        "relationship": "Brother",
        "age": "25",
        "image": "assets/images/family_member3.png"
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Patient_Screen()),
                    );
              },
              icon: Image.asset('images/icon1.png'),
            ),
          ],
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
              "Choose Family Member",
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
                    MaterialPageRoute(builder: (context) => patient_appointment_introduction()),
                    );
            },
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              color: Colors.black,
              height: 1.0,
            ),
          ),
        ),
      ),
      body: activate
          ? FutureBuilder<List<Map<String, String>>>(
              future: fetchFamilyMembers(), // Call the async function here
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error fetching data'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No family members found'));
                } else {
                  final familyMembers = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Family Member List",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "Select a family member to make an appointment",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: familyMembers.length,
                          itemBuilder: (context, index) {
                            final member = familyMembers[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => patient_appointment_typeofvist()),
                                );
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 4,
                                margin: const EdgeInsets.only(bottom: 16),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 70,
                                        height: 70,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.blueAccent,
                                            width: 3.0,
                                          ),
                                        ),
                                        child: ClipOval(
                                          child: Image.asset(
                                            member["image"]!,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            member["name"]!,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Row(
                                            children: [
                                              const Icon(Icons.family_restroom,
                                                  size: 16, color: Colors.grey),
                                              const SizedBox(width: 4),
                                              Text(
                                                member["relationship"]!,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 4),
                                          Row(
                                            children: [
                                              const Icon(Icons.cake,
                                                  size: 16, color: Colors.grey),
                                              const SizedBox(width: 4),
                                              Text(
                                                "Age: ${member["age"]}",
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                }
              },
            )
          : const Center(
              child: Text(
                "Access denied. Please contact support for activation.",
                style: TextStyle(fontSize: 18, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
    );
  }
}
