import 'package:flutter/material.dart';
import 'dart:math';

import 'package:tess/patient_screen/main.dart';

void main() {
  runApp(const patient_insurance());
}

class patient_insurance extends StatefulWidget {
  const patient_insurance({Key? key}) : super(key: key);

  @override
  State<patient_insurance> createState() => _MainAppState();
}

class _MainAppState extends State<patient_insurance> {
  // Variables for Insurance Balance
  double availableBalance = 2500;
  double totalBalance = 10000;

  // Variables for Personal Information
  String firstName = "John";
  String middleName = "Michael";
  String lastName = "Doe";
  String dateOfBirth = "01/01/1980";
  String gender = "Male";
  String contactEmail = "john.doe@example.com";
  String contactPhone = "+1 234 567 890";
  String address = "123 Main St, City, Country";

  // Variables for Insurance Information
  String insuranceName = "HealthCare Plus";
  String memberId = "123456789";
  String familyId = "987654321";
  String policyNumber = "INS-0012345";
  String groupNumber = "GRP-54321";
  String patientCopay = "20%";

  // Variables for Membership Status
  String coverageStart = "01/01/2023";
  String coverageEnd = "10/20/2024";
  String renewalDate = "1/1/2024";

  // Variables for Additional Information
  String primaryCarePhysician = "Dr. Jane Smith";
  String emergencyContact = "Jane Doe (+1 234 567 891)";

  // Method to determine membership status
  String getMembershipStatus() {
    DateTime currentDate = DateTime.now();
    DateTime endDate = DateTime.parse(coverageEnd.split('/').reversed.join());

    return currentDate.isBefore(endDate) ? "Active" : "Inactive";
  }

  @override
  Widget build(BuildContext context) {
    double usedBalance = totalBalance - availableBalance;
    double balancePercentage = (availableBalance / totalBalance) * 100;

    // Get screen width for responsive balance meter size
    double screenWidth = MediaQuery.of(context).size.width;
    double balanceMeterSize = screenWidth * 0.25; // 25% of screen width

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56.0),
          child: AppBar(
            centerTitle: true,
            title: const Text(
              "Insurance Center",
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
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Insurance Balance Container
              buildContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Insurance Balance",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: balanceMeterSize,
                          height: balanceMeterSize,
                          child: BalanceMeter(balance: balancePercentage),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Available Balance: \$${availableBalance.toStringAsFixed(2)}",
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Used Balance: \$${usedBalance.toStringAsFixed(2)}",
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Total Balance: \$${totalBalance.toStringAsFixed(2)}",
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              
              // Personal Information Section
              buildContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Personal Information",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Divider(),
                    infoRow("First Name", firstName),
                    infoRow("Middle Name", middleName),
                    infoRow("Last Name", lastName),
                    infoRow("Date of Birth", dateOfBirth),
                    infoRow("Gender", gender),
                    infoRow("Contact Email", contactEmail, isLongText: true),
                    infoRow("Contact Phone", contactPhone),
                    infoRow("Address", address, isLongText: true),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Insurance Information Section
              buildContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Insurance Information",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Divider(),
                    infoRow("Insurance Name", insuranceName),
                    infoRow("Member ID", memberId),
                    infoRow("Family ID", familyId),
                    infoRow("Policy Number", policyNumber),
                    infoRow("Group Number", groupNumber),
                    infoRow("Patient Co-pay", patientCopay),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Membership Status Section
              buildContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Membership Status",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Divider(),
                    infoRow("Status", getMembershipStatus()),
                    infoRow("Coverage Start", coverageStart),
                    infoRow("Coverage End", coverageEnd),
                    infoRow("Renewal Date", renewalDate),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Additional Information Section
              buildContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Additional Information",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Divider(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.person, color: Colors.blue, size: 18),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Primary Care Physician",
                                style: TextStyle(fontSize: 13, color: Colors.black54),
                              ),
                              Text(
                                primaryCarePhysician,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.phone, color: Colors.red, size: 18),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Emergency Contact",
                                style: TextStyle(fontSize: 13, color: Colors.black54),
                              ),
                              Text(
                                emergencyContact,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildContainer({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 4,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget infoRow(String label, String value, {bool isLongText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              value,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87),
              overflow: isLongText ? TextOverflow.ellipsis : TextOverflow.visible,
              softWrap: isLongText ? true : false,
            ),
          ),
        ],
      ),
    );
  }
}

class BalanceMeter extends StatelessWidget {
  final double balance;

  const BalanceMeter({Key? key, required this.balance}) : super(key: key);

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

    final balancePaint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final sweepAngle = pi * (balance / 100);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi,
      sweepAngle,
      false,
      balancePaint,
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