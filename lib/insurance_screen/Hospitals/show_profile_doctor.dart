import 'package:flutter/material.dart';
import 'dart:math';
import 'package:tess/insurance_screen/Hospitals/doctors_insurance.dart';

class show_profile_doctor extends StatefulWidget {
  const show_profile_doctor({super.key});

  @override
  _ShowProfileDoctorState createState() => _ShowProfileDoctorState();
}

class _ShowProfileDoctorState extends State<show_profile_doctor> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Doctor Profile",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DoctorScreen(),
    );
  }
}

class InfoContainer extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const InfoContainer({super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 4,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          const Divider(color: Colors.grey, thickness: 0.5),
          const SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }
}

class DoctorScreen extends StatefulWidget {
  const DoctorScreen({super.key});

  @override
  _DoctorScreenState createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  final String doctorName = "Dr. Jane Smith";
  final String doctorID = "D123456";
  final String gender = "Female";
  final String dateOfBirth = "January 1, 1980";
  final String specialization = "Cardiology";
  final String yearsOfExperience = "15 years";
  final String contactNumber = "+962795716049";
  final String email = "jane.smith@hospital.com";
  final String languagesSpoken = "English, Spanish";
  final String medicalSchool = "Harvard Medical School";
  final String residency = "Cardiology, Massachusetts General Hospital";
  final String boardCertification = "American Board of Internal Medicine";
  final String specialtyCertification = "American Board of Cardiology";
  final String? topDoctorAward = "2018, 2020";
  final String? researchPublications = "15 peer-reviewed articles in cardiology";

  double availableBalance = 0;
  double targetBalance = 30000;
  int totalVisits = 0;
  int visitsThisYear = 0;
  int targetVisitsThisYear = 200;

  @override
  Widget build(BuildContext context) {
    double balancePercentage = (availableBalance / targetBalance) * 100;
    balancePercentage = balancePercentage > 100 ? 100 : balancePercentage;
    double overTarget = availableBalance > targetBalance ? availableBalance - targetBalance : 0;
    double visitsThisYearPercentage = (visitsThisYear / targetVisitsThisYear) * 100;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Doctor Profile",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const doctors_insurance(hospitalName: 'Jordan Hospital')),
          ),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [
            InfoContainer(
              title: 'Earnings Target',
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: BalanceMeter(balance: balancePercentage),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Achieved Balance: ${availableBalance.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Target Balance: ${targetBalance.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (overTarget > 0)
                            Text(
                              "Over Target: ${overTarget.toStringAsFixed(2)}",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                infoRow('Total Number of Visits', totalVisits.toString(), icon: Icons.calendar_today),
                infoRow('Visits This Year', visitsThisYear.toString(), icon: Icons.event),
                infoRow('Target Visits This Year', targetVisitsThisYear.toString(), icon: Icons.flag),
                infoRow('Visits This Year %', "${visitsThisYearPercentage.toStringAsFixed(2)}%", icon: Icons.show_chart),
              ],
            ),
            const SizedBox(height: 20),
            InfoContainer(
              title: 'Doctor Information',
              children: [
                infoRow('Name', doctorName, icon: Icons.person),
                infoRow('Doctor ID', doctorID, icon: Icons.badge),
                infoRow('Gender', gender, icon: Icons.female),
                infoRow('Date of Birth', dateOfBirth, icon: Icons.cake),
                infoRow('Specialization', specialization, icon: Icons.favorite),
                infoRow('Years of Experience', yearsOfExperience, icon: Icons.timeline),
                infoRow('Contact Number', contactNumber, icon: Icons.phone),
                infoRow('Email', email, icon: Icons.email, isLongText: true),
                infoRow('Languages Spoken', languagesSpoken, icon: Icons.language),
              ],
            ),
            const SizedBox(height: 20),
            InfoContainer(
              title: 'Education',
              children: [
                infoRow('Medical School', medicalSchool, icon: Icons.school),
                infoRow('Residency', residency, icon: Icons.local_hospital),
              ],
            ),
            const SizedBox(height: 20),
            InfoContainer(
              title: 'Certifications',
              children: [
                infoRow('Board Certification', boardCertification, icon: Icons.verified),
                infoRow('Specialty Certification', specialtyCertification, icon: Icons.verified),
              ],
            ),
            const SizedBox(height: 20),
            InfoContainer(
              title: 'Special Achievements',
              children: [
                if (topDoctorAward != null)
                  infoRow('Top Doctor Award', topDoctorAward!, icon: Icons.star),
                if (researchPublications != null)
                  infoRow('Research Publications', researchPublications!, icon: Icons.book),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget infoRow(String label, String value, {IconData? icon, bool isLongText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) Icon(icon, size: 16, color: Colors.blueAccent),
          if (icon != null) const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BalanceMeter extends StatelessWidget {
  final double balance;

  const BalanceMeter({super.key, required this.balance});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double meterSize = screenWidth * 0.25;

    return CustomPaint(
      size: Size(meterSize, meterSize),
      painter: BalanceMeterPainter(balance),
    );
  }
}

class BalanceMeterPainter extends CustomPainter {
  final double balance;

  BalanceMeterPainter(this.balance);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);

    final backgroundPaint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi,
      pi,
      false,
      backgroundPaint,
    );

    final balanceGradient = Paint()
      ..shader = const LinearGradient(
        colors: [Colors.orange, Colors.deepOrange],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final sweepAngle = pi * (balance / 100);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi,
      sweepAngle,
      false,
      balanceGradient,
    );

    final textPainter = TextPainter(
      text: TextSpan(
        text: "${balance.toInt()}%",
        style: TextStyle(
          fontSize: size.width * 0.2,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(center.dx - textPainter.width / 2, center.dy - textPainter.height / 2),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
