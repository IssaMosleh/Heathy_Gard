import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart' as intl;
import 'package:tess/admin_screen/add_new_users/add_new_main.dart';
import 'package:tess/admin_screen/edit_profiles/patient/patient_insirance_main.dart';

class patient_add extends StatefulWidget {
  const patient_add({super.key});

  @override
  State<patient_add> createState() => _PatientProfileInsuranceState();
}

class _PatientProfileInsuranceState extends State<patient_add> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Variables for Insurance Balance
  final TextEditingController availableBalanceController = TextEditingController(text: "");
  final TextEditingController totalBalanceController = TextEditingController(text: "");

  // Variables for Personal Information
  final TextEditingController firstNameController = TextEditingController(text: "");
  final TextEditingController middleNameController = TextEditingController(text: "");
  final TextEditingController lastNameController = TextEditingController(text: "");
  final TextEditingController dateOfBirthController = TextEditingController(text: "");
  final TextEditingController emailController = TextEditingController(text: "");
  final TextEditingController phoneController = TextEditingController(text: "");
  final TextEditingController addressController = TextEditingController(text: "");

  // Variables for Insurance Information
  final TextEditingController insuranceNameController = TextEditingController(text: "");
  final TextEditingController memberIdController = TextEditingController(text: "");
  final TextEditingController familyIdController = TextEditingController(text: "");
  final TextEditingController policyNumberController = TextEditingController(text: "");
  final TextEditingController groupNumberController = TextEditingController(text: "");
  final TextEditingController patientCopayController = TextEditingController(text: "");

  // Variables for Membership Status
  final TextEditingController coverageStartController = TextEditingController(text: "");
  final TextEditingController coverageEndController = TextEditingController(text: "");
  final TextEditingController renewalDateController = TextEditingController(text: "");

  // Variables for Additional Information
  final TextEditingController primaryCarePhysicianController = TextEditingController(text: "");
  final TextEditingController emergencyContactNameController = TextEditingController(text: "");
  final TextEditingController emergencyContactPhoneController = TextEditingController(text: "");

  // Method to determine membership status
  String getMembershipStatus() {
    if (coverageEndController.text.isEmpty) return "Unknown";
    DateTime currentDate = DateTime.now();
    DateTime endDate = intl.DateFormat("MM/dd/yyyy").parse(coverageEndController.text);
    return currentDate.isBefore(endDate) ? "Active" : "Inactive";
  }

  // Format today's date for display
  String getTodayDate() {
    DateTime currentDate = DateTime.now();
    return intl.DateFormat("MM/dd/yyyy").format(currentDate);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const add_new_main(),
                ),
              );
            },
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
          centerTitle: true,
          title: const Text("Insurance Center", style: TextStyle(color: Colors.white)),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Insurance Balance Section
                buildContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Insurance Balance", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const Divider(),
                      editableBalanceField("Available Balance", availableBalanceController, "Enter available balance"),
                      editableBalanceField("Total Balance", totalBalanceController, "Enter total balance"),
                      const SizedBox(height: 20),
                      BalanceMeter(
                        balance: calculateBalancePercentage(),
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
                      const Text("Personal Information", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const Divider(),
                      editableField("First Name", firstNameController, (value) => value!.isEmpty ? 'First name is required' : null),
                      editableField("Middle Name", middleNameController, null),
                      editableField("Last Name", lastNameController, (value) => value!.isEmpty ? 'Last name is required' : null),
                      editableField("Date of Birth", dateOfBirthController, (value) => value!.isEmpty ? 'Date of birth is required' : null),
                      editableField("Email", emailController, (value) => !RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!) ? 'Enter a valid email' : null),
                      editableField("Phone", phoneController, (value) => !RegExp(r"^\+?[0-9]{7,15}$").hasMatch(value!) ? 'Enter a valid phone number' : null),
                      editableField("Address", addressController, null, isLongText: true),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Insurance Information Section
                buildContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Insurance Information", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const Divider(),
                      editableField("Insurance Name", insuranceNameController, (value) => value!.isEmpty ? 'Insurance name is required' : null),
                      editableField("Member ID", memberIdController, (value) => value!.isEmpty ? 'Member ID is required' : null),
                      editableField("Policy Number", policyNumberController, (value) => value!.isEmpty ? 'Policy number is required' : null),
                      editableField("Group Number", groupNumberController, (value) => value!.isEmpty ? 'Group number is required' : null),
                      editableField("Co-pay", patientCopayController, (value) => value!.isEmpty ? 'Co-pay is required' : null),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Membership Status Section
                buildContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Membership Status", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const Divider(),
                      infoRow("Today's Date", getTodayDate()),
                      infoRow("Status", getMembershipStatus()),
                      editableField("Coverage Start", coverageStartController, (value) => value!.isEmpty ? 'Coverage start date is required' : null),
                      editableField("Coverage End", coverageEndController, (value) => value!.isEmpty ? 'Coverage end date is required' : null),
                      editableField("Renewal Date", renewalDateController, (value) => value!.isEmpty ? 'Renewal date is required' : null),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Additional Information Section
                buildContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Additional Information", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const Divider(),
                      editableField("Primary Care Physician", primaryCarePhysicianController, (value) => value!.isEmpty ? 'Primary care physician is required' : null),
                      editableField("Emergency Contact Name", emergencyContactNameController, (value) => value!.isEmpty ? 'Emergency contact name is required' : null),
                      editableField("Emergency Contact Phone", emergencyContactPhoneController, (value) => !RegExp(r"^\+?[0-9]{7,15}$").hasMatch(value!) ? 'Enter a valid emergency contact phone number' : null),
                    ],
                  ),
                ),

                // Save Button
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Saved Successfully")));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const add_new_main(),
                        ),
                      );
                    }
                  },
                  child: const Text("Save Changes"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget editableField(String label, TextEditingController controller, String? Function(String?)? validator, {bool isLongText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: validator,
        maxLines: isLongText ? null : 1,
      ),
    );
  }

  Widget editableBalanceField(String label, TextEditingController controller, String errorMessage) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return errorMessage;
          } else if (double.tryParse(value) == null) {
            return 'Enter a valid number';
          }
          return null;
        },
        onChanged: (value) {
          setState(() {}); // Trigger a rebuild to update balance meter
        },
      ),
    );
  }

  double calculateBalancePercentage() {
    double availableBalance = double.tryParse(availableBalanceController.text) ?? 0;
    double totalBalance = double.tryParse(totalBalanceController.text) ?? 1;
    double percentage = (availableBalance / totalBalance) * 100;
    return percentage > 100 ? 100 : percentage; // Limit to 100%
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

  Widget infoRow(String label, String value) {
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
      textAlign: TextAlign.center,
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
