import 'package:flutter/material.dart';
import 'package:tess/insurance_screen/main.dart';

class My_Info_insurance extends StatelessWidget {
  const My_Info_insurance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "My Info",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: InsuranceRepresentativeScreen(),
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

class InsuranceRepresentativeScreen extends StatefulWidget {
  @override
  _InsuranceRepresentativeScreenState createState() => _InsuranceRepresentativeScreenState();
}

class _InsuranceRepresentativeScreenState extends State<InsuranceRepresentativeScreen> {
  // Representative's information as variables
  String representativeName = "John Doe";
  String representativeID = "IR123456";
  String contactNumber = "+962795716049";
  String email = "john.doe@insurance.com";
  String assignedRegions = "Amman, Irbid, Zarqa";
  String specializedPolicies = "Medical, Dental, Disability";
  String certifications = "Certified Insurance Specialist";
  int yearsOfExperience = 5;
  int claimsHandled = 150;
  double approvalRate = 85.0; // percentage
  int pendingClaims = 12;
  String supervisorName = "Sarah Johnson";
  String awards = "Top Performer 2022, Customer Satisfaction 2023";

  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  // Simulate fetching data from a database
  Future<void> fetchData() async {
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    setState(() {});
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Insurance Representative's Portal",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InsuranceRep_Screen(),
            ),
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
              title: 'Performance Metrics',
              children: [
                infoRow('Claims Handled', claimsHandled.toString(), icon: Icons.task),
                infoRow('Approval Rate', "$approvalRate%", icon: Icons.check_circle),
                infoRow('Pending Claims', pendingClaims.toString(), icon: Icons.pending_actions),
              ],
            ),
            const SizedBox(height: 20),
            InfoContainer(
              title: 'Representative Information',
              children: [
                infoRow('Name', representativeName, icon: Icons.person),
                infoRow('Representative ID', representativeID, icon: Icons.badge),
                infoRow('Contact Number', contactNumber, icon: Icons.phone),
                infoRow('Email', email, icon: Icons.email, isLongText: true),
                infoRow('Assigned Regions', assignedRegions, icon: Icons.map),
                infoRow('Specialized Policies', specializedPolicies, icon: Icons.policy),
                infoRow('Certifications', certifications, icon: Icons.verified),
                infoRow('Years of Experience', yearsOfExperience.toString(), icon: Icons.timeline),
                infoRow('Direct Supervisor', supervisorName, icon: Icons.supervisor_account),
              ],
            ),
            const SizedBox(height: 20),
            InfoContainer(
              title: 'Achievements',
              children: [
                infoRow('Company Awards', awards, icon: Icons.emoji_events),
              ],
            ),
            const SizedBox(height: 20),
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
