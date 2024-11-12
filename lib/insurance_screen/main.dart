import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tess/insurance_screen/Hospitals/hospitals_insurance.dart';
import 'package:tess/insurance_screen/Report/report.dart';
import 'package:tess/insurance_screen/claimsManagement/ClaimsManagement.dart';
import 'package:tess/insurance_screen/my_info/My_Info_insurance.dart';

void main() {
  runApp(MaterialApp(home: InsuranceRep_Screen()));
}

class InsuranceRep_Screen extends StatefulWidget {
  const InsuranceRep_Screen({Key? key}) : super(key: key);

  @override
  State<InsuranceRep_Screen> createState() => _InsuranceRepScreenState();
}

class _InsuranceRepScreenState extends State<InsuranceRep_Screen> {
  final double imageSize = 50.0;
  final double fontSize = 12.0;
  final List<String> labels = [
    "Claims Management",
    "Reports",
    "My Info",
    "Hospitals",
    "Premium Processing",
    "Support Requests",
  ];

  final List<String> images = [
    "images/ClaimsManagement.png",
    "images/Reports.png",
    "images/Approvals.png",
    "images/PolicyOverview.png",
    "images/PremiumProcessing.png",
    "images/SupportRequests.png",
  ];

  final DateFormat dateFormat = DateFormat('MMM d, yyyy');

  void handleOnTap(String label) {
    switch (label) {
      case "Claims Management":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ClaimsManagementScreen()),
        );
        break;
      case "Reports":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdvancedReportsScreen()),
        );
        break;
      case "My Info":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => My_Info_insurance()),
        );
        break;
      case "Hospitals":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => insurance_hospital_search()),
        );
        break;
      case "Premium Processing":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => premium_processing_screen()),
        );
        break;
      case "Support Requests":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => support_requests_screen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
                offset: Offset(0, 3),
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
                    MaterialPageRoute(builder: (context) => InsuranceRep_Screen()),
                  );         
                },
                icon: Image.asset('images/icon1.png', width: 30, height: 30),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => claims_management_screen()),
                  );         
                },
                icon: Image.asset('images/icon2.png', width: 30, height: 30),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => reports_screen()),
                  );         
                },
                icon: Image.asset('images/icon3.png', width: 30, height: 30),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => settings_screen()),
                  );         
                },
                icon: Image.asset('images/icon4.png', width: 30, height: 30),
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
                                  height: 75, 
                                  width: 75,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage("images/person.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "Hello,",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      "Insurance Representative Portal",
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
                                constraints: BoxConstraints(maxWidth: 500),
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
                                              child: InkWell(
                                                onTap: () => handleOnTap(labels[(row * 3) + col]),
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
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        constraints: BoxConstraints(maxWidth: 500),
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(color: Colors.grey[300]!, width: 1),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Latest Updates",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  constraints: BoxConstraints(maxHeight: 30, maxWidth: 30),
                                  decoration: BoxDecoration(shape: BoxShape.circle),
                                  child: Center(
                                    child: Image.asset(
                                      "images/info.png",
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    "Keep up with new claims, reports, and policy updates!",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
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

// Dummy screen classes for navigation
class claims_management_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Claims Management Screen")));
  }
}

class reports_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Reports Screen")));
  }
}

class approvals_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Approvals Screen")));
  }
}

class policy_overview_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Policy Overview Screen")));
  }
}

class premium_processing_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Premium Processing Screen")));
  }
}

class support_requests_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Support Requests Screen")));
  }
}

class settings_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Settings Screen")));
  }
}
