import 'package:flutter/material.dart';
import 'dart:math';
import 'package:tess/pharmacy_screen/main.dart';

class MyInfoPharmacyDoctor extends StatelessWidget {
  const MyInfoPharmacyDoctor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "My Info",
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: PharmacyDoctorScreen(),
    );
  }
}

// Pharmacy Doctor Screen
class PharmacyDoctorScreen extends StatefulWidget {
  @override
  _PharmacyDoctorScreenState createState() => _PharmacyDoctorScreenState();
}

class _PharmacyDoctorScreenState extends State<PharmacyDoctorScreen> {
  // Pharmacy doctor's information as variables
  String doctorName = "Dr. John Doe";
  String doctorID = "P123456";
  String gender = "Male";
  String dateOfBirth = "March 10, 1975";
  String specialization = "Pharmacology";
  String yearsOfExperience = "20 years";
  String contactNumber = "+962795716049";
  String email = "john.doe@pharmacy.com";
  String languagesSpoken = "English, Arabic";
  String medicalSchool = "University of Pharmacy";
  String residency = "Pharmacology, National Pharmacy Center";
  String boardCertification = "Pharmacy Board Certification";
  String specialtyCertification = "Certified Pharmacist";
  String? notableAchievements = "Developed new medication formulations";
  String? researchPublications = "10 peer-reviewed articles in pharmacology";

  double availableBalance = 12000; // Example data
  double targetBalance = 30000;
  
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  void openEditDialog() {
    emailController.text = email;
    phoneController.text = contactNumber;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Edit Information"),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: "Email"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }
                    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                    if (!emailRegex.hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: phoneController,
                  decoration: InputDecoration(labelText: "Phone Number"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a phone number';
                    }
                    final phoneRegex = RegExp(r'^\+962\d{9}$');
                    if (!phoneRegex.hasMatch(value)) {
                      return 'Phone number must start with +962 and contain 9 digits';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.phone,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    email = emailController.text;
                    contactNumber = phoneController.text;
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double balancePercentage = (availableBalance / targetBalance) * 100;
    balancePercentage = balancePercentage > 100 ? 100 : balancePercentage;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Pharmacy_Screen()),);
        }, icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),
        centerTitle: true,
        title: const Text(
          "Pharmacy Doctor's Portal",
          style: TextStyle(color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
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
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Doctor Information Section
            InfoContainer(
              title: 'Pharmacy Doctor Information',
              children: [
                infoRow('Name', doctorName, icon: Icons.person),
                infoRow('Doctor ID', doctorID, icon: Icons.badge),
                infoRow('Gender', gender, icon: Icons.person),
                infoRow('Date of Birth', dateOfBirth, icon: Icons.cake),
                infoRow('Specialization', specialization, icon: Icons.medical_services),
                infoRow('Years of Experience', yearsOfExperience, icon: Icons.timeline),
                infoRow('Contact Number', contactNumber, icon: Icons.phone),
                infoRow('Email', email, icon: Icons.email),
                infoRow('Languages Spoken', languagesSpoken, icon: Icons.language),
                infoRow('Medical School', medicalSchool, icon: Icons.school),
                infoRow('Residency', residency, icon: Icons.local_hospital),
                infoRow('Board Certification', boardCertification, icon: Icons.verified),
                infoRow('Specialty Certification', specialtyCertification, icon: Icons.verified),
                if (notableAchievements != null)
                  infoRow('Notable Achievements', notableAchievements!, icon: Icons.star),
                if (researchPublications != null)
                  infoRow('Research Publications', researchPublications!, icon: Icons.book),
              ],
            ),
            const SizedBox(height: 20),
            // Edit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: openEditDialog,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.zero,
                  elevation: 5,
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    constraints: BoxConstraints(minHeight: 50, minWidth: 150),
                    child: const Text(
                      "Edit",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget infoRow(String label, String value, {IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) Icon(icon, size: 16, color: Color(0xFF8E2DE2)),
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

// Info Container Widget
class InfoContainer extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const InfoContainer({Key? key, required this.title, required this.children}) : super(key: key);

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
              color: Color(0xFF8E2DE2),
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

// BalanceMeter widget to display progress toward balance goal
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

// CustomPainter for the BalanceMeter
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
      ..shader = LinearGradient(
        colors: [Colors.cyanAccent, Colors.deepPurpleAccent, Colors.pinkAccent],
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
