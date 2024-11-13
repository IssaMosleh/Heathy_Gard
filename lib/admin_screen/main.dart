import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tess/admin_screen/add_new_users/add_new_main.dart';
import 'package:tess/admin_screen/edit_profiles/edit_profiles_main.dart';


void main() {
  runApp(const AdminScreen());
}

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final double imageSize = 50.0; // Icon size for admin features
  final double fontSize = 12.0; // Font size for labels

  // Updated labels for admin functionality
  final List<String> labels = [
    "Edit Profiles",
    "Add New Entry",
    "Add Patient",
    "Add Doctor",
    "Reports",
    "Settings",
  ];

  // Updated images for corresponding admin functionality
  final List<String> images = [
    "images/user_management.png",
    "images/add_hospital.png",
    "images/add_patient.png",
    "images/add_doctor.png",
    "images/reports.png",
    "images/settings.png",
  ];

  final DateFormat dateFormat = DateFormat('MMM d, yyyy');

  // Navigation handling updated for admin-specific screens
  void handleOnTap(String label, BuildContext context) {
    switch (label) {
      case "Edit Profiles":
        Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const edit_profiles_main()),
                  );
        break;
      case "Add New Entry":
      Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const add_new_main()),
                  );
        break;
      case "Add Patient":
  
        break;
      case "Add Doctor":

        break;
      case "Reports":

        break;
      case "Settings":
        
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          margin: const EdgeInsets.symmetric(horizontal: 32.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AdminScreen()),
                  );
                },
                icon: Image.asset('images/icon1.png', width: 30, height: 30),
              ),
              IconButton(
                onPressed: () {

                },
                icon: Image.asset('images/icon2.png', width: 30, height: 30),
              ),
              IconButton(
                onPressed: () {

                },
                icon: Image.asset('images/icon3.png', width: 30, height: 30),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Positioned.fill(
                        child: Image.asset(
                          "images/Vector2.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16.0, 60.0, 16.0, 20.0),
                            child: Row(
                              children: [
                                Container(
                                  height: 75, // Profile image size
                                  width: 75,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage("images/father.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Hello Admin,",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      "Manage Your Platform",
                                      style: TextStyle(
                                        color: Color.fromARGB(207, 255, 255, 255),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Container(
                                constraints: const BoxConstraints(maxWidth: 500),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(24.0),
                                  border: Border.all(color: Colors.grey[300]!, width: 1),
                                ),
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: [
                                    for (int row = 0; row < 2; row++) ...[
                                      if (row > 0)
                                        const Divider(color: Colors.grey, thickness: 1),
                                      Row(
                                        children: [
                                          for (int col = 0; col < 3; col++) ...[
                                            if (col > 0)
                                              Container(
                                                width: 1,
                                                color: Colors.grey[300],
                                                height: 80,
                                              ),
                                            Expanded(
                                              child: Builder(
                                                builder: (BuildContext innerContext) {
                                                  return InkWell(
                                                    onTap: () => handleOnTap(
                                                        labels[(row * 3) + col], innerContext),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Container(
                                                          height: imageSize,
                                                          width: imageSize,
                                                          child: Image.asset(
                                                            images[(row * 3) + col],
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                        const SizedBox(height: 6),
                                                        Text(
                                                          labels[(row * 3) + col],
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                            fontSize: fontSize,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      constraints: const BoxConstraints(maxWidth: 500),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24.0),
                        border: Border.all(color: Colors.grey[300]!, width: 1),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Latest Updates",
                            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "View recent activity, monitor claims, and manage users to ensure smooth operations.",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
