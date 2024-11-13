import 'package:flutter/material.dart';
import 'dart:math';

class doctor_insurance_showdetails extends StatelessWidget {
  const doctor_insurance_showdetails({Key? key}) : super(key: key);

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

class DoctorScreen extends StatefulWidget {
  @override
  _DoctorScreenState createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  final _formKey = GlobalKey<FormState>();

  // Editable TextEditingController for all fields
  final TextEditingController doctorNameController = TextEditingController(text: "Dr. Jane Smith");
  final TextEditingController doctorIDController = TextEditingController(text: "D123456");
  final TextEditingController genderController = TextEditingController(text: "Female");
  final TextEditingController dobController = TextEditingController(text: "January 1, 1980");
  final TextEditingController specializationController = TextEditingController(text: "Cardiology");
  final TextEditingController experienceController = TextEditingController(text: "15 years");
  final TextEditingController contactController = TextEditingController(text: "+962795716049");
  final TextEditingController emailController = TextEditingController(text: "jane.smith@hospital.com");
  final TextEditingController languagesController = TextEditingController(text: "English, Spanish");
  final TextEditingController medicalSchoolController = TextEditingController(text: "Harvard Medical School");
  final TextEditingController residencyController = TextEditingController(text: "Cardiology, Massachusetts General Hospital");
  final TextEditingController boardCertificationController = TextEditingController(text: "American Board of Internal Medicine");
  final TextEditingController specialtyCertificationController = TextEditingController(text: "American Board of Cardiology");
  final TextEditingController topDoctorAwardController = TextEditingController(text: "2018, 2020");
  final TextEditingController publicationsController = TextEditingController(text: "15 peer-reviewed articles in cardiology");

  double availableBalance = 0;
  double targetBalance = 30000;
  int totalVisits = 0;
  int visitsThisYear = 0;
  int targetVisitsThisYear = 200;

  @override
  void initState() {
    super.initState();
    fetchDoctorData();
    aggregateData();
  }

  Future<void> fetchDoctorData() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {});
  }

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
    return [600, 400, 200];
  }

  Future<List<int>> fetchVisitsThisYearFromSources() async {
    await Future.delayed(Duration(seconds: 1));
    return [75, 50, 25];
  }

  Future<List<double>> fetchEarningsFromSources() async {
    await Future.delayed(Duration(seconds: 1));
    return [10000.0, 8000.0, 5000.0];
  }

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
          "Doctor's Portal",
          style: TextStyle(color: Colors.white),
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
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              InfoContainer(
                title: 'Earnings Target',
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            buildEditableField("Achieved Balance", availableBalance.toStringAsFixed(2)),
                            buildEditableField("Target Balance", targetBalance.toStringAsFixed(2)),
                            if (overTarget > 0)
                              buildEditableField("Over Target", overTarget.toStringAsFixed(2)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  buildInfoRow('Total Visits', totalVisits.toString()),
                  buildInfoRow('Visits This Year', visitsThisYear.toString()),
                  buildInfoRow('Target Visits This Year', targetVisitsThisYear.toString()),
                  buildInfoRow('Visits This Year %', "${visitsThisYearPercentage.toStringAsFixed(2)}%"),
                ],
              ),
              const SizedBox(height: 20),

              InfoContainer(
                title: 'Doctor Information',
                children: [
                  buildEditableField("Name", doctorNameController.text),
                  buildEditableField("Doctor ID", doctorIDController.text),
                  buildEditableField("Gender", genderController.text),
                  buildEditableField("Date of Birth", dobController.text),
                  buildEditableField("Specialization", specializationController.text),
                  buildEditableField("Experience", experienceController.text),
                  buildEditableField("Contact Number", contactController.text),
                  buildEditableField("Email", emailController.text),
                  buildEditableField("Languages Spoken", languagesController.text),
                ],
              ),
              const SizedBox(height: 20),

              InfoContainer(
                title: 'Education',
                children: [
                  buildEditableField("Medical School", medicalSchoolController.text),
                  buildEditableField("Residency", residencyController.text),
                ],
              ),
              const SizedBox(height: 20),

              InfoContainer(
                title: 'Certifications',
                children: [
                  buildEditableField("Board Certification", boardCertificationController.text),
                  buildEditableField("Specialty Certification", specialtyCertificationController.text),
                ],
              ),
              const SizedBox(height: 20),

              InfoContainer(
                title: 'Special Achievements',
                children: [
                  buildEditableField("Top Doctor Award", topDoctorAwardController.text),
                  buildEditableField("Research Publications", publicationsController.text),
                ],
              ),
              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {});
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Information saved successfully!")),
                      );
                    }
                  },
                  child: const Text("Save Changes"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEditableField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        initialValue: value,
        validator: (value) {
          if (value == null || value.isEmpty) return "Field can't be empty";
          return null;
        },
      ),
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }
}

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
