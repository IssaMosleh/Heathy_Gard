import 'package:flutter/material.dart';
import 'package:tess/pharmacy_screen/mainscreenpharmacy.dart';
import 'package:tess/pharmacy_screen/my_hospital/my_hospital_details.dart';

class MyPharmacy extends StatelessWidget {
  const MyPharmacy({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Pharmacy Portal",
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyPharmaciesScreen(),
    );
  }
}

class MyPharmaciesScreen extends StatefulWidget {
  const MyPharmaciesScreen({super.key});

  @override
  _MyPharmaciesScreenState createState() => _MyPharmaciesScreenState();
}

class _MyPharmaciesScreenState extends State<MyPharmaciesScreen> {
  final List<Map<String, String>> facilities = [
    {'title': "City Pharmacy", 'subtitle': "Downtown", 'type': "pharmacy"},
    {'title': "HealthPlus Pharmacy", 'subtitle': "West End", 'type': "pharmacy"},
  ];

  Widget getIcon(String type) {
    return Image.asset(
      'assets/pharmacy.png',
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "My Pharmacies",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PharmacyScreen()),
            );
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: facilities.length,
          itemBuilder: (context, index) {
            final facility = facilities[index];
            return Column(
              children: [
                pharmacyCard(
                  context,
                  title: facility['title']!,
                  subtitle: facility['subtitle']!,
                  type: facility['type']!,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const my_hospital_details(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget pharmacyCard(
      BuildContext context, {
      required String title,
      required String subtitle,
      required String type,
      required VoidCallback onTap,
    }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 4,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.grey.shade200,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: getIcon(type),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    softWrap: true,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                    softWrap: true,
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
