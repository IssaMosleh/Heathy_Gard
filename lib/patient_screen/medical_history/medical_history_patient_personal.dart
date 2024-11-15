import 'package:flutter/material.dart';
import 'package:tess/patient_screen/medical_history/medical_history_patient_main.dart';

class medical_history_patient_personal extends StatelessWidget {
  const medical_history_patient_personal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MedicalRecordScreen(),
    );
  }
}

class MedicalRecordScreen extends StatelessWidget {
  const MedicalRecordScreen({Key? key}) : super(key: key);

  Future<Map<String, dynamic>> fetchMedicalData() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
    return {
      "totalVisits": [
        {"label": "Total Visits", "value": "12"},
        {"label": "Last Visit", "value": "15 Aug 2023"},
        {"label": "Visits This Year", "value": "4"},
      ],
      "chronicConditions": [
        {"label": "Asthma", "value": "Diagnosed: 2015"},
        {"label": "Diabetes", "value": "Diagnosed: 2020"},
      ],
      "surgeries": [
        {
          "surgery": "Appendectomy",
          "date": "12 Feb 2022",
          "surgeon": "Dr. John Doe",
        },
        {
          "surgery": "Gallbladder Removal",
          "date": "5 June 2018",
          "surgeon": "Dr. Emily Smith",
        },
      ],
      "vaccinations": [
        {"label": "Flu", "value": "2023"},
        {"label": "COVID-19", "value": "2021"},
        {"label": "Tetanus", "value": "2019"},
      ],
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Personal Information",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => medical_history_patient_main()),
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
        elevation: 4.0,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchMedicalData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error loading data"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No data available"));
          }

          final data = snapshot.data!;
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              _buildInfoSection(
                title: "Total Visits",
                icon: Icons.calendar_today,
                backgroundColor: Colors.blue,
                content: data["totalVisits"],
              ),
              _buildInfoSection(
                title: "Chronic Conditions",
                icon: Icons.healing,
                backgroundColor: Colors.orange,
                content: data["chronicConditions"],
              ),
              _buildSurgerySection(
                title: "Surgeries",
                icon: Icons.local_hospital,
                backgroundColor: Colors.red,
                surgeries: data["surgeries"],
              ),
              _buildInfoSection(
                title: "Vaccinations",
                icon: Icons.vaccines,
                backgroundColor: Colors.green,
                content: data["vaccinations"],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildInfoSection({
    required String title,
    required IconData icon,
    required Color backgroundColor,
    required List<Map<String, String>> content,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(title, icon, backgroundColor),
          const Divider(height: 1, color: Colors.grey),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: content.map((item) {
                return _buildDetail(item["label"]!, item["value"]!);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSurgerySection({
    required String title,
    required IconData icon,
    required Color backgroundColor,
    required List<Map<String, String>> surgeries,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(title, icon, backgroundColor),
          const Divider(height: 1, color: Colors.grey),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: surgeries.map((surgery) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        surgery["surgery"]!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Date: ${surgery["date"]!}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                      Text(
                        "Surgeon: ${surgery["surgeon"]!}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                      const Divider(height: 12, color: Color.fromARGB(255, 192, 192, 192)),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey[800],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}