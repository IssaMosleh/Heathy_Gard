import 'package:flutter/material.dart';
import 'package:tess/insurance_screen/Hospitals/doctors_insurance.dart';
import 'package:tess/insurance_screen/Hospitals/hospitals_insurance.dart';
import 'package:tess/insurance_screen/main.dart';

class HospitalStatsScreen extends StatelessWidget {
  final String hospitalName;
  final int totalClaims;
  final int approvedClaims;
  final int rejectedClaims;
  final int totalBookings;
  final int totalDoctors;
  final double totalMoneySpent;

  const HospitalStatsScreen({
    Key? key,
    required this.hospitalName,
    required this.totalClaims,
    required this.approvedClaims,
    required this.rejectedClaims,
    required this.totalBookings,
    required this.totalDoctors,
    required this.totalMoneySpent,
  }) : super(key: key);

  void navigateToDoctorsScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => doctors_insurance(hospitalName: hospitalName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => insurance_hospital_search()),
            );
        }, icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),
        title: Text(
          '$hospitalName - Statistics',
          style: const TextStyle(color: Colors.white,fontSize: 22, fontWeight: FontWeight.bold),
        ),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildStatCard("Total Claims", totalClaims.toString(), Icons.assignment),
            buildStatCard("Approved Claims", approvedClaims.toString(), Icons.check_circle),
            buildStatCard("Rejected Claims", rejectedClaims.toString(), Icons.cancel),
            buildStatCard("Total Bookings", totalBookings.toString(), Icons.people),
            buildStatCard("Total Doctors", totalDoctors.toString(), Icons.local_hospital),
            buildStatCard("Total Money Spent", "\$${totalMoneySpent.toStringAsFixed(2)}", Icons.attach_money),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => navigateToDoctorsScreen(context),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(vertical: 15),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              child: Ink(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.blueAccent, Colors.purpleAccent],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Container(
                  alignment: Alignment.center,
                  constraints: const BoxConstraints(minWidth: 100, minHeight: 50),
                  child: const Text(
                    "View All Doctors",
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget to build individual stat cards for each metric
  Widget buildStatCard(String title, String value, IconData icon) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 6,
      shadowColor: Colors.black26,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.blueAccent, Colors.purpleAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 28, color: Colors.white),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[700]),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black87),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Placeholder screen for listing doctors
class DoctorsScreen extends StatelessWidget {
  final String hospitalName;

  const DoctorsScreen({Key? key, required this.hospitalName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Doctors at $hospitalName"),
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
      body: Center(
        child: Text(
          "List of doctors will be displayed here.",
          style: TextStyle(fontSize: 18, color: Colors.grey[600]),
        ),
      ),
    );
  }
}
