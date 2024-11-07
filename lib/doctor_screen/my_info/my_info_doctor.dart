import 'package:flutter/material.dart';
import 'dart:math';
import 'package:tess/doctor_screen/main.dart';

class My_Info_Doctor extends StatelessWidget {
  const My_Info_Doctor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "My Info",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DoctorScreen(),
    );
  }
}

// Common Container Widget for Reusability
class InfoContainer extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const InfoContainer({Key? key, required this.title, required this.children})
      : super(key: key);

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
  @override
  _DoctorScreenState createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  // Doctor's information as variables
  String doctorName = "Dr. Jane Smith";
  String doctorID = "D123456";
  String gender = "Female";
  String dateOfBirth = "January 1, 1980";
  String specialization = "Cardiology";
  String yearsOfExperience = "15 years";
  String contactNumber = "+962795716049";
  String email = "jane.smith@hospital.com";
  String languagesSpoken = "English, Spanish";
  String medicalSchool = "Harvard Medical School";
  String residency = "Cardiology, Massachusetts General Hospital";
  String boardCertification = "American Board of Internal Medicine";
  String specialtyCertification = "American Board of Cardiology";
  String? topDoctorAward = "2018, 2020";
  String? researchPublications = "15 peer-reviewed articles in cardiology";

  double availableBalance = 0;
  double targetBalance = 30000;
  int totalVisits = 0;
  int visitsThisYear = 0;
  int targetVisitsThisYear = 200;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    fetchDoctorData();
    aggregateData();
  }

  // Simulate fetching data for doctor's information from a database
  Future<void> fetchDoctorData() async {
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    setState(() {});
  }

  // Simulate aggregating data from multiple sources
  Future<void> aggregateData() async {
    final List<int> visitsSources = await fetchVisitsFromSources();
    final List<int> visitsThisYearSources = await fetchVisitsThisYearFromSources();
    final List<double> earningsSources = await fetchEarningsFromSources();

    setState(() {
      totalVisits = visitsSources.reduce((a, b) => a + b);
      visitsThisYear = visitsThisYearSources.reduce((a, b) => a + b);
      availableBalance = earningsSources.reduce((a, b) => a + b);
    });
  }

  Future<List<int>> fetchVisitsFromSources() async {
    await Future.delayed(Duration(seconds: 1));
    return [600, 400, 200]; // Simulated data from different hospitals
  }

  Future<List<int>> fetchVisitsThisYearFromSources() async {
    await Future.delayed(Duration(seconds: 1));
    return [75, 50, 25]; // Simulated data from different hospitals
  }

  Future<List<double>> fetchEarningsFromSources() async {
    await Future.delayed(Duration(seconds: 1));
    return [10000.0, 8000.0, 5000.0]; // Simulated earnings from different clinics
  }

  void openEditDialog() {
    // Set initial values for the controllers
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
    double overTarget = availableBalance > targetBalance
        ? availableBalance - targetBalance
        : 0;
    double visitsThisYearPercentage = (visitsThisYear / targetVisitsThisYear) * 100;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Doctor's Portal",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Doctor_Screen()),
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
            // Doctor Information Section with structured details
            InfoContainer(
              title: 'Doctor Information',
              children: [
                Text('Personal Information', style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                )),
                infoRow('Name', doctorName, icon: Icons.person),
                infoRow('Doctor ID', doctorID, icon: Icons.badge),
                infoRow('Gender', gender, icon: Icons.female),
                infoRow('Date of Birth', dateOfBirth, icon: Icons.cake),
                const SizedBox(height: 10),

                infoRow('Specialization', specialization, icon: Icons.favorite),
                infoRow('Years of Experience', yearsOfExperience, icon: Icons.timeline),
                infoRow('Contact Number', contactNumber, icon: Icons.phone),
                infoRow('Email', email, icon: Icons.email, isLongText: true),
                infoRow('Languages Spoken', languagesSpoken, icon: Icons.language),

                const SizedBox(height: 10),
                Text('Education', style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                )),
                infoRow('Medical School', medicalSchool, icon: Icons.school),
                infoRow('Residency', residency, icon: Icons.local_hospital),

                const SizedBox(height: 10),
                Text('Certifications', style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                )),
                infoRow('Board Certification', boardCertification, icon: Icons.verified),
                infoRow('Specialty Certification', specialtyCertification, icon: Icons.verified),

                const SizedBox(height: 10),
                Text('Special Achievements', style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                )),
                if (topDoctorAward != null)
                  infoRow('Top Doctor Award', topDoctorAward!, icon: Icons.star),
                if (researchPublications != null)
                  infoRow('Research Publications', researchPublications!, icon: Icons.book),
              ],
            ),
            const SizedBox(height: 20),
            // New Edit Button
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
                      colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)], // Improved gradient colors
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

  // Helper function for information rows with each item on a new line
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

    final balanceGradient = Paint()
      ..shader = LinearGradient(
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
