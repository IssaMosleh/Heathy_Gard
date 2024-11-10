import 'package:flutter/material.dart';
import 'package:tess/pharmacy_screen/money_pharmacy/pharmacy_money.dart';
import 'package:tess/pharmacy_screen/my_hospital/my_hospital_pharmacy_main.dart';
import 'package:tess/pharmacy_screen/my_info/my_info_pharmacy.dart';
import 'package:tess/pharmacy_screen/notification_screen_pharmacy.dart';
import 'package:tess/pharmacy_screen/order_pharmacy/order_pharmacy.dart';
import 'package:tess/pharmacy_screen/settings_pharmacy.dart';

void main() {
  runApp(const Pharmacy_Screen());
}

class Pharmacy_Screen extends StatelessWidget {
  const Pharmacy_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PharmacyScreen(),
    );
  }
}

class PharmacyScreen extends StatefulWidget {
  const PharmacyScreen({Key? key}) : super(key: key);

  @override
  State<PharmacyScreen> createState() => _PharmacyScreenState();
}

class _PharmacyScreenState extends State<PharmacyScreen> {
  final double imageSize = 50.0;
  final double fontSize = 12.0;
  final List<String> labels = ["My Info", "My Pharmacies", "Money", "Order History"];
  final List<String> images = [
    "images/my_info.png",
    "images/MedicalRecord.png",
    "images/money_history.png",
    "images/order_history.png",
  ];

  void handleOnTap(String label) {
    switch (label) {
      case "My Info":
        Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyInfoPharmacyDoctor()),);
        break;
      case "My Pharmacies":
        Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyPharmacy(),
                      ),
                    );
        break;
      case "Money":
        Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => pharmacy_money(),
                      ),
                    );
        break;
      case "Order History":
        Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PharmacyOrderScreen(),
                      ),
                    );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              MaterialPageRoute(builder: (context) => Pharmacy_Screen()),
            );
              },
              icon: Image.asset('images/icon1.png'), // Replace with desired icon
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PharmacyNotificationScreen()),
            );
              },
              icon: Image.asset('images/icon3.png'), // Replace with desired icon
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => settings_pharmacy()),
            );
              },
              icon: Image.asset('images/icon4.png'), // Replace with desired icon
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
                      child: Image.asset("images/Vector2.png", fit: BoxFit.cover),
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
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage("images/person.jpg"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Hi Dr. Deyya,",
                                    style: TextStyle(color: Colors.white, fontSize: 18),
                                  ),
                                  Text(
                                    "Welcome back!",
                                    style: TextStyle(color: Color.fromARGB(207, 255, 255, 255)),
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
                                            child: (row == 1 && col > 0)
                                                ? const SizedBox.shrink() // Empty space for the last two slots
                                                : InkWell(
                                                    onTap: () => handleOnTap(labels[(row * 3) + col]),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        SizedBox(
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
                                                          style: TextStyle(fontSize: fontSize),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
